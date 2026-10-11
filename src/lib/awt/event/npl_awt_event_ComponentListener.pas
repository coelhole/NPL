unit npl_awt_event_ComponentListener;

interface

uses
  npl_awt_event_ComponentEvent
  ,npl_util_EventListener
  ;

type
  ComponentListener = interface(EventListener)
  ['{8AE08505-8A15-48B8-8753-6D0F185D9C22}']
    procedure componentResized(e : ComponentEvent);
    procedure componentMoved(e : ComponentEvent);
    procedure componentShown(e : ComponentEvent);
    procedure componentHidden(e : ComponentEvent);
  end;

implementation

end.
