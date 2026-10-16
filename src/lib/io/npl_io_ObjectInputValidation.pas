unit npl_io_ObjectInputValidation;

interface

uses
  npl
  ;

const
  OBJECTINPUTVALIDATIONGSTR = '{3F53D4EC-CDD0-49EB-8DC2-061C06EEDEA4}';

type
  ObjectInputValidation = interface(INPLObject)
    [OBJECTINPUTVALIDATIONGSTR]
    procedure validateObject;
  end;

  ArrOfObjectInputValidation = array of ObjectInputValidation;

function implementsObjectInputValidation(cls : TClass) : boolean; overload;
function implementsObjectInputValidation(obj : NPLObject) : boolean; overload;

implementation

function implementsObjectInputValidation(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(ObjectInputValidation) <> nil);
end;

function implementsObjectInputValidation(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(ObjectInputValidation) <> nil);
end;

end.
