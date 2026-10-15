unit npl_io_ObjectOutput;

interface

uses
  npl
  ,npl_io_DataOutput
  ;

const
  OBJECTOUTPUTGSTR = '{E2DC0C61-68B1-44CE-B618-328AA4B61986}';

type
  ObjectOutput = interface(DataOutput)
    [OBJECTOUTPUTGSTR]
    procedure writeObject(obj : NPLObject);
    procedure flush;
    procedure close;
  end;

function implementsObjectOutput(cls : TClass) : boolean; overload;
function implementsObjectOutput(obj : NPLObject) : boolean; overload;

implementation

function implementsObjectOutput(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(ObjectOutput) <> nil);
end;

function implementsObjectOutput(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(ObjectOutput) <> nil);
end;

end.
