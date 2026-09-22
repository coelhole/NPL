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
  S_OK = 0;
  S_FALSE = $00000001;
  E_NOINTERFACE = HRESULT($80004002);
  E_UNEXPECTED = HRESULT($8000FFFF);
  E_NOTIMPL = HRESULT($80004001);
{$endif DELPHI5OROLDER}

type
  bool    = boolean;
  int8    = shortint;
  int16   = smallint;
  int32   = integer;
  sint8   = int8;
  sint16  = int16;
  sint32  = int32;
  sint64  = int64;
  uint8   = byte;
  uint16  = word;
  uint32  = cardinal;
  sbyte   = shortint;
  ubyte   = byte;
  short   = smallint;
  ushort  = word;
  int     = int32;
  uint    = uint32;
  long    = int64;
  dword   = cardinal;
  money   = currency;
  float   = single;
  decimal = extended;
  wchar   = widechar;
  wstring = widestring;
  nchar   = wchar;
  nstring = wstring;
{$IFDEF CPU64}
  nint    = long;
{$ELSE}
  nint    = int;
  nuint   = uint;
{$ENDIF}

  //array types
  stringarr   = array of string;
  wstringarr  = array of wstring;
  nstringarr  = array of nstring;
  chararr     = array of char;
  wchararr    = array of wchar;
  nchararr    = array of nchar;
  booleanarr  = array of boolean;
  boolarr     = array of bool;
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
  wordarr     = array of word;
  dwordarr    = array of dword;
  pointerarr  = array of pointer;
  currencyarr = array of currency;
  moneyarr    = array of money;
  comparr     = array of comp;
  singlearr   = array of single;
  floatarr    = array of float;
  doublearr   = array of double;
  extendedarr = array of extended;
  decimalarr  = array of decimal;
  realarr     = array of real;
  real48arr   = array of real48;
  nintarr     = array of nint;
{$IFNDEF CPU64}
  nuintarr    = array of nuint;
{$ENDIF}

  basetype = (t_sbyte,t_ubyte,t_short,t_ushort,t_int,t_uint,t_long,//t_ulong,
    t_float,t_double,t_money,
    t_boolean,t_char,t_wchar,
    t_string,t_wstring);

  union = record
    case integer of
      1:  (sbyteValue   : sbyte);
      2:  (ubyteValue   : ubyte);
      3:  (shortValue   : short);
      4:  (ushortValue  : ushort);
      5:  (intValue     : int);
      6:  (uintValue    : uint);
      7:  (longValue    : long);
      8:  (floatValue   : float);
      9:  (doubleValue  : double);
      10: (decimalValue : decimal);
      11: (moneyValue   : money);
      12: (booleanValue : boolean);
      13: (charValue    : char);
      14: (wcharValue   : wchar);
  end;

{$M+}
  NPLObject=class(TObject, {$IFDEF DELPHI5OROLDER}IUnknown{$ELSE}{$IFDEF FPC}IUnknown{$ELSE}IInterface{$ENDIF}{$ENDIF})
  protected
    function QueryInterface({$IFDEF FPC}{$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF}{$ELSE}const{$ENDIF} IID : TGUID; out Obj) : {$IFDEF FPC}longint; virtual; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}HResult; virtual; stdcall;{$ENDIF}
    function _AddRef : {$IFDEF FPC}longint; virtual; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}Integer; virtual; stdcall;{$ENDIF}
    function _Release : {$IFDEF FPC}longint; virtual; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}Integer; virtual; stdcall;{$ENDIF}
  public
    class function unitName : ansistring;
    class function qualifiedClassName : ansistring;
    function equals(obj :TObject) : boolean; {$IFDEF FPC}override;{$ELSE}virtual;{$ENDIF}
    function hashCode : int; virtual;
    function toString : string; {$IFDEF FPC}reintroduce; {$ENDIF}virtual;
  end;
{$M-}

  NPLClass = class of NPLObject;

  NPLInterfacedObject = class(NPLObject)
  protected
    fRefCount : {$IFDEF FPC}longint{$ELSE}Integer{$ENDIF};  
    function _AddRef : {$IFDEF FPC}longint; override; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}Integer; override; stdcall;{$ENDIF}
    function _Release : {$IFDEF FPC}longint; override; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}Integer; override; stdcall;{$ENDIF}
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance : TObject; override;
    property RefCount : {$IFDEF FPC}longint{$ELSE}Integer{$ENDIF} read fRefCount;
  end;

  NPLInterfacedClass = class of NPLInterfacedObject;

  NPLException=class(Exception);

  NPLExceptionClass = class of NPLException;

  NilPointerException = class(NPLException);

  NilPointerExceptionClass = class of NilPointerException;

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

  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Comparable<T>{$ELSE}Comparable{$ENDIF} = interface
    ['{6EBC1ADC-027E-4B7B-AA27-88D8F2D1CC17}']
    function compareTo(o : {$IFDEF GENERICS}T{$ELSE}NPLObject{$ENDIF}) : int;
  end;

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

  NPLSByte = class;
  NPLShort = class;
  NPLInteger = class;
  NPLLong = class;
  NPLFloat = class;
  NPLDouble = class;          

  NPLSByte = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLSByte>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : sbyte);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherByte : {$IFDEF GENERICS}NPLSByte{$ELSE}NPLObject{$ENDIF}) : int;
    function hashCode : int; override;
    class function compare(x, y : sbyte) : int;
    property value : sbyte read fValue.sbyteValue write fValue.sbyteValue;
  end;

  NPLSByteClass = class of NPLSByte;

  NPLShort = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLShort>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : short);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherShort : {$IFDEF GENERICS}NPLShort{$ELSE}NPLObject{$ENDIF}) : int;
    function hashCode : int; override;
    class function compare(x, y : short) : int;
    class function reverseBytes(i : short) : short;
    property value : short read fValue.shortValue write fValue.shortValue;
  end;

  NPLShortClass = class of NPLShort;

  NPLInteger = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLInteger>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : int);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherInteger : {$IFDEF GENERICS}NPLInteger{$ELSE}NPLObject{$ENDIF}) : int;
    function hashCode : int; override;
    class function compare(x, y : int) : int;
    property value : int read fValue.intValue write fValue.intValue;
  end;

  NPLIntegerClass = class of NPLInteger;

  NPLLong = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLLong>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : long);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherLong : {$IFDEF GENERICS}NPLLong{$ELSE}NPLObject{$ENDIF}) : int;
    function hashCode : int; override;
    class function compare(x, y : long) : int;
    class function highestOneBit(i : long) : long;
    class function lowestOneBit(i : long) : long;
    class function numberOfLeadingZeros(i : long) : int;
    class function numberOfTrailingZeros(i : long) : int;
    class function bitCount(i : long) : int;
    class function rotateLeft(i : long; distance : int) : long;
    class function rotateRight(i : long; distance : int) : long;
    class function reverse(i : long) : long;
    class function signum(i : long) : int;
    class function reverseBytes(i : long) : long;
    property value : long read fValue.longValue write fValue.longValue;
  end;

  NPLLongClass = class of NPLLong;

  NPLFloat = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLFloat>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : float);
    function equals(obj : TObject) : boolean; override;
    function compareTo(anotherFloat : {$IFDEF GENERICS}NPLFloat{$ELSE}NPLObject{$ENDIF}) : int;
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
{$IFDEF CPU64}
  result := int(nint(self) xor (nint(self) shr 32));
{$ELSE}
  result := int(self);
{$ENDIF}
end;

function NPLObject.toString : string;
begin
  result := format('%s@%s', [qualifiedClassName, lowerCase(intToHex(hashCode, 8))]);
end;

function NPLObject.QueryInterface({$IFDEF FPC}{$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF}{$ELSE}const{$ENDIF} IID : TGUID; out Obj) : {$IFDEF FPC}longint;{$ELSE}HResult;{$ENDIF}
begin
  if GetInterface(IID, Obj) then
    result := 0
  else
    result := E_NOINTERFACE;
end;

function NPLObject._AddRef : {$IFDEF FPC}longint;{$ELSE}Integer;{$ENDIF}
begin
end;

function NPLObject._Release : {$IFDEF FPC}longint;{$ELSE}Integer;{$ENDIF}
begin
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

function NPLInterfacedObject._AddRef : {$IFDEF FPC}longint;{$ELSE}Integer;{$ENDIF}
begin
  result := InterlockedIncrement(FRefCount);
end;

function NPLInterfacedObject._Release : {$IFDEF FPC}longint;{$ELSE}Integer;{$ENDIF}
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

function NPLSByte.compareTo(anotherByte : {$IFDEF GENERICS}NPLSByte{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if anotherByte=NIL then
    raise NilPointerException.create('anotherByte');

  {$IFNDEF GENERICS}
  if not (anotherByte is NPLSByte) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLSByte.compare(self.fValue.sbyteValue, NPLSByte(anotherByte).fValue.sbyteValue);
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

function NPLShort.compareTo(anotherShort : {$IFDEF GENERICS}NPLShort{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if anotherShort=NIL then
    raise NilPointerException.create('anotherShort');

  {$IFNDEF GENERICS}
  if not (anotherShort is NPLShort) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLShort.compare(self.fValue.shortValue, NPLShort(anotherShort).fValue.shortValue);
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

function NPLInteger.compareTo(anotherInteger : {$IFDEF GENERICS}NPLInteger{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if anotherInteger=NIL then
    raise NilPointerException.create('anotherInteger');

  {$IFNDEF GENERICS}
  if not (anotherInteger is NPLInteger) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLInteger.compare(self.fValue.intValue, NPLInteger(anotherInteger).fValue.intValue);
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

function NPLLong.compareTo(anotherLong : {$IFDEF GENERICS}NPLLong{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if anotherLong=NIL then
    raise NilPointerException.create('anotherLong');

  {$IFNDEF GENERICS}
  if not (anotherLong is NPLLong) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLLong.compare(self.fValue.longValue, NPLLong(anotherLong).fValue.longValue);
end;

function NPLLong.hashCode : int;
begin
  result := int(fValue.longValue xor (fValue.longValue shr 32));
end;

class function NPLLong.compare(x, y : long) : int;
begin
  if x < y then
    result := -1
  else if x = y then
    result := 0
  else
    result := 1;
end;

class function NPLLong.highestOneBit(i : long) : long;
  function sRightShift(value : long; bits : int) : long;
  begin
    result := value shr bits;
    if value < 0 then
      result := result or
        (long($FFFFFFFFFFFFFFFF) shl (64 - bits));
  end;
begin
  i := i or sRightShift(i, 1);
  i := i or sRightShift(i, 2);
  i := i or sRightShift(i, 4);
  i := i or sRightShift(i, 8);
  i := i or sRightShift(i, 16);
  i := i or sRightShift(i, 32);
  result := i - (i shr 1);
end;

class function NPLLong.lowestOneBit(i : long) : long;
begin
  result := i and -i;  
end;

class function NPLLong.numberOfLeadingZeros(i : long) : int;
var
  x : int;
begin
  if i = 0 then begin
    result := 64;
    exit;
  end;

  result := 1;
  x := int(i shr 32);

  if x = 0 then begin
    result := result + 32;
    x := int(i);
  end;

  if (x shr 16) = 0 then begin
    result := result + 16;
    x := x shl 16;
  end;

  if (x shr 24) = 0 then begin
    result := result + 8;
    x := x shl 8;
  end;

  if (x shr 28) = 0 then begin
    result := result + 4;
    x := x shl 4;
  end;

  if (x shr 30) = 0 then begin
    result := result + 2;
    x := x shl 2;
  end;

  result := result - (x shr 31);
end;

class function NPLLong.numberOfTrailingZeros(i : long) : int;
var
  x, y, n : int;
begin
  if i = 0 then begin
    result := 64;
    exit;
  end;

  n := 63;
  y := int(i);
  if y <> 0 then begin
    n := n - 32;
    x := y;
  end else x := int(i shr 32);

  y := x shl 16;
  if y <> 0 then begin
    n := n - 16;
    x := y;
  end;

  y := x shl 8;
  if y <> 0 then begin
    n := n - 8;
    x := y;
  end;

  y := x shl 4;
  if y <> 0 then begin
    n := n - 4;
    x := y;
  end;

  y := x shl 2;
  if y <> 0 then begin
    n := n - 2;
    x := y;
  end;

  result := n - ((x shl 1) shr 31);
end;

class function NPLLong.bitCount(i : long) : int;
begin
  i := i - ((i shr 1) and long($5555555555555555));
  i := (i and long($3333333333333333)) + ((i shr 2) and long($3333333333333333));
  i := (i + (i shr 4)) and long($0f0f0f0f0f0f0f0f);
  i := i + (i shr 8);
  i := i + (i shr 16);
  i := i + (i shr 32);
  result := int(i) and $7f;
end;

class function NPLLong.rotateLeft(i : long; distance : int) : long;
begin
  result := (i shl distance) or (i shr -distance);
end;

class function NPLLong.rotateRight(i : long; distance : int) : long;
begin
  result := (i shr distance) or (i shl -distance);
end;

class function NPLLong.reverse(i : long) : long;
begin
  i := (i and long($5555555555555555)) shl 1 or (i shr 1) and long($5555555555555555);
  i := (i and long($3333333333333333)) shl 2 or (i shr 2) and long($3333333333333333);
  i := (i and long($0f0f0f0f0f0f0f0f)) shl 4 or (i shr 4) and long($0f0f0f0f0f0f0f0f);
  i := (i and long($00ff00ff00ff00ff)) shl 8 or (i shr 8) and long($00ff00ff00ff00ff);
  i := (i shl 48) or ((i and long($ffff0000)) shl 16) or ((i shr 16) and long($ffff0000)) or (i shr 48);
  result := i;
end;

class function NPLLong.signum(i : long) : int;
begin
  if i < 0 then
    result := -1
  else if i > 0 then
    result := 1
  else
    result := 0;
end;

class function NPLLong.reverseBytes(i : long) : long;
begin
  i := (i and long($00ff00ff00ff00ff)) shl 8 or (i shr 8) and long($00ff00ff00ff00ff);
  result := (i shl 48) or ((i and long($ffff0000)) shl 16) or ((i shr 16) and long($ffff0000)) or (i shr 48);
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

function NPLFloat.compareTo(anotherFloat : {$IFDEF GENERICS}NPLFloat{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if anotherFloat=NIL then
    raise NilPointerException.create('anotherFloat');

  {$IFNDEF GENERICS}
  if not (anotherFloat is NPLFloat) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLFloat.compare(self.fValue.floatValue, NPLFloat(anotherFloat).fValue.floatValue);
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
