unit npl_util_EventListener;

interface

uses
  npl
  ;

const
  EVENTLISTENERGSTR = '{29523773-A6C7-469B-89BB-B485F49124DE}';

type
  EventListener = interface(IObject)
    [EVENTLISTENERGSTR]
  end;

function implementsEventListener(cls : TClass) : boolean; overload;
function implementsEventListener(obj : NPLObject) : boolean; overload;

implementation

function implementsEventListener(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(EventListener) <> nil);
end;

function implementsEventListener(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(EventListener) <> nil);
end;

end.
