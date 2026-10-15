unit npl_io_ObjectInput;

interface

uses
  npl
  ,npl_io_DataInput
  ;

const
  OBJECTINPUTGSTR = '{74620994-0409-4A49-BCF4-35FD17ECE9B7}';

type
  ObjectInput = interface(DataInput)
    [OBJECTINPUTGSTR]
    function readObject : NPLObject;
    function read : int; overload;
    function read(var b : sbytearr) : int; overload;
    function read(var b : sbytearr; off, len : int) : int; overload;
    function skip(n : long) : long;
    function available : int;
    procedure close;
  end;

function implementsObjectInput(cls : TClass) : boolean; overload;
function implementsObjectInput(obj : NPLObject) : boolean; overload;

implementation

function implementsObjectInput(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(ObjectInput) <> nil);
end;

function implementsObjectInput(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(ObjectInput) <> nil);
end;

end.
