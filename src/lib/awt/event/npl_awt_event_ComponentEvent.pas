(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/awt/event/ComponentEvent.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/awt/event/ComponentEvent.html
*)
unit npl_awt_event_ComponentEvent;

interface

uses
  npl
  ,npl_awt_AWTEvent
  ,npl_awt_Component
  ,npl_awt_geom
  ;

const
  COMPONENT_FIRST     = 100;
  COMPONENT_LAST      = 103;
  COMPONENT_MOVED     = COMPONENT_FIRST;
  COMPONENT_RESIZED   = 1 + COMPONENT_FIRST;
  COMPONENT_SHOWN     = 2 + COMPONENT_FIRST;
  COMPONENT_HIDDEN    = 3 + COMPONENT_FIRST;

type
  ComponentEvent=class(AWTEvent)
  public
    constructor create(source : AWTComponent; id : int); virtual;
    function getComponent : AWTComponent; virtual;
    function paramString : string; override;
  end;

implementation

uses
  SysUtils;

constructor ComponentEvent.create(source : AWTComponent; id : int);
begin
  inherited create(source, id);
end;

function ComponentEvent.getComponent : AWTComponent;
begin
  result := NIL;
  if source = NIL then
    exit;
  if source is AWTComponent then
    result := AWTComponent(source);
end;

function ComponentEvent.paramString : string;
var
  b : AWTRectangle;
  comp : AWTComponent;
begin
  b.x := 0;
  b.y := 0;
  b.width := 0;
  b.height := 0;
  comp := getComponent;  
  if comp<>NIL then
    b := comp.bounds;
  case fId of
    COMPONENT_SHOWN   : result := 'COMPONENT_SHOWN';
    COMPONENT_HIDDEN  : result := 'COMPONENT_HIDDEN';
    COMPONENT_MOVED   : result := format('%s (%d,%d %dx%d)',['COMPONENT_MOVED',   b.x,b.y,b.width,b.height]);
    COMPONENT_RESIZED : result := format('%s (%d,%d %dx%d)',['COMPONENT_RESIZED', b.x,b.y,b.width,b.height]);
    else result := 'unknown type';
  end;
end;

end.
