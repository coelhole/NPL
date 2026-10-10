unit npl;

// compiladores-alvo:
// - FPC 2.6.0+ (plataformas: Windows/Unix 32/64-bits)
// - Delphi 4-7 (plataformas: Windows 32-bits) [Interesse em versões modernas do Delphi? NENHUM!]
{$I npl.inc}
{$IFDEF DEBUG}
  {$I debug.inc}
{$ENDIF}

interface

uses
  classes
  ,SysUtils
  {$IFDEF WINDOWS}
  ,Windows
  {$ENDIF}
  ,npl_io_Closeable
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

const
{$ifdef DELPHI5OROLDER}
  S_OK = 0;
  S_FALSE = $00000001;
  E_NOINTERFACE = HRESULT($80004002);
  E_UNEXPECTED = HRESULT($8000FFFF);
  E_NOTIMPL = HRESULT($80004001);
{$endif DELPHI5OROLDER}
  NUL = #0;
  BEL = #7;
  BS  = #8;
  HT  = #9;
  LF  = #10;
  VT  = #11;
  FF  = #12;
  CR  = #13;
  CRLF = CR+LF;
  EOL = {$IFDEF WINDOWS}CRLF{$ELSE}LF{$ENDIF};

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
{$IFDEF FPC}
  ulong   = uint64;
{$ELSE}
  ulong   = long;
{$ENDIF}
  dword   = cardinal;
  money   = currency;
  float   = single;
  decimal = extended;
  sstring = shortstring;
  wchar   = widechar;
  wstring = widestring;
{$IFDEF CPU64}
  nint    = int64;
  {$IFDEF FPC}
  nuint   = uint64;
  {$ELSE}
  nuint   = nint;
  {$ENDIF}
{$ELSE}
  nint    = int32;
  nuint   = uint32;
{$ENDIF}

  ASCIICodePoint            = 0   ..  127;
  LowerASCIILetterCodePoint = 97  ..  122;
  LowerASCIILetter          = 'a' ..  'z';
  UpperASCIILetterCodePoint = 65  ..  90;
  UpperASCIILetter          = 'A' ..  'Z';
  ASCIIDigitCodePoint       = 48  ..  57;
  ASCIIDigit                = '0' ..  '9';
  ASCIICodePoints           = set of  ASCIICodePoint;
  ANSICharCodePoint         = 0   ..  255;
  ANSICharCodePoints        = set of  ANSICharCodePoint;

  //array types
  chararr     = array of char;
  wchararr    = array of wchar;
  sstringarr  = array of shortstring;
  stringarr   = array of string;
  wstringarr  = array of wstring;
  booleanarr  = array of boolean;
  boolarr     = array of bool;
  bytearr     = array of byte;
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
  nuintarr    = array of nuint;

  //NPL char & string types
  uchar       = widechar;
  ustring     = widestring;
  nchar       = type word;
  nchararr    = array of nchar;
  nrawstring  = type nchararr;

  basetype = (
    t_sbyte,
    t_ubyte,
    t_short,
    t_ushort,
    t_int,
    t_uint,
    t_long,
    t_ulong,
    t_float,
    t_double,
    t_money,
    t_boolean,
    t_char,
    t_wchar,
    t_string,
    t_wstring
  );

  union = record
    case integer of
      1:  (sbyteValue   : sbyte);
      2:  (ubyteValue   : ubyte);
      3:  (shortValue   : short);
      4:  (ushortValue  : ushort);
      5:  (intValue     : int);
      6:  (uintValue    : uint);
      7:  (longValue    : long);
      8:  (ulongValue   : ulong);
      9:  (floatValue   : float);
      10: (doubleValue  : double);
      11: (decimalValue : decimal);
      12: (moneyValue   : money);
      13: (booleanValue : boolean);
      14: (charValue    : char);
      15: (wcharValue   : wchar);
  end;

{$M+}
  NPLObject=class(TObject, {$IFDEF DELPHI5OROLDER}IUnknown{$ELSE}{$IFDEF FPC}IUnknown{$ELSE}IInterface{$ENDIF}{$ENDIF})
  //Eis aqui nossa raiz da hierarquia de classes!
  protected
    fRefCount : {$IFDEF FPC}longint{$ELSE}Integer{$ENDIF};
    function QueryInterface({$IFDEF FPC}{$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF}{$ELSE}const{$ENDIF} IID : TGUID; out Obj) : {$IFDEF FPC}longint; virtual; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}HResult; virtual; stdcall;{$ENDIF}
    function _AddRef : {$IFDEF FPC}longint; virtual; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}Integer; virtual; stdcall;{$ENDIF}
    function _Release : {$IFDEF FPC}longint; virtual; {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE}Integer; virtual; stdcall;{$ENDIF}
  public
    procedure Free; reintroduce;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance : TObject; override;
    class function unitName : ansistring;
    class function qualifiedClassName : ansistring;
    function equals(obj : NPLObject) : boolean; {$IFDEF FPC}reintroduce; {$ENDIF}virtual;
    function hashCode : int; virtual;
    function toString : string; {$IFDEF FPC}reintroduce; {$ENDIF}virtual;
  end;
{$M-}

  NPLClass = class of NPLObject;

  NPLException=class(Exception)
  public
    constructor create; overload;
  end;

  NPLExceptionClass = class of NPLException;

  NilPointerException = class(NPLException);

  NilPointerExceptionClass = class of NilPointerException;

  IllegalArgumentException = class(NPLException);

  IllegalArgumentExceptionClass = class of IllegalArgumentException;

  IndexOutOfBoundsException = class(NPLException);

  IndexOutOfBoundsExceptionClass = class of IndexOutOfBoundsException;

  ArrayIndexOutOfBoundsException = class(IndexOutOfBoundsException);

  ArrayIndexOutOfBoundsExceptionClass = class of ArrayIndexOutOfBoundsException;

  StringIndexOutOfBoundsException = class(IndexOutOfBoundsException)
  public
    constructor create(index : int);
  end;

  StringIndexOutOfBoundsExceptionClass = class of StringIndexOutOfBoundsException;

  NumberFormatException = class(IllegalArgumentException)
  public
    class function forInputString(s : string) : NumberFormatException;
  end;

  NumberFormatExceptionClass = class of NumberFormatException;

  UnsupportedOperationException = class(NPLException);

  UnsupportedOperationExceptionClass = class of UnsupportedOperationException;

  AutoCloseable = interface(Closeable)
    ['{63DD1A1E-681B-4661-B163-29F81EB23C13}']
  end;

  AutoDestroyable = interface
    //Interfaces servem primariamente para estabelecimento de contratos.
    //Object Pascal, por influência de COM, amarrou interfaces ao gerenciamento de ciclo de vida.
    //AutoDestroyable é nossa sugestão de desacoplar as coisas: (i) contrato é uma coisa; (ii) ciclo de vida é outra.
    ['{785BB1DE-C6B1-4EF9-A404-343D1609BABF}']
  end;

  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Comparable<T>{$ELSE}Comparable{$ENDIF} = interface
    ['{6EBC1ADC-027E-4B7B-AA27-88D8F2D1CC17}']
    function compareTo(o : {$IFDEF GENERICS}T{$ELSE}NPLObject{$ENDIF}) : int;
  end;

  NPLNumber         = class;
  NPLSByte          = class;
  NPLShort          = class;
  NPLInteger        = class;
  NPLLong           = class;
  NPLFloat          = class;
  NPLDouble         = class;
  NPLBoolean        = class;
  NPLANSICharacter  = class;
  NPLANSIString     = class;

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

  NPLSByte = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLSByte>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : sbyte); overload;
    constructor create(const s : string); overload;
    constructor create(s : NPLANSIString); overload;
    function equals(obj : NPLObject) : boolean; override;
    function compareTo(anotherByte : {$IFDEF GENERICS}NPLSByte{$ELSE}NPLObject{$ENDIF}) : int;
    function toString : string; overload; override;
    function hashCode : int; override;
    class function toString(b : sbyte) : string; overload;
    class function parseByte(const s : string; radix : int) : sbyte; overload;
    class function parseByte(const s : string) : sbyte; overload;
    class function decode(nm : NPLANSIString) : sbyte; overload;
    class function decode(const nm : string) : sbyte; overload;
    class function compare(x, y : sbyte) : int;
    property value : sbyte read fValue.sbyteValue write fValue.sbyteValue;
  end;

  NPLSByteClass = class of NPLSByte;

  NPLShort = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLShort>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : short); overload;
    constructor create(const s : string); overload;
    constructor create(s : NPLANSIString); overload;
    function equals(obj : NPLObject) : boolean; override;
    function compareTo(anotherShort : {$IFDEF GENERICS}NPLShort{$ELSE}NPLObject{$ENDIF}) : int;
    function toString : string; overload; override;
    function hashCode : int; override;
    class function toString(s : short) : string; overload;
    class function parseShort(const s : string; radix : int) : short; overload;
    class function parseShort(const s : string) : short; overload;
    class function decode(nm : NPLANSIString) : short; overload;
    class function decode(const nm : string) : short; overload;
    class function compare(x, y : short) : int;
    class function reverseBytes(i : short) : short;
    property value : short read fValue.shortValue write fValue.shortValue;
  end;

  NPLShortClass = class of NPLShort;

  NPLInteger = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLInteger>{$ELSE}Comparable{$ENDIF})
  private
    class function toUnsignedString(i, shift : int) : string;
  public
    constructor create(aValue : int); overload;
    constructor create(const s : string); overload;
    constructor create(s : NPLANSIString); overload;
    function equals(obj : NPLObject) : boolean; override;
    function compareTo(anotherInteger : {$IFDEF GENERICS}NPLInteger{$ELSE}NPLObject{$ENDIF}) : int;
    function toString : string; overload; override;
    function hashCode : int; override;
    class function toString(i, radix : int) : string; overload;
    class function toString(i : int) : string; overload;
    class function toHexString(i : int) : string;
    class function toOctalString(i : int) : string;
    class function toBinaryString(i : int) : string;
    class function parseInt(const s : string; radix : int) : int; overload;
    class function parseInt(const s : string) : int; overload;
    class function decode(nm : NPLANSIString) : int; overload;
    class function decode(const nm : string) : int; overload;
    class function compare(x, y : int) : int;
    class function highestOneBit(i : int) : int;
    class function lowestOneBit(i : int) : int;
    class function numberOfLeadingZeros(i : int) : int;
    class function numberOfTrailingZeros(i : int) : int;
    class function bitCount(i : int) : int;
    class function rotateLeft(i, distance : int) : int;
    class function rotateRight(i, distance : int) : int;
    class function reverse(i : int) : int;
    class function signum(i : int) : int;
    class function reverseBytes(i : int) : int;
    property value : int read fValue.intValue write fValue.intValue;
  end;

  NPLIntegerClass = class of NPLInteger;

  NPLLong = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLLong>{$ELSE}Comparable{$ENDIF})
  private
    class function toUnsignedString(i : long; shift : int) : string;
  public
    constructor create(aValue : long); overload;
    constructor create(const s : string); overload;
    constructor create(s : NPLANSIString); overload;
    function equals(obj : NPLObject) : boolean; override;
    function compareTo(anotherLong : {$IFDEF GENERICS}NPLLong{$ELSE}NPLObject{$ENDIF}) : int;
    function toString : string; overload; override;
    function hashCode : int; override;
    class function toString(i : long; radix : int) : string; overload;
    class function toString(i : long) : string; overload;
    class function toHexString(i : long) : string;
    class function toOctalString(i : long) : string;
    class function toBinaryString(i : long) : string;
    class function parseLong(const s : string; radix : int) : long; overload;
    class function parseLong(const s : string) : long; overload;
    class function decode(nm : NPLANSIString) : long; overload;
    class function decode(const nm : string) : long; overload;
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
    function equals(obj : NPLObject) : boolean; override;
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

  NPLDouble = class(NPLNumber,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLDouble>{$ELSE}Comparable{$ENDIF})
  public
    constructor create(aValue : double);
    function equals(obj : NPLObject) : boolean; override;
    function compareTo(anotherDouble : {$IFDEF GENERICS}NPLDouble{$ELSE}NPLObject{$ENDIF}) : int;    
    function isNaN : boolean; overload;
    function isInfinite : boolean; overload;
    function hashCode : int; override;
    class function isNaN(v : double) : boolean; overload;
    class function isInfinite(v : double) : boolean; overload;
    class function doubleToLongBits(value : double) : long;
    class function doubleToRawLongBits(value : double) : long;
    class function longBitsToDouble(bits : long) : double;
    class function compare(d1, d2 : double) : int;
    property value : double read fValue.doubleValue write fValue.doubleValue;
  end;

  NPLDoubleClass = class of NPLDouble;

  NPLBoolean = class(NPLObject,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLBoolean>{$ELSE}Comparable{$ENDIF})
  private
    fValue : boolean;
  public
    constructor create(aValue : boolean); overload;
    constructor create(const s : string); overload;
    constructor create(s : NPLANSIString); overload;
    class function toString(b : boolean) : string; overload;
    function toString : string; overload; override;
    function hashCode : int; override;
    function equals(obj : NPLObject) : boolean; override;
    function compareTo(b : {$IFDEF GENERICS}NPLBoolean{$ELSE}NPLObject{$ENDIF}) : int;
    class function compare(x, y : boolean) : int;
    class function toBoolean(const name : string) : boolean; overload;
    class function toBoolean(name : NPLANSIString) : boolean; overload;
    property value : boolean read fValue write fValue;
  end;

  NPLBooleanClass = class of NPLBoolean;

  NPLANSICharacter = class(NPLObject,{$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}specialize{$ENDIF} Comparable<NPLANSICharacter>{$ELSE}Comparable{$ENDIF})
  private
    fValue : char;
  public
    constructor create(aValue : char);
    class function toString(c : char) : string; overload;
    class function isValidCodePoint(codePoint : int) : boolean;
    class function charCount(codePoint : int) : int;
    class function isLowerCase(codePoint : int) : boolean; overload;
    class function isLowerCase(ch : char) : boolean; overload;
    class function isUpperCase(codePoint : int) : boolean; overload;
    class function isUpperCase(ch : char) : boolean; overload;
    class function compare(x, y : char) : int;
    class function isDigit(codePoint : int) : boolean; overload;
    class function isDigit(ch : char) : boolean; overload;
    class function isASCIILetter(codePoint : int) : boolean; overload;
    class function isASCIILetter(ch : char) : boolean; overload;
    class function isASCIILetterOrDigit(codePoint : int) : boolean; overload;
    class function isASCIILetterOrDigit(ch : char) : boolean; overload;
    class function isLetter(codePoint : int) : boolean; overload;
    class function isLetter(ch : char) : boolean; overload;
    class function isLetterOrDigit(codePoint : int) : boolean; overload;
    class function isLetterOrDigit(ch : char) : boolean; overload;
    class function digit(codePoint : int; radix : int) : int; overload;
    class function digit(ch : char; radix : int) : int; overload;
    class function forDigit(digit, radix : int) : char;
    class function isDefined(codePoint : int) : boolean; overload;
    class function isDefined(ch : char) : boolean; overload;
    class function isWhitespace(codePoint : int) : boolean; overload;
    class function isWhitespace(ch : char) : boolean; overload;
    class function isISOControl(codePoint : int) : boolean; overload;
    class function isISOControl(ch : char) : boolean; overload;
    function hashCode : int; override;
    function equals(obj : NPLObject) : boolean; override;
    function toString : string; overload; override;
    function compareTo(c : {$IFDEF GENERICS}NPLANSICharacter{$ELSE}NPLObject{$ENDIF}) : int;
    function isDigit : boolean; overload;
    function isASCIILetter : boolean; overload;
    function isASCIILetterOrDigit : boolean; overload;
    property value : char read fValue write fValue;
  end;

  NPLANSICharacterClass = class of NPLANSICharacter;

  NPLANSIString = class(NPLObject)
  private
    fValue : ansistring;
  protected
    procedure getChars(var dst : chararr; dstBegin : int); overload;
  public
    constructor create(const original : ansistring); overload;
    constructor create(value : chararr); overload;
    constructor create(value : chararr; offset, count : int); overload;
    constructor create(value : ubytearr); overload;
    constructor create(value : ubytearr; offset, count : int); overload;
    constructor create(value : sbytearr); overload;
    constructor create(value : sbytearr; offset, count : int); overload;
    function equals(obj : NPLObject) : boolean; override;
    function toString : string; override;
    function length : int;
    function isEmpty : boolean;
    function charAt(index : int) : char;
    procedure getChars(srcBegin, srcEnd : int; var dst : chararr; dstBegin : int); overload;
    function regionMatches(toffset : int; const other : ansistring; ooffset, len : int) : boolean;
    function startsWith(const prefix : ansistring; toffset : int = 0) : boolean;
    function endsWith(const suffix : ansistring) : boolean;
    function substring(beginIndex : int) : ansistring; overload;
    function substring(beginIndex, endIndex : int) : ansistring; overload;
    property value : ansistring read fValue write fValue;
  end;

  NPLANSIStringClass = class of NPLANSIString;

  NObject         = NPLObject;        NClass              = NPLClass;
  NNumber         = NPLNumber;        NNumberClass        = NPLNumberClass;
  NByte           = NPLSByte;         NByteClass          = NPLSByteClass;
  NShort          = NPLShort;         NShortClass         = NPLShortClass;
  NInteger        = NPLInteger;       NIntegerClass       = NPLIntegerClass;
  NLong           = NPLLong;          NLongClass          = NPLLongClass;
  NFloat          = NPLFloat;         NFloatClass         = NPLFloatClass;
  NDouble         = NPLDouble;        NDoubleClass        = NPLDoubleClass;
  NBoolean        = NPLBoolean;       NBooleanClass       = NPLBooleanClass;
  NANSICharacter  = NPLANSICharacter; NANSICharacterClass = NPLANSICharacterClass;
  NANSIString     = NPLANSIString;    NANSIStringClass    = NPLANSIStringClass;

function signedRightShift(value, bits : int): int; overload;
function signedRightShift(value : long; bits : int): long; overload;

implementation

uses
  npl_Character
  ,npl_Double
  ,npl_Float
  ,npl_Integer
  ,npl_Long
  ,npl_misc_DoubleConsts
  ,npl_misc_FloatConsts
  ,npl_SByte
  ,npl_Short
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

var
  UpperANSILetterCodePoints : ANSICharCodePoints =
    [Low(UpperASCIILetterCodePoint)..High(UpperASCIILetterCodePoint)] +
    [138,140,142,159,192..214,216..222]  //extended ASCII
  ;
  LowerANSILetterCodePoints : ANSICharCodePoints =
    [Low(LowerASCIILetterCodePoint)..High(LowerASCIILetterCodePoint)] +
    [131,154,156,158,170,181,186,223..246,248..255]  //extended ASCII
  ;
  ANSILetterCodePoints : ANSICharCodePoints =
    [Low(UpperASCIILetterCodePoint)..High(UpperASCIILetterCodePoint)] +
    [Low(LowerASCIILetterCodePoint)..High(LowerASCIILetterCodePoint)] +
    [131,138,140,142,154,156,158,159,170,181,186,192..214,216..246,248..255]  //extended ASCII
  ;
  ANSIDigitCodePoints : ANSICharCodePoints = [Low(ASCIIDigitCodePoint)..High(ASCIIDigitCodePoint)];

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

function NPLObject.equals(obj : NPLObject) : boolean;
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
  result := qualifiedClassName + '@' + NPLInteger.toHexString(hashCode);
end;

procedure NPLObject.Free;
//Que não se esqueçam do que estamos propondo com a NPL: NPLObject é a raiz da hierarquia de classes.
//Portanto, não use referências TObject: se precisa de uma referência genérica, use NPLObject.
begin
  if self <> nil then begin
    InterlockedExchange(fRefCount,0);  
    destroy;
  end;
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
  result := InterlockedIncrement(fRefCount);
end;

type
  CloseProc = procedure(const aSelf: Pointer);
procedure checkAutoCloseable(obj : NPLObject);
var
  AutoCloaseableEntry : PInterfaceEntry;
  AutoCloseableInstancePtr : Pointer;
  AutoCloseableVTablePtr : Pointer;
  ClosePointer : Pointer;
  Close : CloseProc;
begin
  AutoCloaseableEntry := obj.getInterfaceEntry(AutoCloseable);
  if AutoCloaseableEntry <> nil then begin
    AutoCloseableInstancePtr := Pointer(nint(obj) + AutoCloaseableEntry^.IOffset);
    AutoCloseableVTablePtr := PPointer(AutoCloseableInstancePtr)^;
    ClosePointer := PPointer(nint(AutoCloseableVTablePtr) + (3 * SizeOf(Pointer)))^;
    @Close := ClosePointer;
    Close(AutoCloseableInstancePtr);
  end;
end;
function NPLObject._Release : {$IFDEF FPC}longint;{$ELSE}Integer;{$ENDIF}
var
  isAutoDestroyable : boolean;
begin
  result := InterlockedDecrement(fRefCount);

  if result = 0 then begin
    isAutoDestroyable := (self.classType.getInterfaceEntry(AutoDestroyable) <> nil);
    checkAutoCloseable(self);
    if isAutoDestroyable then
      destroy;
  end;
end;

procedure NPLObject.AfterConstruction;
begin
  InterlockedDecrement(fRefCount);
end;

procedure NPLObject.BeforeDestruction;
begin
  if fRefCount <> 0 then
    System.RunError(2);
end;

class function NPLObject.NewInstance : TObject;
begin
  result := inherited NewInstance;
  NPLObject(result).fRefCount := 1;
end;

constructor NPLException.create;
begin
  create('');
end;

constructor StringIndexOutOfBoundsException.create(index : int);
begin
  inherited createFmt('String index out of range: %d',[index]);
end;

class function NumberFormatException.forInputString(s : string) : NumberFormatException;
begin
  result := NumberFormatException.CreateFmt('For input string: ''%s''',[s]);
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

constructor NPLSByte.create(const s : string);
begin
  fValue.sbyteValue := decode(s);
end;

constructor NPLSByte.create(s : NPLANSIString);
begin
  fValue.sbyteValue := decode(s);
end;

function NPLSByte.equals(obj : NPLObject) : boolean;
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
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (anotherByte is NPLSByte) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLSByte.compare(self.fValue.sbyteValue, NPLSByte(anotherByte).fValue.sbyteValue);
end;

function NPLSByte.toString : string;
begin
  result := NPLInteger.toString(int(fValue.sbyteValue));
end;

function NPLSByte.hashCode : int;
begin
  result := int(fValue.sbyteValue);
end;

class function NPLSByte.toString(b : sbyte) : string;
begin
  result := NPLInteger.toString(int(b), 10);
end;

class function NPLSByte.parseByte(const s : string; radix : int) : sbyte;
var
  i : int;
begin
  i := NPLInteger.parseInt(s, radix);
  if (i < npl_SByte.MIN_VALUE) or (i > npl_SByte.MAX_VALUE) then
    raise NumberFormatException.createFmt('Value out of range. Value:''%s'' Radix:%d',[s,radix]);
  result := sbyte(i);
end;

class function NPLSByte.parseByte(const s : string) : sbyte;
begin
  result := parseByte(s, 10);
end;

class function NPLSByte.decode(nm : NPLANSIString) : sbyte;
begin
  result := decode(nm.toString);
end;

class function NPLSByte.decode(const nm : string) : sbyte;
var
  i : int;
begin
  i := NPLInteger.decode(nm);
  if (i < npl_SByte.MIN_VALUE) or (i > npl_SByte.MAX_VALUE) then
    raise NumberFormatException.createFmt('Value %d out of range from input ''%s''',[i,nm]);
  result := sbyte(i);
end;

class function NPLSByte.compare(x, y : sbyte) : int;
begin
  result := x-y;
end;

constructor NPLShort.create(aValue : short);
begin
  fValue.shortValue := aValue;
end;

constructor NPLShort.create(const s : string);
begin
  fValue.shortValue := decode(s);
end;

constructor NPLShort.create(s : NPLANSIString);
begin
  fValue.shortValue := decode(s);
end;

function NPLShort.equals(obj : NPLObject) : boolean;
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
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (anotherShort is NPLShort) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLShort.compare(self.fValue.shortValue, NPLShort(anotherShort).fValue.shortValue);
end;

function NPLShort.toString : string;
begin
  result := NPLInteger.toString(int(fValue.shortValue));
end;

function NPLShort.hashCode : int;
begin
  result := int(fValue.shortValue);
end;

class function NPLShort.toString(s : short) : string;
begin
  result := NPLInteger.toString(int(s), 10);
end;

class function NPLShort.parseShort(const s : string; radix : int) : short;
var
  i : int;
begin
  i := NPLInteger.parseInt(s, radix);
  if (i < npl_Short.MIN_VALUE) or (i > npl_Short.MAX_VALUE) then
    raise NumberFormatException.CreateFmt('Value out of range. Value:''%s'' Radix:%d',[s,radix]);
  result := short(i);
end;

class function NPLShort.parseShort(const s : string) : short;
begin
  result := parseShort(s, 10);
end;

class function NPLShort.decode(nm : NPLANSIString) : short;
begin
  result := decode(nm.toString);
end;

class function NPLShort.decode(const nm : string) : short;
var
  i : int;
begin
  i := NPLInteger.decode(nm);
  if (i < npl_Short.MIN_VALUE) or (i > npl_Short.MAX_VALUE) then
    raise NumberFormatException.createFmt('Value %d out of range from input ''%s''',[i,nm]);
  result := short(i);
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

constructor NPLInteger.create(const s : string);
begin
  fValue.intValue := decode(s);
end;

constructor NPLInteger.create(s : NPLANSIString);
begin
  fValue.intValue := decode(s);
end;

function NPLInteger.equals(obj : NPLObject) : boolean;
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
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (anotherInteger is NPLInteger) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLInteger.compare(self.fValue.intValue, NPLInteger(anotherInteger).fValue.intValue);
end;

function NPLInteger.toString : string;
begin
  result := toString(fValue.intValue);
end;

function NPLInteger.hashCode : int;
begin
  result := fValue.intValue;
end;

class function NPLInteger.toString(i, radix : int) : string;
var
  buf : chararr;
  negative : boolean;
  charPos : int;
begin
  if (radix < npl_Character.MIN_RADIX) or (radix > npl_Character.MAX_RADIX) then
    radix := 10;

  if radix = 10 then begin
    result := toString(i);
    exit;
  end;

  setLength(buf, 33);
  negative := (i < 0);
  charPos := 32;

  if not negative then
    i := -i;

  while i <= -radix do begin
    buf[charPos] := npl_Integer.digits[-(i mod radix)];
    dec(charPos);
    i := i div radix;
  end;
  buf[charPos] := npl_Integer.digits[-i];

  if negative then begin
    dec(charPos);
    buf[charPos] := '-';
  end;

  result := string(copy(buf, charPos, 33-charPos));
end;

class function NPLInteger.toString(i : int) : string;
var
  size : int;
  buf : chararr;
begin
  if i = npl_Integer.MIN_VALUE then begin
    result := '-2147483648';
    exit;
  end;

  if i < 0 then
    size := npl_Integer.stringSize(-i) + 1
  else size := npl_Integer.stringSize(i);

  setLength(buf, size);
  npl_Integer.getChars(i, size, buf);
  result := string(buf);
end;

class function NPLInteger.toUnsignedString(i, shift : int) : string;
var
  buf : chararr;
  charPos, radix, mask : int;
begin
  setLength(buf, 32);
  charPos := 32;
  radix := 1 shl shift;
  mask := radix - 1;
  repeat
    dec(charPos);
    buf[charPos] := npl_Integer.digits[i and mask];
    i := i shr shift;
  until i = 0;
  result := string(copy(buf, charPos, 32-charPos));
end;

class function NPLInteger.toHexString(i : int) : string;
begin
  result := toUnsignedString(i, 4);
end;

class function NPLInteger.toOctalString(i : int) : string;
begin
  result := toUnsignedString(i, 3);
end;

class function NPLInteger.toBinaryString(i : int) : string;
begin
  result := toUnsignedString(i, 1);
end;

class function NPLInteger.parseInt(const s : string; radix : int) : int;
var
  negative : boolean;
  i, len, limit, multmin, digit : int;
  firstChar : char;
begin
  if s = '' then
    raise NumberFormatException.create;
  if radix < npl_Character.MIN_RADIX then
    raise NumberFormatException.CreateFmt('radix %d less than npl_Character.MIN_RADIX',[radix]);
  if radix > npl_Character.MAX_RADIX then
    raise NumberFormatException.CreateFmt('radix %d greater than npl_Character.MAX_RADIX',[radix]);
  result := 0;
  negative := false;
  i := 0;
  len := length(s);
  limit := -npl_Integer.MAX_VALUE;
  if len>0 then begin
    firstChar := s[1];
    if firstChar < '0' then begin
      if firstChar = '-' then begin
        negative := true;
        limit := npl_Integer.MIN_VALUE;
      end else
      if firstChar <> '+' then
        raise NumberFormatException.forInputString(s);
      if len = 1 then
        raise NumberFormatException.forInputString(s);
      inc(i);
    end;
    multmin := limit div radix;
    while i < len do begin
      digit := NPLANSICharacter.digit(s[i+1],radix);
      inc(i);
      if digit < 0 then
        raise NumberFormatException.forInputString(s);
      if result < multmin then
        raise NumberFormatException.forInputString(s);
      result := result * radix;
      if result < limit+digit then
        raise NumberFormatException.forInputString(s);
      result := result - digit;
    end;
  end else raise NumberFormatException.forInputString(s);
  if not negative then
    result := - result;
end;

class function NPLInteger.parseInt(const s : string) : int;
begin
  result := parseInt(s,10);
end;

class function NPLInteger.decode(nm : NPLANSIString) : int;
var
  radix, index : int;
  negative : boolean;
  firstChar : char;
begin
  radix := 10;
  index := 0;
  negative := false;

  if nm.length = 0 then
    raise NumberFormatException.create('Zero length string');
  firstChar := nm.charAt(0);
  // Handle sign, if present
  if firstChar = '-' then begin
    negative := true;
    inc(index);
  end else
  if firstChar = '+' then
    inc(index);

  // Handle radix specifier, if present
  if nm.startsWith('0x', index) or nm.startsWith('0X', index) then begin
    inc(index,2);
    radix := 16;
  end else if nm.startsWith('#', index) or nm.startsWith('$', index) then begin
    inc(index);
    radix := 16;
  end else if nm.startsWith('0', index) and (nm.length > 1 + index) then begin
    inc(index);
    radix := 8;
  end;

  if nm.startsWith('-', index) or nm.startsWith('+', index) then
    raise NumberFormatException.create('Sign character in wrong position');

  try
    result := NPLInteger.parseInt(nm.substring(index), radix);
    if negative then
      result := -result;
  except on e : NumberFormatException do
    if negative then
      result := NPLInteger.parseInt('-' + nm.substring(index), radix)
    else result := NPLInteger.parseInt(nm.substring(index), radix);
  end;
end;

class function NPLInteger.decode(const nm : string) : int;
var
  nmstr : NANSIString;
begin
  nmstr := NANSIString.create(nm);
  try
    result := decode(nmstr);
  finally
    nmstr.free;
  end;
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

class function NPLInteger.highestOneBit(i : int) : int;
  function sRightShift(value, bits : int): int;
  begin
    result := value shr bits;
    if value < 0 then
      result := result or (int($FFFFFFFF) shl (32 - bits));
  end;
begin
  i := i or sRightShift(i, 1);
  i := i or sRightShift(i, 2);
  i := i or sRightShift(i, 4);
  i := i or sRightShift(i, 8);
  i := i or sRightShift(i, 16);
  result := i - (i shr 1);
end;

class function NPLInteger.lowestOneBit(i : int) : int;
begin
  result := i and -i;
end;

class function NPLInteger.numberOfLeadingZeros(i : int) : int;
begin
  if i = 0 then begin
    result := 32;
    exit;
  end;

  result := 1;

  if (i shr 16) = 0 then begin
    result := result + 16;
    i := i shl 16;
  end;

  if (i shr 24) = 0 then begin
    result := result + 8;
    i := i shl 8;
  end;

  if (i shr 28) = 0 then begin
    result := result + 4;
    i := i shl 4;
  end;

  if (i shr 30) = 0 then begin
    result := result + 2;
    i := i shl 2;
  end;

  result := result - (i shr 31);
end;

class function NPLInteger.numberOfTrailingZeros(i : int) : int;
var
  y : int;
begin
  if i = 0 then begin
    result := 32;
    exit;
  end;

  result := 31;

  y := i shl 16;
  if y <> 0 then begin
    result := result - 16;
    i := y;
  end;

  y := i shl 8;
  if y <> 0 then begin
    result := result - 8;
    i := y;
  end;

  y := i shl 4;
  if y <> 0 then begin
    result := result - 4;
    i := y;
  end;

  y := i shl 2;
  if y <> 0 then begin
    result := result - 2;
    i := y;
  end;

  result := result - ((i shl 1) shr 31);
end;

class function NPLInteger.bitCount(i : int) : int;
begin
  i := i - ((i shr 1) and $55555555);
  i := (i and $33333333) + ((i shr 2) and $33333333);
  i := (i + (i shr 4)) and $0f0f0f0f;
  i := i + (i shr 8);
  i := i + (i shr 16);
  result := i and $3f;
end;

class function NPLInteger.rotateLeft(i, distance : int) : int;
var
  shift : int;
begin
  if distance>0 then begin
    shift := distance mod 32;
    result := (i shl shift) or (i shr (32-shift));
  end else
  if distance<0 then begin
    shift := (-distance) mod 32;
    result := (i shr shift) or (i shl (32-shift));
  end else result := i;
end;

class function NPLInteger.rotateRight(i, distance : int) : int;
var
  shift : int;
begin
  if distance>0 then begin
    shift := distance mod 32;
    result := (i shr shift) or (i shl (32-shift));
  end else
  if distance<0 then begin
    shift := (-distance) mod 32;  
    result := (i shl shift) or (i shr (32-shift));
  end else result := i;
end;

class function NPLInteger.reverse(i : int) : int;
begin
  i := (i and $55555555) shl 1 or (i shr 1) and $55555555;
  i := (i and $33333333) shl 2 or (i shr 2) and $33333333;
  i := (i and $0f0f0f0f) shl 4 or (i shr 4) and $0f0f0f0f;
  i := (i shl 24) or ((i and $ff00) shl 8) or ((i shr 8) and $ff00) or (i shr 24);
  result := i;
end;

class function NPLInteger.signum(i : int) : int;
begin
  if i < 0 then
    result := -1
  else if i > 0 then
    result := 1
  else
    result := 0;
end;

class function NPLInteger.reverseBytes(i : int) : int;
begin
  result := ((i shr 24)) or (signedRightShift(i, 8) and $FF00) or ((i shl 8) and $FF0000) or ((i shl 24));
end;

constructor NPLLong.create(aValue : long);
begin
  fValue.longValue := aValue;
end;

constructor NPLLong.create(const s : string);
begin
  fValue.longValue := decode(s);
end;

constructor NPLLong.create(s : NPLANSIString);
begin
  fValue.longValue := decode(s);
end;

function NPLLong.equals(obj : NPLObject) : boolean;
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
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (anotherLong is NPLLong) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLLong.compare(self.fValue.longValue, NPLLong(anotherLong).fValue.longValue);
end;

function NPLLong.toString : string;
begin
  result := toString(fValue.longValue);
end;

function NPLLong.hashCode : int;
begin
  result := int(fValue.longValue xor (fValue.longValue shr 32));
end;

class function NPLLong.toString(i : long; radix : int) : string;
var
  buf : chararr;
  charPos : int;
  negative : boolean;
begin
  if (radix < npl_Character.MIN_RADIX) or (radix > npl_Character.MAX_RADIX) then
    radix := 10;

  if radix = 10 then begin
    result := toString(i);
    exit;
  end;

  setLength(buf, 65);
  charPos := 64;
  negative := (i < 0);

  if not negative then
    i := -i;

  while i <= -radix do begin
    buf[charPos] := npl_Integer.digits[int(-(i mod radix))];
    dec(charPos);
    i := i div radix;
  end;
  buf[charPos] := npl_Integer.digits[int(-i)];

  if negative then begin
    dec(charPos);
    buf[charPos] := '-';
  end;

  result := string(copy(buf, charPos, 65-charPos));
end;

class function NPLLong.toHexString(i : long) : string;
begin
  result := toUnsignedString(i, 4);
end;

class function NPLLong.toOctalString(i : long) : string;
begin
  result := toUnsignedString(i, 3);
end;

class function NPLLong.toBinaryString(i : long) : string;
begin
  result := toUnsignedString(i, 1);
end;

class function NPLLong.toUnsignedString(i : long; shift : int) : string;
var
  buf : chararr;
  charPos, radix : int;
  mask : long;
begin
  setLength(buf, 64);
  charPos := 64;
  radix := 1 shl shift;
  mask := radix - 1;
  repeat
    dec(charPos);
    buf[charPos] := npl_Integer.digits[int(i and mask)];
    i := i shr shift;
  until (i = 0);
  result := string(copy(buf, charPos, 64-charPos));
end;

class function NPLLong.toString(i : long) : string;
var
  size : int;
  buf : chararr;
begin
  if i = npl_Long.MIN_VALUE then begin
    result := '-9223372036854775808';
    exit;
  end;
  if i < 0 then
    size := npl_Long.stringSize(-i) + 1
  else size := npl_Long.stringSize(i);
  setLength(buf, size);
  npl_Long.getChars(i, size, buf);
  result := string(buf);
end;

class function NPLLong.parseLong(const s : string; radix : int) : long;
var
  negative : boolean;
  i, len, digit : int;
  limit, multmin : long;
  firstChar : char;
begin
  if s = '' then
    raise NumberFormatException.create;
  if radix < npl_Character.MIN_RADIX then
    raise NumberFormatException.CreateFmt('radix %d less than npl_Character.MIN_RADIX',[radix]);
  if radix > npl_Character.MAX_RADIX then
    raise NumberFormatException.CreateFmt('radix %d greater than npl_Character.MAX_RADIX',[radix]);
  result := 0;
  negative := false;
  i := 0;
  len := length(s);
  limit := -npl_Long.MAX_VALUE;
  if len>0 then begin
    firstChar := s[1];
    if firstChar < '0' then begin
      if firstChar = '-' then begin
        negative := true;
        limit := npl_Long.MIN_VALUE;
      end else
      if firstChar <> '+' then
        raise NumberFormatException.forInputString(s);
      if len = 1 then
        raise NumberFormatException.forInputString(s);
      inc(i);
    end;
    multmin := limit div radix;
    while i < len do begin
      digit := NPLANSICharacter.digit(s[i+1],radix);
      inc(i);
      if digit < 0 then
        raise NumberFormatException.forInputString(s);
      if result < multmin then
        raise NumberFormatException.forInputString(s);
      result := result * radix;
      if result < limit+digit then
        raise NumberFormatException.forInputString(s);
      result := result - digit;
    end;
  end else raise NumberFormatException.forInputString(s);
  if not negative then
    result := - result;
end;

class function NPLLong.parseLong(const s : string) : long;
begin
  result := parseLong(s, 10);
end;

class function NPLLong.decode(nm : NPLANSIString) : long;
var
  radix, index : int;
  negative : boolean;
  firstChar : char;
begin
  radix := 10;
  index := 0;
  negative := false;

  if nm.length = 0 then
    raise NumberFormatException.create('Zero length string');
  firstChar := nm.charAt(0);
  // Handle sign, if present
  if firstChar = '-' then begin
    negative := true;
    inc(index);
  end else
  if firstChar = '+' then
    inc(index);

  // Handle radix specifier, if present
  if nm.startsWith('0x', index) or nm.startsWith('0X', index) then begin
    inc(index,2);
    radix := 16;
  end else if nm.startsWith('#', index) or nm.startsWith('$', index) then begin
    inc(index);
    radix := 16;
  end else if nm.startsWith('0', index) and (nm.length > 1 + index) then begin
    inc(index);
    radix := 8;
  end;

  if nm.startsWith('-', index) or nm.startsWith('+', index) then
    raise NumberFormatException.create('Sign character in wrong position');

  try
    result := NPLLong.parseLong(nm.substring(index), radix);
    if negative then
      result := -result;
  except on e : NumberFormatException do
    if negative then
      result := NPLLong.parseLong('-' + nm.substring(index), radix)
    else result := NPLLong.parseLong(nm.substring(index), radix);
  end;
end;

class function NPLLong.decode(const nm : string) : long;
var
  nmstr : NANSIString;
begin
  nmstr := NANSIString.create(nm);
  try
    result := decode(nmstr);
  finally
    nmstr.free;
  end;
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
var
  shift : int;
begin
  if distance>0 then begin
    shift := distance mod 64;
    result := (i shl shift) or (i shr (64-shift));
  end else
  if distance<0 then begin
    shift := (-distance) mod 64;
    result := (i shr shift) or (i shl (64-shift));
  end else result := i;
end;

class function NPLLong.rotateRight(i : long; distance : int) : long;
var
  shift : int;
begin
  if distance>0 then begin
    shift := distance mod 64;
    result := (i shr shift) or (i shl (64-shift));
  end else
  if distance<0 then begin
    shift := (-distance) mod 64;
    result := (i shl shift) or (i shr (64-shift));
  end else result := i;
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

function NPLFloat.equals(obj : NPLObject) : boolean;
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
    raise NilPointerException.create;

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
  u.intValue := bits;
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

function NPLDouble.equals(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLDouble) then
    exit;
  result := NPLDouble.doubleToLongBits(self.fValue.doubleValue)=NPLDouble.doubleToLongBits(NPLDouble(obj).fValue.doubleValue);
end;

function NPLDouble.compareTo(anotherDouble : {$IFDEF GENERICS}NPLDouble{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if anotherDouble=NIL then
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (anotherDouble is NPLDouble) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLDouble.compare(self.fValue.doubleValue, NPLDouble(anotherDouble).fValue.doubleValue);
end;

function NPLDouble.isNaN : boolean;
begin
  result := isNaN(fValue.doubleValue);
end;

function NPLDouble.isInfinite : boolean;
begin
  result := isInfinite(fValue.doubleValue);
end;

function NPLDouble.hashCode : int;
var
  bits : long;
begin
  bits := doubleToLongBits(fValue.doubleValue);
  result := int(bits xor (bits shr 32));
end;

class function NPLDouble.isNaN(v : double) : boolean;
var
  bits: long;
begin
  bits := doubleToRawLongBits(v);
  result := ((bits and $7FF0000000000000) = $7FF0000000000000) and ((bits and $000FFFFFFFFFFFFF) <> 0);
end;

class function NPLDouble.isInfinite(v : double) : boolean;
begin
  result := (v = npl_Double.POSITIVE_INFINITY) or (v = npl_Double.NEGATIVE_INFINITY);
end;

class function NPLDouble.doubleToLongBits(value : double) : long;
begin
  result := doubleToRawLongBits(value);
  if ((result and npl_misc_DoubleConsts.EXP_BIT_MASK) = npl_misc_DoubleConsts.EXP_BIT_MASK)
     and ((result and npl_misc_DoubleConsts.SIGNIF_BIT_MASK) <> long(0)) then
      result := long($7ff8000000000000);
end;

class function NPLDouble.doubleToRawLongBits(value : double) : long;
var
  u : union;
begin
  u.doubleValue := value;
  result := u.longValue;
end;

class function NPLDouble.longBitsToDouble(bits : long) : double;
var
  u : union;
begin
  u.longValue := bits;
  result := u.doubleValue;
end;

class function NPLDouble.compare(d1, d2 : double) : int;
var
  thisBits, anotherBits : long;
begin
  if d1 < d2 then begin
    result := -1;
    exit;
  end else
  if d1 > d2 then begin
    result := 1;
    exit;
  end;

  thisBits := NPLDouble.doubleToLongBits(d1);
  anotherBits := NPLDouble.doubleToLongBits(d2);

  if thisBits = anotherBits then
    result := 0
  else
  if thisBits < anotherBits then
    result := -1
  else
    result := 1;
end;

constructor NPLBoolean.create(aValue : boolean);
begin
  fValue := aValue;
end;

constructor NPLBoolean.create(const s : string);
begin
  fValue := toBoolean(s);
end;

constructor NPLBoolean.create(s : NPLANSIString);
begin
  fValue := toBoolean(s);
end;

class function NPLBoolean.toString(b : boolean) : string;
begin
  if b then
    result := 'true'
  else result := 'false';
end;

function NPLBoolean.toString : string;
begin
  if fValue then
    result := 'true'
  else result := 'false';
end;

function NPLBoolean.hashCode : int;
begin
  if fValue then
    result := 1231
  else result := 1237;
end;

function NPLBoolean.equals(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLBoolean) then
    exit;
  result := fValue=NPLBoolean(obj).fValue;
end;

function NPLBoolean.compareTo(b : {$IFDEF GENERICS}NPLBoolean{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if b=NIL then
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (b is NPLBoolean) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLBoolean.compare(self.fValue, NPLBoolean(b).fValue);
end;

class function NPLBoolean.compare(x, y : boolean) : int;
begin
  if x = y then
    result := 0
  else
  if x then
    result := 1
  else
    result := -1;
end;

class function NPLBoolean.toBoolean(const name : string) : boolean;
begin
  result := lowercase(name) = 'true';
end;

class function NPLBoolean.toBoolean(name : NPLANSIString) : boolean;
begin
  result := toBoolean(name.toString);
end;

constructor NPLANSICharacter.create(aValue : char);
begin
  fValue := aValue;
end;

function NPLANSICharacter.hashCode : int;
begin
  result := int(fValue);
end;

function NPLANSICharacter.equals(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLANSICharacter) then
    exit;
  result := fValue=NPLANSICharacter(obj).fValue;
end;

function NPLANSICharacter.toString : string;
begin
  result := toString(fValue);
end;

function NPLANSICharacter.compareTo(c : {$IFDEF GENERICS}NPLANSICharacter{$ELSE}NPLObject{$ENDIF}) : int;
begin
  if c=NIL then
    raise NilPointerException.create;

  {$IFNDEF GENERICS}
  if not (c is NPLANSICharacter) then
    raise IllegalArgumentException.createFmt('Object must be of type %s',[self.className]);
  {$ENDIF}

  result := NPLANSICharacter.compare(self.fValue, NPLANSICharacter(c).fValue);
end;

function NPLANSICharacter.isDigit : boolean;
begin
  result := isDigit(fValue);
end;

function NPLANSICharacter.isASCIILetter : boolean;
begin
  result := isASCIILetter(fValue);
end;

function NPLANSICharacter.isASCIILetterOrDigit : boolean;
begin
  result := isASCIILetterOrDigit(fValue);
end;

class function NPLANSICharacter.isLetter(codePoint : int) : boolean;
begin
  result := codePoint in ANSILetterCodePoints;
end;

class function NPLANSICharacter.isLetter(ch : char) : boolean;
begin
  result := isLetter(int(ch));
end;

class function NPLANSICharacter.isLetterOrDigit(codePoint : int) : boolean;
begin
  result := (codePoint in ANSILetterCodePoints) or (codePoint in ANSIDigitCodePoints);
end;

class function NPLANSICharacter.isLetterOrDigit(ch : char) : boolean;
begin
  result := isLetterOrDigit(int(ch));
end;

class function NPLANSICharacter.toString(c : char) : string;
begin
  result := string(c);
end;

class function NPLANSICharacter.isValidCodePoint(codePoint : int) : boolean;
begin
  result := (codePoint>=0) and (codePoint<=255);
end;

class function NPLANSICharacter.charCount(codePoint : int) : int;
begin
  result := 1;
end;

class function NPLANSICharacter.isLowerCase(codePoint : int) : boolean;
begin
  result := codePoint in LowerANSILetterCodePoints; 
end;

class function NPLANSICharacter.isLowerCase(ch : char) : boolean;
begin
  result := isLowerCase(int(ch));
end;

class function NPLANSICharacter.isUpperCase(codePoint : int) : boolean;
begin
  result := codePoint in UpperANSILetterCodePoints;
end;

class function NPLANSICharacter.isUpperCase(ch : char) : boolean;
begin
  result := isUpperCase(int(ch));
end;

class function NPLANSICharacter.compare(x, y : char) : int;
begin
  result := int(x) - int(y);
end;

class function NPLANSICharacter.isDigit(codePoint : int) : boolean;
begin
    result := ((codePoint > 47) and (codePoint < 58));
end;

class function NPLANSICharacter.isDigit(ch : char) : boolean;
begin
  result := isDigit(int(ch));
end;

class function NPLANSICharacter.isASCIILetter(codePoint : int) : boolean;
begin
  result := ((codePoint > 64) and (codePoint < 91)) or ((codePoint > 96) and (codePoint < 123));
end;

class function NPLANSICharacter.isASCIILetter(ch : char) : boolean;
begin
  result := isASCIILetter(int(ch));
end;

class function NPLANSICharacter.isASCIILetterOrDigit(codePoint : int) : boolean;
begin
  result := ((codePoint > 47) and (codePoint < 58)) or ((codePoint > 64) and (codePoint < 91)) or ((codePoint > 96) and (codePoint < 123));
end;

class function NPLANSICharacter.isASCIILetterOrDigit(ch : char) : boolean;
begin
  result := isASCIILetterOrDigit(int(ch));
end;

class function NPLANSICharacter.digit(codePoint : int; radix : int) : int;
begin
  result := -1;
  if (radix < npl_Character.MIN_RADIX) or (radix > npl_Character.MAX_RADIX) then
    exit;
  if not (((codePoint > 47) and (codePoint < 58)) or ((codePoint > 64) and (codePoint < 91)) or ((codePoint > 96) and (codePoint < 123))) then
    exit;
  if (codePoint > 64) and (codePoint < 91) then
    codePoint := codePoint + 32;
  if radix < 11 then begin
    if codePoint > (47+radix) then
      exit;
    result := codePoint - 48;
  end else begin
    if codePoint > (86+radix) then
      exit;
    if (codePoint > 47) and (codePoint < 58) then
      result := codePoint - 48
    else result := codePoint - 87;
  end;
end;

class function NPLANSICharacter.digit(ch : char; radix : int) : int;
begin
  result := digit(int(ch), radix);
end;

class function NPLANSICharacter.forDigit(digit, radix : int) : char;
begin
  result := NUL;

  if (radix < npl_Character.MIN_RADIX) or (radix > npl_Character.MAX_RADIX) then
    exit;

  if (digit >= radix) or (digit < 0) then
    exit;

  result := npl_Integer.digits[digit];
end;

class function NPLANSICharacter.isDefined(codePoint : int) : boolean;
begin
  result := (codePoint>=0) and (codePoint<=255);
end;

class function NPLANSICharacter.isDefined(ch : char) : boolean;
begin
  result := true;
end;

class function NPLANSICharacter.isWhitespace(codePoint : int) : boolean;
begin
  result := ((codePoint>8) and (codePoint<14)) or ((codePoint>27) and (codePoint<33));
end;

class function NPLANSICharacter.isWhitespace(ch : char) : boolean;
begin
  result := isWhitespace(int(ch));
end;

class function NPLANSICharacter.isISOControl(codePoint : int) : boolean;
begin
  result := ((codePoint>=0) and (codePoint<32)) or (codePoint=127);
end;

class function NPLANSICharacter.isISOControl(ch : char) : boolean;
begin
  result := isISOControl(int(ch));
end;

constructor NPLANSIString.create(const original : ansistring);
begin
  fValue := original;
end;

constructor NPLANSIString.create(value : chararr);
begin
  fValue := ansistring(value);
end;

constructor NPLANSIString.create(value : chararr; offset, count : int);
begin
  fValue := ansistring(copy(value, offset, count));
end;

constructor NPLANSIString.create(value : ubytearr);
begin
  create(chararr(value));
end;

constructor NPLANSIString.create(value : ubytearr; offset, count : int);
begin
  create(chararr(value), offset, count);
end;

constructor NPLANSIString.create(value : sbytearr);
begin
  create(chararr(value));
end;

constructor NPLANSIString.create(value : sbytearr; offset, count : int);
begin
  create(chararr(value), offset, count);
end;

function NPLANSIString.equals(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=NIL then
    exit;
  if not (obj is NPLANSIString) then
    exit;
  result := fValue=NPLANSIString(obj).fValue;
end;

function NPLANSIString.toString : string;
begin
  result := fValue;
end;

function NPLANSIString.length : int;
begin
  result := System.length(fValue);
end;

function NPLANSIString.isEmpty : boolean;
begin
  result := System.length(fValue) = 0;
end;

function NPLANSIString.charAt(index : int) : char;
begin
  if (index < 0) or (index >= System.length(fValue)) then
    raise StringIndexOutOfBoundsException.create(index);
  result := fValue[index+1];
end;

procedure NPLANSIString.getChars(var dst : chararr; dstBegin : int);
var
  slen : int;
begin
  if dstBegin < 0 then
    raise ArrayIndexOutOfBoundsException.create;
  if fValue='' then
    exit;
  slen := System.length(fValue);
  if dstBegin+slen>System.length(dst) then
    setLength(dst,dstBegin+slen);
  move(fValue[1],dst[dstBegin],slen);
end;

procedure NPLANSIString.getChars(srcBegin, srcEnd : int; var dst : chararr; dstBegin : int);
begin
  if srcBegin < 0 then
    raise StringIndexOutOfBoundsException.create(srcBegin);
  if srcEnd > System.length(fValue) then
    raise StringIndexOutOfBoundsException.create(srcEnd);
  if srcBegin > srcEnd then
    raise StringIndexOutOfBoundsException.create(srcEnd - srcBegin);
  if dstBegin < 0 then
    raise ArrayIndexOutOfBoundsException.create;
  if (fValue='') or (srcEnd=srcBegin) then
    exit;
  if dstBegin+srcEnd-srcBegin>System.length(dst) then
    setLength(dst,dstBegin+srcEnd-srcBegin);
  move(fValue[srcBegin+1],dst[dstBegin],srcEnd-srcBegin);
end;

function NPLANSIString.regionMatches(toffset : int; const other : ansistring; ooffset, len : int) : boolean;
var
  slen, olen : long;
begin
  result := false;

  if (ooffset < 0) or (toffset < 0) or (len < 0) then
    exit;

  slen := System.length(fValue);
  olen := System.length(other);
  if (toffset > slen-len) or (ooffset > olen-len) then
    exit;

  while len > 0 do begin
    dec(len);
    if fValue[toffset+1] <> other[ooffset+1] then
      exit;
    inc(toffset);
    inc(ooffset);
  end;

  result := true;
end;

function NPLANSIString.startsWith(const prefix : ansistring; toffset : int = 0) : boolean;
var
  po, pc : int;
begin
  result := false;
  pc := System.length(prefix);
  if (toffset < 0) or (toffset > System.length(fValue) - pc) then
    exit;
  for po := 1 to pc do
    if fValue[toffset + po] <> prefix[po] then
      exit;
  result := true;
end;

function NPLANSIString.endsWith(const suffix : ansistring) : boolean;
begin
  result := startsWith(suffix, System.length(fValue) - System.length(suffix));
end;

function NPLANSIString.substring(beginIndex : int) : ansistring;
begin
  result := substring(beginIndex,System.length(fValue));
end;

function NPLANSIString.substring(beginIndex, endIndex : int) : ansistring;
var
  ca : chararr;
begin
  if beginIndex < 0 then
    raise StringIndexOutOfBoundsException.create(beginIndex);
  if endIndex > System.length(fValue) then
    raise StringIndexOutOfBoundsException.create(endIndex);
  if beginIndex > endIndex then
    raise StringIndexOutOfBoundsException.create(endIndex - beginIndex);
  getChars(beginIndex,endIndex,ca,0);
  result := ansistring(ca);
end;

end.
