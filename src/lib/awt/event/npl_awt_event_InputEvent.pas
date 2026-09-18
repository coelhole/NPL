(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/awt/event/InputEvent.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/awt/event/InputEvent.html
*)
unit npl_awt_event_InputEvent;

interface

uses
  npl
  ,npl_awt_Component
  ,npl_awt_Event
  ,npl_awt_event_ComponentEvent
  ;

const
  SHIFT_MASK = npl_awt_Event.SHIFT_MASK;
  CTRL_MASK = npl_awt_Event.CTRL_MASK;
  META_MASK = npl_awt_Event.META_MASK;
  ALT_MASK = npl_awt_Event.ALT_MASK;
  ALT_GRAPH_MASK = 1 shl 5;
  BUTTON1_MASK = 1 shl 4;
  BUTTON2_MASK = npl_awt_Event.ALT_MASK;
  BUTTON3_MASK = npl_awt_Event.META_MASK;
  SHIFT_DOWN_MASK = 1 shl 6;
  CTRL_DOWN_MASK = 1 shl 7;
  META_DOWN_MASK = 1 shl 8;
  ALT_DOWN_MASK = 1 shl 9;
  BUTTON1_DOWN_MASK = 1 shl 10;
  BUTTON2_DOWN_MASK = 1 shl 11;
  BUTTON3_DOWN_MASK = 1 shl 12;
  ALT_GRAPH_DOWN_MASK = 1 shl 13;

type
  InputEvent = class(ComponentEvent)
  private
    class function getButtonDownMasks : intarr;
  protected
    //
    fWhen : long;
    fModifiers : int;
  public
    constructor create(source : AWTComponent; id : int; when : long; modifiers : int); virtual;
    function isShiftDown : boolean; virtual;
    function isControlDown : boolean; virtual;
    function isMetaDown : boolean; virtual;
    function isAltDown : boolean; virtual;
    function isAltGraphDown : boolean; virtual;
    function getWhen : long; virtual;
    function getModifiers : int; virtual;
    function getModifiersEx : int; virtual;
    procedure consume; override;
    function isConsumed : boolean; override;
    class function getMaskForButton(button : int) : int;
    class function getModifiersExText(modifiers : int) : wstring;
  end;

const
  FIRST_HIGH_BIT  = int(1 shl 31);
  HIGH_MODIFIERS  = not(int(long(FIRST_HIGH_BIT) - 1));

implementation

uses
  classes
  ,sysUtils
  ,npl_awt_Toolkit
  ;

var
  BUTTON_DOWN_MASK : intarr;

constructor InputEvent.create(source : AWTComponent; id : int; when : long; modifiers : int);
begin
  inherited create(source, id);
  fWhen := when;
  fModifiers := modifiers;
end;

class function InputEvent.getButtonDownMasks : intarr;
begin
  result := copy(BUTTON_DOWN_MASK,0,length(BUTTON_DOWN_MASK));
end;

class function InputEvent.getMaskForButton(button : int) : int;
begin
  if (button <= 0) or (button > length(BUTTON_DOWN_MASK)) then
    raise IllegalArgumentException.createFmt('button doesn''t exist %d',[button]);
  result := BUTTON_DOWN_MASK[button-1];
end;

function InputEvent.isShiftDown : boolean;
begin
  result := (fModifiers and SHIFT_MASK) <> 0;
end;

function InputEvent.isControlDown : boolean;
begin
  result := (fModifiers and CTRL_MASK) <> 0;
end;

function InputEvent.isMetaDown : boolean;
begin
  result := (fModifiers and META_MASK) <> 0;
end;

function InputEvent.isAltDown : boolean;
begin
  result := (fModifiers and ALT_MASK) <> 0;
end;

function InputEvent.isAltGraphDown : boolean;
begin
  result := (fModifiers and ALT_GRAPH_MASK) <> 0;
end;

function InputEvent.getWhen : long;
begin
  result := fWhen;
end;

const
  _MODIFIERS = SHIFT_DOWN_MASK - 1;

function InputEvent.getModifiers : int;
begin
  result := fModifiers and (_MODIFIERS or HIGH_MODIFIERS);
end;

function InputEvent.getModifiersEx : int;
begin
  result := fModifiers and (not _MODIFIERS);
end;

procedure InputEvent.consume;
begin
  fConsumed := true;
end;

function InputEvent.isConsumed : boolean;
begin
  result := fConsumed;
end;

class function InputEvent.getModifiersExText(modifiers : int) : wstring;
var
  strm : TStringStream;
  buttonNumber, mask : int;
begin
  result := '';
  strm := TStringStream.create('');
  try
    if (modifiers and npl_awt_event_InputEvent.META_DOWN_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.meta', 'Meta'), '+'));
    if (modifiers and npl_awt_event_InputEvent.CTRL_DOWN_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.control', 'Ctrl'), '+'));
    if (modifiers and npl_awt_event_InputEvent.ALT_DOWN_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.alt', 'Alt'), '+'));
    if (modifiers and npl_awt_event_InputEvent.SHIFT_DOWN_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.shift', 'Shift'), '+'));
    if (modifiers and npl_awt_event_InputEvent.ALT_GRAPH_DOWN_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.altGraph', 'Alt Graph'), '+'));
    for buttonNumber:=1 to length(BUTTON_DOWN_MASK) do begin
      mask := BUTTON_DOWN_MASK[buttonNumber-1];
      if (modifiers and mask) <> 0 then
        strm.writeString(concat(Toolkit.getProperty(format('%s%d',['AWT.button',buttonNumber]), format('%s%d',['Button',buttonNumber])), '+'));
    end;
    if strm.position>0 then
      result := copy(strm.dataString, 1, strm.position-1);
  finally
    strm.free;
  end;
end;

initialization
  setLength(BUTTON_DOWN_MASK,20);
  BUTTON_DOWN_MASK[0]   := BUTTON1_DOWN_MASK;
  BUTTON_DOWN_MASK[1]   := BUTTON2_DOWN_MASK;
  BUTTON_DOWN_MASK[2]   := BUTTON3_DOWN_MASK;
  BUTTON_DOWN_MASK[3]   := 1 shl 14;
  BUTTON_DOWN_MASK[4]   := 1 shl 15;
  BUTTON_DOWN_MASK[5]   := 1 shl 16;
  BUTTON_DOWN_MASK[6]   := 1 shl 17;
  BUTTON_DOWN_MASK[7]   := 1 shl 18;
  BUTTON_DOWN_MASK[8]   := 1 shl 19;
  BUTTON_DOWN_MASK[9]   := 1 shl 20;
  BUTTON_DOWN_MASK[10]  := 1 shl 21;
  BUTTON_DOWN_MASK[11]  := 1 shl 22;
  BUTTON_DOWN_MASK[12]  := 1 shl 23;
  BUTTON_DOWN_MASK[13]  := 1 shl 24;
  BUTTON_DOWN_MASK[14]  := 1 shl 25;
  BUTTON_DOWN_MASK[15]  := 1 shl 26;
  BUTTON_DOWN_MASK[16]  := 1 shl 27;
  BUTTON_DOWN_MASK[17]  := 1 shl 28;
  BUTTON_DOWN_MASK[18]  := 1 shl 29;
  BUTTON_DOWN_MASK[19]  := 1 shl 30;
end.
