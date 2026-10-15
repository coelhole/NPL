unit npl_io_DataInput;

interface

uses
  npl
  ;

const
  DATAINPUTGSTR = '{319C76F7-F31C-4AB6-B6E0-06CBAFBDE107}';

type
  DataInput = interface(IObject)
    [DATAINPUTGSTR]
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

function implementsDataInput(cls : TClass) : boolean; overload;
function implementsDataInput(obj : NPLObject) : boolean; overload;

implementation

function implementsDataInput(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(DataInput) <> nil);
end;

function implementsDataInput(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(DataInput) <> nil);
end;

end.
