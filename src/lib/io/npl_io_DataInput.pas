unit npl_io_DataInput;

interface

uses
  npl
  ;

type
  DataInput = interface(IObject)
    ['{319C76F7-F31C-4AB6-B6E0-06CBAFBDE107}']
    procedure readFully(var b : sbytearr); overload;
    procedure readFully(var b : sbytearr; off, len : int); overload;
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
    function readLine : string;
    function readUTF : string;
  end;

implementation

end.
