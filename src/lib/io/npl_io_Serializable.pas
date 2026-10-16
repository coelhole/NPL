unit npl_io_Serializable;

interface

uses
  npl
  ;

const
  SERIALIZABLEGSTR = '{C6F8FD39-B54C-43FA-9CBD-10442F925C86}';

type
  Serializable = interface(NPLInterface)
    [SERIALIZABLEGSTR]
  end;

  ArrOfSerializable = array of Serializable;

function implementsSerializable(cls : TClass) : boolean; overload;
function implementsSerializable(obj : NPLObject) : boolean; overload;

implementation

function implementsSerializable(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(Serializable) <> nil);
end;

function implementsSerializable(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(Serializable) <> nil);
end;

end.
