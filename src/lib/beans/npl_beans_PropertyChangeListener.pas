unit npl_beans_PropertyChangeListener;

interface

uses
  npl_util_EventListener
  ,npl_beans_PropertyChangeEvent
  ;

type
  PropertyChangeListener = interface(EventListener)
  ['{3152F1FB-F2F9-450C-8BF8-24E5DD860E92}']
    procedure propertyChange(evt : PropertyChangeEvent);
  end;

  PropertyChangeListenerArray = array of PropertyChangeListener;

implementation

end.
