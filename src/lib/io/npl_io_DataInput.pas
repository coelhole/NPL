unit npl_io_DataInput;

interface

uses
  npl
  ;

type
  DataInput = interface
    ['{319C76F7-F31C-4AB6-B6E0-06CBAFBDE107}']
    procedure readFully(b : sbytearr); overload;
    procedure readFully(b : sbytearr; off, len : int); overload;
    function skipBytes(n : int) : int;
    function readBoolean : boolean;
    function readByte : sbyte;
    function readUnsignedByte : ubyte;
    function readShort : short;
    function readUnsignedShort : ushort;
    function readChar : nchar;
    function readInt : int;
    function readLong : long;
    function readFloat : float;
    function readDouble : double;
    procedure readLine(out line : NString);
    procedure readUTF(out utfstr : NString);
  end;

implementation

end.
