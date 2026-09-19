unit npl;

{$I npl.inc}

interface

uses
  classes
  ,SysUtils
  ,Windows
  ;

//copiado da unit SynCommon.pas (projeto mORMot: https://github.com/synopse/mormot) 
{$ifdef DELPHI5OROLDER}
  // Delphi 5 doesn't have those basic types defined :(
const
  varShortInt = $0010;
  varInt64 = $0014; { vt_i8 }
  soBeginning = soFromBeginning;
  soCurrent = soFromCurrent;
  reInvalidPtr = 2;
  PathDelim  = '\';
  sLineBreak = #13#10;

type
  PPointer = ^Pointer;
  PPAnsiChar = ^PAnsiChar;
  PInteger = ^Integer;
  PCardinal = ^Cardinal;
  PByte = ^Byte;
  PWord = ^Word;
  PBoolean = ^Boolean;
  PDouble = ^Double;
  PComp = ^Comp;
  THandle = LongWord;
  PVarData = ^TVarData;
  TVarData = packed record
    // mostly used for varNull, varInt64, varDouble, varString and varAny
    VType: word;
    case Integer of
      0: (Reserved1: Word;
          case Integer of
            0: (Reserved2, Reserved3: Word;
                case Integer of
                  varSmallInt: (VSmallInt: SmallInt);
                  varInteger:  (VInteger: Integer);
                  varSingle:   (VSingle: Single);
                  varDouble:   (VDouble: Double);     // DOUBLE
                  varCurrency: (VCurrency: Currency);
                  varDate:     (VDate: TDateTime);
                  varOleStr:   (VOleStr: PWideChar);
                  varDispatch: (VDispatch: Pointer);
                  varError:    (VError: HRESULT);
                  varBoolean:  (VBoolean: WordBool);
                  varUnknown:  (VUnknown: Pointer);
                  varByte:     (VByte: Byte);
                  varInt64:    (VInt64: Int64);      // INTEGER
                  varString:   (VString: Pointer);   // TEXT
                  varAny:      (VAny: Pointer);
                  varArray:    (VArray: PVarArray);
                  varByRef:    (VPointer: Pointer);
               );
            1: (VLongs: array[0..2] of LongInt); );
  end;
{$else}
{$ifndef FPC}
type
  // redefined here to not use the wrong definitions from Windows.pas
  PWord = System.PWord;
  PSingle = System.PSingle;
{$endif FPC}
{$endif DELPHI5OROLDER}

{$ifdef DELPHI5OROLDER}
const
  E_NOINTERFACE = HRESULT($80004002);
{$endif DELPHI5OROLDER}

type
  int8    = shortint;
  int16   = smallint;
  int32   = integer;
  sint8   = int8;
  sint16  = int16;
  sint32  = int32;
  sint64  = int64;
  uint8   = byte;
  uint16  = word;
  uint32  = longword;
  sbyte   = shortint;
  ubyte   = byte;
  short   = smallint;
  ushort  = word;
  int     = integer;
  uint    = longword;
  long    = int64;
  money   = currency;
  float   = single;
  nchar   = widechar;
  nstring = widestring;

  //array types
  stringarr   = array of string;
  nstringarr  = array of nstring;
  chararr     = array of char;
  nchararr    = array of nchar;
  booleanarr  = array of boolean;
  int8arr     = array of int8;
  int16arr    = array of int16;
  int32arr    = array of int32;
  sint8arr    = array of sint8;
  sint16arr   = array of sint16;
  sint32arr   = array of sint32;
  sint64arr   = array of sint64;
  uint8arr    = array of uint8;
  uint16arr   = array of uint16;
  uint32arr   = array of uint32;
  sbytearr    = array of sbyte;
  ubytearr    = array of ubyte;
  shortarr    = array of short;
  ushortarr   = array of ushort;
  intarr      = array of int;
  uintarr     = array of uint;
  longarr     = array of long;
  pointerarr  = array of pointer;
  currencyarr = array of currency;
  moneyarr    = array of money;
  comparr     = array of comp;
  singlearr   = array of single;
  floatarr    = array of float;
  doublearr   = array of double;
  extendedarr = array of extended;
  real48arr   = array of real48;

  basetype = (t_sbyte,t_ubyte,t_short,t_ushort,t_int,t_uint,t_long,//t_ulong,
    t_float,t_double,t_money,
    t_boolean,t_char,t_nchar,
    t_string,t_nstring);

  union = record
    case integer of
      1:  (sbyteValue   : sbyte);
      2:  (ubyteValue   : ubyte);
      3:  (shortValue   : short);
      4:  (ushortValue  : ushort);
      5:  (intValue     : int);
      6:  (uintValue    : uint);
      7:  (longValue    : long);
    //8:  (ulongValue   : ulong);
      8:  (floatValue   : float);
      9:  (doubleValue  : double);
      10: (moneyValue   : money);
      11: (booleanValue : boolean);
      12: (charValue    : char);
      13: (ncharValue   : nchar);
  end;

{$M+}
  NPLObject=class
  public
    class function unitName : ansistring;
    class function qualifiedClassName : ansistring;
    function equals(obj :TObject) : boolean; virtual;
    function hashCode : int; virtual;
    function toString : string; virtual;
  end;
{$M-}

  NPLClass = class of NPLObject;

  NPLInterfacedObject = class(NPLObject, {$IFDEF DELPHI5OROLDER}IUnknown{$ELSE}IInterface{$ENDIF})
  protected
    FRefCount: Integer;
    function QueryInterface(const IID : TGUID; out Obj) : HResult; stdcall;
    function _AddRef : Integer; stdcall;
    function _Release : Integer; stdcall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance : TObject; override;
    property RefCount : Integer read FRefCount;
  end;

  NPLInterfacedObjectClass = class of NPLInterfacedObject;

  NPLException=class(Exception);

  NPLExceptionClass = class of NPLException;

  IllegalArgumentException = class(NPLException);

  IllegalArgumentExceptionClass = class of IllegalArgumentException;

  IndexOutOfBoundsException = class(NPLException);

  IndexOutOfBoundsExceptionClass = class of IndexOutOfBoundsException;

  ArrayIndexOutOfBoundsException = class(IndexOutOfBoundsException);

  ArrayIndexOutOfBoundsExceptionClass = class of ArrayIndexOutOfBoundsException;

  NumberFormatException = class(IllegalArgumentException);

  NumberFormatExceptionClass = class of NumberFormatException;

  UnsupportedOperationException = class(NPLException);

  UnsupportedOperationExceptionClass = class of UnsupportedOperationException;

  NPLNumber = class(NPLObject)
  private
    fValue : union;
  public
    function sbyteValue : sbyte; virtual;
    function shortValue : short; virtual;
    function intValue : int; virtual;
    function longValue : long; virtual;
    function floatValue : float; virtual;
    function doubleValue : double; virtual;
  end;

  NPLNumberClass = class of NPLNumber;

  NPLSByte = class(NPLNumber)
  public
    constructor create(aValue : sbyte);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherByte : NPLSByte) : int;
    function hashCode : int; override;
    class function compare(x, y : sbyte) : int;
    property value : sbyte read fValue.sbyteValue write fValue.sbyteValue;
  end;

  NPLSByteClass = class of NPLSByte;

  NPLShort = class(NPLNumber)
  public
    constructor create(aValue : short);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherShort : NPLShort) : int;
    function hashCode : int; override;
    class function compare(x, y : short) : int;
    class function reverseBytes(i : short) : short;
    property value : short read fValue.shortValue write fValue.shortValue;
  end;

  NPLShortClass = class of NPLShort;

  NPLInteger = class(NPLNumber)
  public
    constructor create(aValue : int);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherInteger : NPLInteger) : int;
    function hashCode : int; override;
    class function compare(x, y : int) : int;
    property value : int read fValue.intValue write fValue.intValue;
  end;

  NPLIntegerClass = class of NPLInteger;

  NPLLong = class(NPLNumber)
  public
    constructor create(aValue : long);
    function equals(obj : TObject) : boolean; override;
    function hashCode : int; override;
    property value : long read fValue.longValue write fValue.longValue;
  end;

  NPLLongClass = class of NPLLong;

  NPLFloat = class(NPLNumber)
  public
    constructor create(aValue : float);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherFloat : NPLFloat) : int;
    function isNaN : boolean; overload;
    function isInfinite : boolean; overload;
    function hashCode : int; override;
    class function floatToRawIntBits(value : float) : int;
    class function intBitsToFloat(bits : int) : float;
    class function isNaN(v : float) : boolean; overload;
    class function isInfinite(v : float) : boolean; overload;
    class function floatToIntBits(value : float) : int;
    class function compare(f1, f2 : float) : int;
    property value : float read fValue.floatValue write fValue.floatValue;
  end;

  NPLFloatClass = class of NPLFloat;

  NPLDouble = class(NPLNumber)
  public
    constructor create(aValue : double);
    function equals(obj : TObject) : boolean; override;
    property value : double read fValue.doubleValue write fValue.doubleValue;
  end;

  NPLDoubleClass = class of NPLDouble;

  NPLBoolean = class(NPLObject)
  private
    fValue : boolean;
  public
    constructor create(aValue : boolean);
    function equals(obj : TObject) : boolean; override;
    property value : boolean read fValue write fValue;
  end;

  NPLBooleanClass = class of NPLBoolean;

  NPLString = class(NPLObject)
  private
    fValue : string;
  public
    constructor create(aValue : string);
    function equals(obj : TObject) : boolean; override;
    property value : string read fValue write fValue;
  end;

  NPLStringClass = class of NPLString;

  NPLChar = class(NPLObject)
  private
    fValue : char;
  public
    constructor create(aValue : char);
    function equals(obj : TObject) : boolean; override;
    property value : char read fValue write fValue;
  end;

  NPLCharClass = class of NPLChar;


function signedRightShift(value, bits : int): int; overload;
function signedRightShift(value : long; bits : int): long; overload;

implementation

uses
  npl_Float
  ,npl_misc_FloatConsts
  ,typInfo
  ;

function signedRightShift(value, bits : int): int;
begin
  if bits = 0 then
    result := value
  else if bits >= 32 then
  begin
    if value < 0 then
      result := -1
    else
      result := 0;
  end
  else
  begin
    result := value shr bits;
    if value < 0 then
      result := result or (int($FFFFFFFF) shl (32 - bits));
  end;
end;

function signedRightShift(value : long; bits : int): long;
begin
  if bits = 0 then
    result := value
  else if bits >= 64 then
  begin
    if value < 0 then
      result := -1
    else
      result := 0;
  end
  else
  begin
    result := value shr bits;
    if value < 0 then
      result := result or
        (long($FFFFFFFFFFFFFFFF) shl (64 - bits));
  end;
end;

class function NPLObject.unitName : ansistring;
var
  typeInfo : PTypeInfo;
  typeData : PTypeData;
begin
  result := '';
  typeInfo := classInfo;
  if typeInfo<>nil then begin
    typeData := getTypeData(typeInfo);
    if typeData<>nil then
      if typeInfo^.kind = tkClass then
        result := typeData^.unitName;
  end;
end;

class function NPLObject.qualifiedClassName : ansistring;
var
  uname : ansistring;
begin
  uname := unitName;
  if uname='' then
    result:=className
  else
    result:=concat(uname, '.', className);
end;

function NPLObject.equals(obj : TObject) : boolean;
begin
  result:=obj=self;
end;

function NPLObject.hashCode : int;
begin
  result := int(self);
end;

function NPLObject.toString : string;
begin
  result := format('%s@%s', [qualifiedClassName, lowerCase(intToHex(integer(self), 8))]);
end;

procedure NPLInterfacedObject.AfterConstruction;
begin
  InterlockedDecrement(FRefCount);
end;

procedure NPLInterfacedObject.BeforeDestruction;
begin
  if RefCount <> 0 then
    System.RunError(2);
end;

class function NPLInterfacedObject.NewInstance : TObject;
begin
  result := inherited NewInstance;
  NPLInterfacedObject(result).FRefCount := 1;
end;

function NPLInterfacedObject.QueryInterface(const IID : TGUID; out Obj) : HResult;
begin
  if GetInterface(IID, Obj) then
    result := 0
  else
    result := E_NOINTERFACE;
end;

function NPLInterfacedObject._AddRef : Integer;
begin
  result := InterlockedIncrement(FRefCount);
end;

function NPLInterfacedObject._Release : Integer;
begin
  result := InterlockedDecrement(FRefCount);
  if result = 0 then
    Destroy;
end;

function NPLNumber.sbyteValue : sbyte;
begin
  result := fValue.sbyteValue;
end;

function NPLNumber.shortValue : short;
begin
  result := fValue.shortValue;
end;

function NPLNumber.intValue : int;
begin
  result := fValue.intValue;
end;

function NPLNumber.longValue : long;
begin
  result := fValue.longValue;
end;

function NPLNumber.floatValue : float;
begin
  result := fValue.floatValue;
end;

function NPLNumber.doubleValue : double;
begin
  result := fValue.doubleValue;
end;

constructor NPLSByte.create(aValue : sbyte);
begin
  fValue.sbyteValue := aValue;
end;

function NPLSByte.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLSByte) then
    exit;
  result := fValue.sbyteValue=NPLSByte(obj).fValue.sbyteValue;
end;

function NPLSByte.compareTo(anotherByte : NPLSByte) : int;
begin
  result := NPLSByte.compare(self.fValue.sbyteValue, anotherByte.fValue.sbyteValue);
end;

function NPLSByte.hashCode : int;
begin
  result := int(fValue.sbyteValue);
end;

class function NPLSByte.compare(x, y : sbyte) : int;
begin
  result := x-y;
end;

constructor NPLShort.create(aValue : short);
begin
  fValue.shortValue := aValue;
end;

function NPLShort.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLShort) then
    exit;
  result := fValue.shortValue=NPLShort(obj).fValue.shortValue;
end;

function NPLShort.compareTo(anotherShort : NPLShort) : int;
begin
  result := NPLShort.compare(self.fValue.shortValue, anotherShort.fValue.shortValue);
end;

function NPLShort.hashCode : int;
begin
  result := int(fValue.shortValue);
end;

class function NPLShort.compare(x, y : short) : int;
begin
  result := x-y;
end;

class function NPLShort.reverseBytes(i : short) : short;
begin
  result := short(short(signedRightShift(i and $FF00, 8)) or (i shl 8));
end;

constructor NPLInteger.create(aValue : int);
begin
  fValue.intValue := aValue;
end;

function NPLInteger.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLInteger) then
    exit;
  result := fValue.intValue=NPLInteger(obj).fValue.intValue;
end;

function NPLInteger.compareTo(anotherInteger : NPLInteger) : int;
begin
  result := NPLInteger.compare(self.fValue.intValue, anotherInteger.fValue.intValue);
end;

function NPLInteger.hashCode : int;
begin
  result := fValue.intValue;
end;

class function NPLInteger.compare(x, y : int) : int;
begin
  if x < y then
    result := -1
  else if x = y then
    result := 0
  else
    result := 1;
end;

constructor NPLLong.create(aValue : long);
begin
  fValue.longValue := aValue;
end;

function NPLLong.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLLong) then
    exit;
  result := fValue.longValue=NPLLong(obj).fValue.longValue;
end;

function NPLLong.hashCode : int;
begin
  result := int(fValue.longValue xor (fValue.longValue shr 32));
end;

constructor NPLFloat.create(aValue : float);
begin
  fValue.floatValue := aValue;
end;

function NPLFloat.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLFloat) then
    exit;
  result := NPLFloat.floatToIntBits(self.fValue.floatValue)=NPLFloat.floatToIntBits(NPLFloat(obj).fValue.floatValue);
end;

function NPLFloat.compareTo(anotherFloat : NPLFloat) : int;
begin
  result := NPLFloat.compare(self.fValue.floatValue, anotherFloat.fValue.floatValue);
end;

function NPLFloat.isNaN : boolean;
begin
  result := NPLFloat.isNaN(fValue.floatValue);
end;

function NPLFloat.isInfinite : boolean;
begin
  result := NPLFloat.isInfinite(fValue.floatValue);
end;

function NPLFloat.hashCode : int;
begin
  result := NPLFloat.floatToIntBits(fValue.floatValue);
end;

class function NPLFloat.floatToRawIntBits(value : float) : int;
var
  u : union;
begin
  u.floatValue := value;
  result := u.intValue;
end;

class function NPLFloat.intBitsToFloat(bits : int) : float;
var
  u : union;
begin
  u.intValue := long(bits);
  result := u.floatValue;
end;

class function NPLFloat.isNaN(v : float) : boolean;
var
  bits: int;
begin
  bits := floatToRawIntBits(v);
  result := ((bits and $7F800000) = $7F800000) and ((bits and $007FFFFF) <> 0);
end;

class function NPLFloat.isInfinite(v : float) : boolean;
begin
  result := (v = npl_Float.POSITIVE_INFINITY) or (v = npl_Float.NEGATIVE_INFINITY);
end;

class function NPLFloat.floatToIntBits(value : float) : int;
begin
  result := floatToRawIntBits(value);
  if ((result and npl_misc_FloatConsts.EXP_BIT_MASK) = npl_misc_FloatConsts.EXP_BIT_MASK) and
      ((result and npl_misc_FloatConsts.SIGNIF_BIT_MASK) <> 0) then
      result := $7fc00000;
end;

class function NPLFloat.compare(f1, f2 : float) : int;
var
  thisBits, anotherBits : int;
begin
  if f1 < f2 then begin
    result := -1;
    exit;
  end;

  if f1 > f2 then begin
    result := 1;
    exit;
  end;

  thisBits := NPLFloat.floatToIntBits(f1);
  anotherBits := NPLFloat.floatToIntBits(f2);

  if thisBits = anotherBits then
    result := 0
  else if thisBits < anotherBits then
    result := -1
  else
    result := 1;
end;

constructor NPLDouble.create(aValue : double);
begin
  fValue.doubleValue := aValue;
end;

function NPLDouble.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLDouble) then
    exit;
  result := fValue.doubleValue=NPLDouble(obj).fValue.doubleValue;
end;

constructor NPLBoolean.create(aValue : boolean);
begin
  fValue := aValue;
end;

function NPLBoolean.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLBoolean) then
    exit;
  result := fValue=NPLBoolean(obj).fValue;
end;

constructor NPLString.create(aValue : string);
begin
  fValue := aValue;
end;

function NPLString.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLString) then
    exit;
  result := fValue=NPLString(obj).fValue;
end;

constructor NPLChar.create(aValue : char);
begin
  fValue := aValue;
end;

function NPLChar.equals(obj : TObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLChar) then
    exit;
  result := fValue=NPLChar(obj).fValue;
end;

end.
