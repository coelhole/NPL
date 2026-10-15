unit npl_beans_PropertyChangeListener;

interface

uses
  npl
  ,npl_util_EventListener
  ,npl_beans_PropertyChangeEvent
  ;

const
  PROPERTYCHANGELISTENERGSTR = '{3152F1FB-F2F9-450C-8BF8-24E5DD860E92}';

type
  PropertyChangeListener = interface(EventListener)
    [PROPERTYCHANGELISTENERGSTR]
    procedure propertyChange(evt : PropertyChangeEvent);
  end;

  PropertyChangeListenerArray = array of PropertyChangeListener;

function implementsPropertyChangeListener(cls : TClass) : boolean; overload;
function implementsPropertyChangeListener(obj : NPLObject) : boolean; overload;

implementation

function implementsPropertyChangeListener(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(PropertyChangeListener) <> nil);
end;

function implementsPropertyChangeListener(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(PropertyChangeListener) <> nil);
end;

end.
