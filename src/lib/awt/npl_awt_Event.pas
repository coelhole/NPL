(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/awt/Event.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/awt/Event.html
*)
unit npl_awt_Event;

interface

uses
  npl;

const
  SHIFT_MASK          = 1 shl 0;
  CTRL_MASK           = 1 shl 1;
  META_MASK           = 1 shl 2;
  ALT_MASK            = 1 shl 3;
  HOME                = 1000;
  END_                = 1001;
  PGUP                = 1002;
  PGDN                = 1003;
  UP                  = 1004;
  DOWN                = 1005;
  LEFT                = 1006;
  RIGHT               = 1007;
  F1                  = 1008;
  F2                  = 1009;
  F3                  = 1010;
  F4                  = 1011;
  F5                  = 1012;
  F6                  = 1013;
  F7                  = 1014;
  F8                  = 1015;
  F9                  = 1016;
  F10                 = 1017;
  F11                 = 1018;
  F12                 = 1019;
  PRINT_SCREEN        = 1020;
  SCROLL_LOCK         = 1021;
  CAPS_LOCK           = 1022;
  NUM_LOCK            = 1023;
  PAUSE               = 1024;
  INSERT              = 1025;
  ENTER               = 10;
  BACK_SPACE          = 8;
  TAB                 = 9;
  ESCAPE              = 27;
  DELETE              = 127;
  WINDOW_EVENT        = 200;
  WINDOW_DESTROY      = 1 + WINDOW_EVENT;
  WINDOW_EXPOSE       = 2 + WINDOW_EVENT;
  WINDOW_ICONIFY      = 3 + WINDOW_EVENT;
  WINDOW_DEICONIFY    = 4 + WINDOW_EVENT;
  WINDOW_MOVED        = 5 + WINDOW_EVENT;
  KEY_EVENT           = 400;
  KEY_PRESS           = 1 + KEY_EVENT;
  KEY_RELEASE         = 2 + KEY_EVENT;
  KEY_ACTION          = 3 + KEY_EVENT;
  KEY_ACTION_RELEASE  = 4 + KEY_EVENT;
  MOUSE_EVENT         = 500;
  MOUSE_DOWN          = 1 + MOUSE_EVENT;
  MOUSE_UP            = 2 + MOUSE_EVENT;
  MOUSE_MOVE          = 3 + MOUSE_EVENT;
  MOUSE_ENTER         = 4 + MOUSE_EVENT;
  MOUSE_EXIT          = 5 + MOUSE_EVENT;
  MOUSE_DRAG          = 6 + MOUSE_EVENT;
  SCROLL_EVENT        = 600;
  SCROLL_LINE_UP      = 1 + SCROLL_EVENT;
  SCROLL_LINE_DOWN    = 2 + SCROLL_EVENT;
  SCROLL_PAGE_UP      = 3 + SCROLL_EVENT;
  SCROLL_PAGE_DOWN    = 4 + SCROLL_EVENT;
  SCROLL_ABSOLUTE     = 5 + SCROLL_EVENT;
  SCROLL_BEGIN        = 6 + SCROLL_EVENT;
  SCROLL_END          = 7 + SCROLL_EVENT;
  LIST_EVENT          = 700;
  LIST_SELECT         = 1 + LIST_EVENT;
  LIST_DESELECT       = 2 + LIST_EVENT;
  MISC_EVENT          = 1000;
  ACTION_EVENT        = 1 + MISC_EVENT;
  LOAD_FILE           = 2 + MISC_EVENT;
  SAVE_FILE           = 3 + MISC_EVENT;
  GOT_FOCUS           = 4 + MISC_EVENT;
  LOST_FOCUS          = 5 + MISC_EVENT;

type
  Event = class(NPLObject)
  private
    fConsumed : boolean;
  protected
    fData : long;
  public
    target : NPLObject;
    when : long;
    id : int;
    x : int;
    y : int;
    key : int;
    modifiers : int;
    clickCount : int;
    arg : NPLObject;
    evt : Event;
  end;

implementation

end.
