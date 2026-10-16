unit npl_awt_event_ComponentListener;

interface

uses
  npl
  ,npl_awt_event_ComponentEvent
  ,npl_util_EventListener
  ;

const
  COMPONENTLISTENERGSTR = '{8AE08505-8A15-48B8-8753-6D0F185D9C22}';

type
  ComponentListener = interface(EventListener)
    [COMPONENTLISTENERGSTR]
    procedure componentResized(e : ComponentEvent);
    procedure componentMoved(e : ComponentEvent);
    procedure componentShown(e : ComponentEvent);
    procedure componentHidden(e : ComponentEvent);
  end;

  ArrOfComponentListener = array of ComponentListener;

function implementsComponentListener(cls : TClass) : boolean; overload;
function implementsComponentListener(obj : NPLObject) : boolean; overload;

implementation

function implementsComponentListener(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(ComponentListener) <> nil);
end;

function implementsComponentListener(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(ComponentListener) <> nil);
end;

end.
