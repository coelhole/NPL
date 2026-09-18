(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/awt/AWTEvent.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/awt/AWTEvent.html
*)
unit npl_awt_AWTEvent;

interface

uses
  npl
  ,npl_awt_Event
  ,npl_util_EventObject
  ;

const
  COMPONENT_EVENT_MASK        : long  = $01;
  CONTAINER_EVENT_MASK        : long  = $02;
  FOCUS_EVENT_MASK            : long  = $04;
  KEY_EVENT_MASK              : long  = $08;
  MOUSE_EVENT_MASK            : long  = $10;
  MOUSE_MOTION_EVENT_MASK     : long  = $20;
  WINDOW_EVENT_MASK           : long  = $40;
  ACTION_EVENT_MASK           : long  = $80;
  ADJUSTMENT_EVENT_MASK       : long  = $100;
  ITEM_EVENT_MASK             : long  = $200;
  TEXT_EVENT_MASK             : long  = $400;
  INPUT_METHOD_EVENT_MASK     : long  = $800;
  INPUT_METHODS_ENABLED_MASK  : long  = $1000;
  PAINT_EVENT_MASK            : long  = $2000;
  INVOCATION_EVENT_MASK       : long  = $4000;
  HIERARCHY_EVENT_MASK        : long  = $8000;
  HIERARCHY_BOUNDS_EVENT_MASK : long  = $10000;
  MOUSE_WHEEL_EVENT_MASK      : long  = $20000;
  WINDOW_STATE_EVENT_MASK     : long  = $40000;
  WINDOW_FOCUS_EVENT_MASK     : long  = $80000;
  RESERVED_ID_MAX             : int   = 1999;

type
  AWTEvent = class(EventObject)
  private
    fBdata : array of sbyte;
    fIsSystemGenerated : boolean;
  protected
    fId : int;
    fConsumed : boolean;

    //
    fFocusManagerIsDispatching : boolean;
    fIsPosted : boolean;
    procedure consume; virtual;
    function isConsumed : boolean; virtual;
  public
    constructor create(source : NPLObject; id : int); overload; virtual;
    constructor create(event : Event); overload; virtual;
    function getID : int; virtual;
    function paramString : string; virtual;
  end;

implementation

constructor AWTEvent.create(source : NPLObject; id : int);
begin
  inherited create(source);
  fId := id;
(*
        switch(id) {
          case ActionEvent.ACTION_PERFORMED:
          case ItemEvent.ITEM_STATE_CHANGED:
          case AdjustmentEvent.ADJUSTMENT_VALUE_CHANGED:
          case TextEvent.TEXT_VALUE_CHANGED:
            consumed = true;
            break;
          default:
        }
*)
end;

constructor AWTEvent.create(event : Event);
begin
  create(event.target, event.id);
end;

function AWTEvent.getID : int;
begin
  result := fId;
end;

function AWTEvent.paramString : string;
begin
  result := '';
end;

procedure AWTEvent.consume;
begin
(*
        switch(id) {
          case KeyEvent.KEY_PRESSED:
          case KeyEvent.KEY_RELEASED:
          case MouseEvent.MOUSE_PRESSED:
          case MouseEvent.MOUSE_RELEASED:
          case MouseEvent.MOUSE_MOVED:
          case MouseEvent.MOUSE_DRAGGED:
          case MouseEvent.MOUSE_ENTERED:
          case MouseEvent.MOUSE_EXITED:
          case MouseEvent.MOUSE_WHEEL:
          case InputMethodEvent.INPUT_METHOD_TEXT_CHANGED:
          case InputMethodEvent.CARET_POSITION_CHANGED:
              consumed = true;
              break;
          default:
              // event type cannot be consumed
        }
*)
end;

function AWTEvent.isConsumed : boolean;
begin
  result := fConsumed;
end;

end.
