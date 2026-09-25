(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/awt/event/KeyEvent.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/awt/event/KeyEvent.html
*)
unit npl_awt_event_KeyEvent;

interface

uses
  npl
  ,npl_awt_Component
  ,npl_awt_event_InputEvent
  ;

const
  KEY_FIRST                     = 400;
  KEY_LAST                      = 402;
  KEY_TYPED                     = KEY_FIRST;
  KEY_PRESSED                   = 1 + KEY_FIRST; //npl_awt_Event.KEY_PRESS
  KEY_RELEASED                  = 2 + KEY_FIRST; //npl_awt_Event.KEY_RELEASE
  VK_ENTER                      = 13;
  VK_BACK_SPACE                 = 8;
  VK_TAB                        = 9;
  VK_CANCEL                     = $03;
  VK_CLEAR                      = $0C;
  VK_SHIFT                      = $10;
  VK_CONTROL                    = $11;
  VK_ALT                        = $12;
  VK_PAUSE                      = $13;
  VK_CAPS_LOCK                  = $14;
  VK_ESCAPE                     = $1B;
  VK_SPACE                      = $20;
  VK_PAGE_UP                    = $21;
  VK_PAGE_DOWN                  = $22;
  VK_END                        = $23;
  VK_HOME                       = $24;
  VK_LEFT                       = $25;
  VK_UP                         = $26;
  VK_RIGHT                      = $27;
  VK_DOWN                       = $28;
  VK_COMMA                      = $2C;
  VK_MINUS                      = $2D;
  VK_PERIOD                     = $2E;
  VK_SLASH                      = $2F;
  VK_0                          = $30;
  VK_1                          = $31;
  VK_2                          = $32;
  VK_3                          = $33;
  VK_4                          = $34;
  VK_5                          = $35;
  VK_6                          = $36;
  VK_7                          = $37;
  VK_8                          = $38;
  VK_9                          = $39;
  VK_SEMICOLON                  = $3B;
  VK_EQUALS                     = $3D;
  VK_A                          = $41;
  VK_B                          = $42;
  VK_C                          = $43;
  VK_D                          = $44;
  VK_E                          = $45;
  VK_F                          = $46;
  VK_G                          = $47;
  VK_H                          = $48;
  VK_I                          = $49;
  VK_J                          = $4A;
  VK_K                          = $4B;
  VK_L                          = $4C;
  VK_M                          = $4D;
  VK_N                          = $4E;
  VK_O                          = $4F;
  VK_P                          = $50;
  VK_Q                          = $51;
  VK_R                          = $52;
  VK_S                          = $53;
  VK_T                          = $54;
  VK_U                          = $55;
  VK_V                          = $56;
  VK_W                          = $57;
  VK_X                          = $58;
  VK_Y                          = $59;
  VK_Z                          = $5A;
  VK_OPEN_BRACKET               = $5B;
  VK_BACK_SLASH                 = $5C;
  VK_CLOSE_BRACKET              = $5D;
  VK_NUMPAD0                    = $60;
  VK_NUMPAD1                    = $61;
  VK_NUMPAD2                    = $62;
  VK_NUMPAD3                    = $63;
  VK_NUMPAD4                    = $64;
  VK_NUMPAD5                    = $65;
  VK_NUMPAD6                    = $66;
  VK_NUMPAD7                    = $67;
  VK_NUMPAD8                    = $68;
  VK_NUMPAD9                    = $69;
  VK_MULTIPLY                   = $6A;
  VK_ADD                        = $6B;
  VK_SEPARATER                  = $6C;
  VK_SEPARATOR                  = VK_SEPARATER;
  VK_SUBTRACT                   = $6D;
  VK_DECIMAL                    = $6E;
  VK_DIVIDE                     = $6F;
  VK_DELETE                     = $7F; //ASCII DEL
  VK_NUM_LOCK                   = $90;
  VK_SCROLL_LOCK                = $91;
  VK_F1                         = $70;
  VK_F2                         = $71;
  VK_F3                         = $72;
  VK_F4                         = $73;
  VK_F5                         = $74;
  VK_F6                         = $75;
  VK_F7                         = $76;
  VK_F8                         = $77;
  VK_F9                         = $78;
  VK_F10                        = $79;
  VK_F11                        = $7A;
  VK_F12                        = $7B;
  VK_F13                        = $F000;
  VK_F14                        = $F001;
  VK_F15                        = $F002;
  VK_F16                        = $F003;
  VK_F17                        = $F004;
  VK_F18                        = $F005;
  VK_F19                        = $F006;
  VK_F20                        = $F007;
  VK_F21                        = $F008;
  VK_F22                        = $F009;
  VK_F23                        = $F00A;
  VK_F24                        = $F00B;
  VK_PRINTSCREEN                = $9A;
  VK_INSERT                     = $9B;
  VK_HELP                       = $9C;
  VK_META                       = $9D;
  VK_BACK_QUOTE                 = $C0;
  VK_QUOTE                      = $DE;
  VK_KP_UP                      = $E0;
  VK_KP_DOWN                    = $E1;
  VK_KP_LEFT                    = $E2;
  VK_KP_RIGHT                   = $E3;
  VK_DEAD_GRAVE                 = $80;
  VK_DEAD_ACUTE                 = $81;
  VK_DEAD_CIRCUMFLEX            = $82;
  VK_DEAD_TILDE                 = $83;
  VK_DEAD_MACRON                = $84;
  VK_DEAD_BREVE                 = $85;
  VK_DEAD_ABOVEDOT              = $86;
  VK_DEAD_DIAERESIS             = $87;
  VK_DEAD_ABOVERING             = $88;
  VK_DEAD_DOUBLEACUTE           = $89;
  VK_DEAD_CARON                 = $8a;
  VK_DEAD_CEDILLA               = $8b;
  VK_DEAD_OGONEK                = $8c;
  VK_DEAD_IOTA                  = $8d;
  VK_DEAD_VOICED_SOUND          = $8e;
  VK_DEAD_SEMIVOICED_SOUND      = $8f;
  VK_AMPERSAND                  = $96;
  VK_ASTERISK                   = $97;
  VK_QUOTEDBL                   = $98;
  VK_LESS                       = $99;
  VK_GREATER                    = $a0;
  VK_BRACELEFT                  = $a1;
  VK_BRACERIGHT                 = $a2;
  VK_AT                         = $0200;
  VK_COLON                      = $0201;
  VK_CIRCUMFLEX                 = $0202;
  VK_DOLLAR                     = $0203;
  VK_EURO_SIGN                  = $0204;
  VK_EXCLAMATION_MARK           = $0205;
  VK_INVERTED_EXCLAMATION_MARK  = $0206;
  VK_LEFT_PARENTHESIS           = $0207;
  VK_NUMBER_SIGN                = $0208;
  VK_PLUS                       = $0209;
  VK_RIGHT_PARENTHESIS          = $020A;
  VK_UNDERSCORE                 = $020B;
  VK_WINDOWS                    = $020C;
  VK_CONTEXT_MENU               = $020D;
  VK_FINAL                      = $0018;
  VK_CONVERT                    = $001C;
  VK_NONCONVERT                 = $001D;
  VK_ACCEPT                     = $001E;
  VK_MODECHANGE                 = $001F;
  VK_KANA                       = $0015;
  VK_KANJI                      = $0019;
  VK_ALPHANUMERIC               = $00F0;
  VK_KATAKANA                   = $00F1;
  VK_HIRAGANA                   = $00F2;
  VK_FULL_WIDTH                 = $00F3;
  VK_HALF_WIDTH                 = $00F4;
  VK_ROMAN_CHARACTERS           = $00F5;
  VK_ALL_CANDIDATES             = $0100;
  VK_PREVIOUS_CANDIDATE         = $0101;
  VK_CODE_INPUT                 = $0102;
  VK_JAPANESE_KATAKANA          = $0103;
  VK_JAPANESE_HIRAGANA          = $0104;
  VK_JAPANESE_ROMAN             = $0105;
  VK_KANA_LOCK                  = $0106;
  VK_INPUT_METHOD_ON_OFF        = $0107;
  VK_CUT                        = $FFD1;
  VK_COPY                       = $FFCD;
  VK_PASTE                      = $FFCF;
  VK_UNDO                       = $FFCB;
  VK_AGAIN                      = $FFC9;
  VK_FIND                       = $FFD0;
  VK_PROPS                      = $FFCA;
  VK_STOP                       = $FFC8;
  VK_COMPOSE                    = $FF20;
  VK_ALT_GRAPH                  = $FF7E;
  VK_BEGIN                      = $FF58;
  VK_UNDEFINED                  = $0;
  CHAR_UNDEFINED                = $FFFF;
  KEY_LOCATION_UNKNOWN          = 0;
  KEY_LOCATION_STANDARD         = 1;
  KEY_LOCATION_LEFT             = 2;
  KEY_LOCATION_RIGHT            = 3;
  KEY_LOCATION_NUMPAD           = 4;

type
  KeyEvent=class(InputEvent)
  private
    fIsProxyActive : boolean;
    fRawCode : long;
    fPrimaryLevelUnicode : long;
    fScancode : long;
    fExtendedKeyCode : long;
    constructor create(source : AWTComponent; id : int; when : long; modifiers : int;
                    keyCode : int; keyChar : uchar; keyLocation : int; isProxyActive : boolean); overload;
    procedure setNewModifiers;
    procedure setOldModifiers;
  protected
    //
    fKeyCode : int;
    fKeyChar : uchar;
    fKeyLocation : int;
  public
    constructor create(source : AWTComponent; id : int; when : long; modifiers : int;
      keyCode : int; keyChar : uchar; keyLocation : int); overload; virtual;
    constructor create(source : AWTComponent; id : int; when : long; modifiers : int;
      keyCode : int; keyChar : uchar); overload; virtual;
    constructor create(source : AWTComponent; id : int; when : long; modifiers : int;
      keyCode : int); overload; {$IFDEF DELPHI6UPORFPC}deprecated;{$ENDIF}
    function getKeyCode : int; virtual;
    procedure setKeyCode(keyCode : int); virtual;
    function getKeyChar : uchar; virtual;
    procedure setKeyChar(keyChar : uchar); virtual;
    procedure setModifiers(modifiers : int); {$IFDEF DELPHI6UPORFPC}deprecated;{$ENDIF}
    function getKeyLocation : int; virtual;
    function isActionKey : boolean; virtual;
    class function getKeyText(keyCode : int) : ustring;
    class function getKeyModifiersText(modifiers : int) : ustring;
  end;

implementation

uses
  classes
  ,sysUtils
  ,npl_awt_Toolkit  
  ;

constructor KeyEvent.create(source : AWTComponent; id : int; when : long; modifiers : int;
  keyCode : int; keyChar : uchar; keyLocation : int; isProxyActive : boolean);
begin
  create(source, id, when, modifiers, keyCode, keyChar, keyLocation);
  fIsProxyActive := isProxyActive;
end;

procedure KeyEvent.setNewModifiers;
begin
  if (fModifiers and npl_awt_event_InputEvent.SHIFT_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.SHIFT_DOWN_MASK;

  if (fModifiers and npl_awt_event_InputEvent.ALT_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.ALT_DOWN_MASK;

  if (fModifiers and npl_awt_event_InputEvent.CTRL_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.CTRL_DOWN_MASK;

  if (fModifiers and npl_awt_event_InputEvent.META_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.META_DOWN_MASK;

  if (fModifiers and npl_awt_event_InputEvent.ALT_GRAPH_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.ALT_GRAPH_DOWN_MASK;

  if (fModifiers and npl_awt_event_InputEvent.BUTTON1_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.BUTTON1_DOWN_MASK;
end;

procedure KeyEvent.setOldModifiers;
begin
  if (fModifiers and npl_awt_event_InputEvent.SHIFT_DOWN_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.SHIFT_MASK;

  if (fModifiers and npl_awt_event_InputEvent.ALT_DOWN_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.ALT_MASK;

  if (fModifiers and npl_awt_event_InputEvent.CTRL_DOWN_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.CTRL_MASK;

  if (fModifiers and npl_awt_event_InputEvent.META_DOWN_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.META_MASK;

  if (fModifiers and npl_awt_event_InputEvent.ALT_GRAPH_DOWN_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.ALT_GRAPH_MASK;

  if (fModifiers and npl_awt_event_InputEvent.BUTTON1_DOWN_MASK) <> 0 then
    fModifiers := fModifiers or npl_awt_event_InputEvent.BUTTON1_MASK;
end;

constructor KeyEvent.create(source : AWTComponent; id : int; when : long; modifiers : int;
  keyCode : int; keyChar : uchar; keyLocation : int);
begin
  inherited create(source, id, when, modifiers);

  fRawCode := 0;
  fPrimaryLevelUnicode := 0;
  fScancode := 0;
  fExtendedKeyCode := 0;

  if id = npl_awt_event_KeyEvent.KEY_TYPED then begin
    if int(keyChar) = npl_awt_event_KeyEvent.CHAR_UNDEFINED then
      raise IllegalArgumentException.create('invalid keyChar');
    if keyCode <> npl_awt_event_KeyEvent.VK_UNDEFINED then
      raise IllegalArgumentException.create('invalid keyCode');
    if keyLocation <> npl_awt_event_KeyEvent.KEY_LOCATION_UNKNOWN then
      raise IllegalArgumentException.create('invalid keyLocation');
  end;

  fKeyCode := keyCode;
  fKeyChar := keyChar;

  if (keyLocation < npl_awt_event_KeyEvent.KEY_LOCATION_UNKNOWN) or
    (keyLocation > npl_awt_event_KeyEvent.KEY_LOCATION_NUMPAD) then
    raise IllegalArgumentException.create('invalid keyLocation');

  fKeyLocation := keyLocation;

  if (getModifiers <> 0) and (getModifiersEx = 0) then
    setNewModifiers
  else if (getModifiers = 0) and (getModifiersEx <> 0) then
    setOldModifiers;
end;

constructor KeyEvent.create(source : AWTComponent; id : int; when : long; modifiers : int;
  keyCode : int; keyChar : uchar);
begin
  create(source, id, when, modifiers, keyCode, keyChar, KEY_LOCATION_UNKNOWN);
end;

constructor KeyEvent.create(source : AWTComponent; id : int; when : long; modifiers : int;
  keyCode : int);
begin
  create(source, id, when, modifiers, keyCode, uchar(keyCode));
end;

function KeyEvent.getKeyCode : int;
begin
  result := fKeyCode;
end;

procedure KeyEvent.setKeyCode(keyCode : int);
begin
  fKeyCode := keyCode;
end;

function KeyEvent.getKeyChar : uchar;
begin
  result := fKeyChar;
end;

procedure KeyEvent.setKeyChar(keyChar : uchar);
begin
  fKeyChar := keyChar;
end;

procedure KeyEvent.setModifiers(modifiers : int);
begin
  fModifiers := modifiers;
  if (getModifiers <> 0) and (getModifiersEx = 0) then
    setNewModifiers
  else if (getModifiers = 0) and (getModifiersEx <> 0) then
    setOldModifiers;
end;

function KeyEvent.getKeyLocation : int;
begin
  result := fKeyLocation;
end;

class function KeyEvent.getKeyText(keyCode : int) : ustring;
var
  numpad, unknown : ustring;
  c : uchar;
begin
  result := '';

  if ((keyCode >= VK_0) and (keyCode <= VK_9)) or
    ((keyCode >= VK_A) and (keyCode <= VK_Z)) then begin
    result := ustring(uchar(keyCode));
    exit;
  end;

  case keyCode of
    VK_ENTER: result := Toolkit.getProperty('AWT.enter', 'Enter');
    VK_BACK_SPACE: result := Toolkit.getProperty('AWT.backSpace', 'Backspace');
    VK_TAB: result := Toolkit.getProperty('AWT.tab', 'Tab');
    VK_CANCEL: result := Toolkit.getProperty('AWT.cancel', 'Cancel');
    VK_CLEAR: result := Toolkit.getProperty('AWT.clear', 'Clear');
    VK_COMPOSE: result := Toolkit.getProperty('AWT.compose', 'Compose');
    VK_PAUSE: result := Toolkit.getProperty('AWT.pause', 'Pause');
    VK_CAPS_LOCK: result := Toolkit.getProperty('AWT.capsLock', 'Caps Lock');
    VK_ESCAPE: result := Toolkit.getProperty('AWT.escape', 'Escape');
    VK_SPACE: result := Toolkit.getProperty('AWT.space', 'Space');
    VK_PAGE_UP: result := Toolkit.getProperty('AWT.pgup', 'Page Up');
    VK_PAGE_DOWN: result := Toolkit.getProperty('AWT.pgdn', 'Page Down');
    VK_END: result := Toolkit.getProperty('AWT.end', 'End');
    VK_HOME: result := Toolkit.getProperty('AWT.home', 'Home');
    VK_LEFT: result := Toolkit.getProperty('AWT.left', 'Left');
    VK_UP: result := Toolkit.getProperty('AWT.up', 'Up');
    VK_RIGHT: result := Toolkit.getProperty('AWT.right', 'Right');
    VK_DOWN: result := Toolkit.getProperty('AWT.down', 'Down');
    VK_BEGIN: result := Toolkit.getProperty('AWT.begin', 'Begin');

    // modifiers
    VK_SHIFT: result := Toolkit.getProperty('AWT.shift', 'Shift');
    VK_CONTROL: result := Toolkit.getProperty('AWT.control', 'Control');
    VK_ALT: result := Toolkit.getProperty('AWT.alt', 'Alt');
    VK_META: result := Toolkit.getProperty('AWT.meta', 'Meta');
    VK_ALT_GRAPH: result := Toolkit.getProperty('AWT.altGraph', 'Alt Graph');

    // punctuation
    VK_COMMA: result := Toolkit.getProperty('AWT.comma', 'Comma');
    VK_PERIOD: result := Toolkit.getProperty('AWT.period', 'Period');
    VK_SLASH: result := Toolkit.getProperty('AWT.slash', 'Slash');
    VK_SEMICOLON: result := Toolkit.getProperty('AWT.semicolon', 'Semicolon');
    VK_EQUALS: result := Toolkit.getProperty('AWT.equals', 'Equals');
    VK_OPEN_BRACKET: result := Toolkit.getProperty('AWT.openBracket', 'Open Bracket');
    VK_BACK_SLASH: result := Toolkit.getProperty('AWT.backSlash', 'Back Slash');
    VK_CLOSE_BRACKET: result := Toolkit.getProperty('AWT.closeBracket', 'Close Bracket');

    // numpad numeric keys handled below
    VK_MULTIPLY: result := Toolkit.getProperty('AWT.multiply', 'NumPad *');
    VK_ADD: result := Toolkit.getProperty('AWT.add', 'NumPad +');
    VK_SEPARATOR: result := Toolkit.getProperty('AWT.separator', 'NumPad ,');
    VK_SUBTRACT: result := Toolkit.getProperty('AWT.subtract', 'NumPad -');
    VK_DECIMAL: result := Toolkit.getProperty('AWT.decimal', 'NumPad .');
    VK_DIVIDE: result := Toolkit.getProperty('AWT.divide', 'NumPad /');
    VK_DELETE: result := Toolkit.getProperty('AWT.delete', 'Delete');
    VK_NUM_LOCK: result := Toolkit.getProperty('AWT.numLock', 'Num Lock');
    VK_SCROLL_LOCK: result := Toolkit.getProperty('AWT.scrollLock', 'Scroll Lock');

    VK_WINDOWS: result := Toolkit.getProperty('AWT.windows', 'Windows');
    VK_CONTEXT_MENU: result := Toolkit.getProperty('AWT.context', 'Context Menu');

    VK_F1: result := Toolkit.getProperty('AWT.f1', 'F1');
    VK_F2: result := Toolkit.getProperty('AWT.f2', 'F2');
    VK_F3: result := Toolkit.getProperty('AWT.f3', 'F3');
    VK_F4: result := Toolkit.getProperty('AWT.f4', 'F4');
    VK_F5: result := Toolkit.getProperty('AWT.f5', 'F5');
    VK_F6: result := Toolkit.getProperty('AWT.f6', 'F6');
    VK_F7: result := Toolkit.getProperty('AWT.f7', 'F7');
    VK_F8: result := Toolkit.getProperty('AWT.f8', 'F8');
    VK_F9: result := Toolkit.getProperty('AWT.f9', 'F9');
    VK_F10: result := Toolkit.getProperty('AWT.f10', 'F10');
    VK_F11: result := Toolkit.getProperty('AWT.f11', 'F11');
    VK_F12: result := Toolkit.getProperty('AWT.f12', 'F12');
    VK_F13: result := Toolkit.getProperty('AWT.f13', 'F13');
    VK_F14: result := Toolkit.getProperty('AWT.f14', 'F14');
    VK_F15: result := Toolkit.getProperty('AWT.f15', 'F15');
    VK_F16: result := Toolkit.getProperty('AWT.f16', 'F16');
    VK_F17: result := Toolkit.getProperty('AWT.f17', 'F17');
    VK_F18: result := Toolkit.getProperty('AWT.f18', 'F18');
    VK_F19: result := Toolkit.getProperty('AWT.f19', 'F19');
    VK_F20: result := Toolkit.getProperty('AWT.f20', 'F20');
    VK_F21: result := Toolkit.getProperty('AWT.f21', 'F21');
    VK_F22: result := Toolkit.getProperty('AWT.f22', 'F22');
    VK_F23: result := Toolkit.getProperty('AWT.f23', 'F23');
    VK_F24: result := Toolkit.getProperty('AWT.f24', 'F24');

    VK_PRINTSCREEN: result := Toolkit.getProperty('AWT.printScreen', 'Print Screen');
    VK_INSERT: result := Toolkit.getProperty('AWT.insert', 'Insert');
    VK_HELP: result := Toolkit.getProperty('AWT.help', 'Help');
    VK_BACK_QUOTE: result := Toolkit.getProperty('AWT.backQuote', 'Back Quote');
    VK_QUOTE: result := Toolkit.getProperty('AWT.quote', 'Quote');

    VK_KP_UP: result := Toolkit.getProperty('AWT.up', 'Up');
    VK_KP_DOWN: result := Toolkit.getProperty('AWT.down', 'Down');
    VK_KP_LEFT: result := Toolkit.getProperty('AWT.left', 'Left');
    VK_KP_RIGHT: result := Toolkit.getProperty('AWT.right', 'Right');

    VK_DEAD_GRAVE: result := Toolkit.getProperty('AWT.deadGrave', 'Dead Grave');
    VK_DEAD_ACUTE: result := Toolkit.getProperty('AWT.deadAcute', 'Dead Acute');
    VK_DEAD_CIRCUMFLEX: result := Toolkit.getProperty('AWT.deadCircumflex', 'Dead Circumflex');
    VK_DEAD_TILDE: result := Toolkit.getProperty('AWT.deadTilde', 'Dead Tilde');
    VK_DEAD_MACRON: result := Toolkit.getProperty('AWT.deadMacron', 'Dead Macron');
    VK_DEAD_BREVE: result := Toolkit.getProperty('AWT.deadBreve', 'Dead Breve');
    VK_DEAD_ABOVEDOT: result := Toolkit.getProperty('AWT.deadAboveDot', 'Dead Above Dot');
    VK_DEAD_DIAERESIS: result := Toolkit.getProperty('AWT.deadDiaeresis', 'Dead Diaeresis');
    VK_DEAD_ABOVERING: result := Toolkit.getProperty('AWT.deadAboveRing', 'Dead Above Ring');
    VK_DEAD_DOUBLEACUTE: result := Toolkit.getProperty('AWT.deadDoubleAcute', 'Dead Double Acute');
    VK_DEAD_CARON: result := Toolkit.getProperty('AWT.deadCaron', 'Dead Caron');
    VK_DEAD_CEDILLA: result := Toolkit.getProperty('AWT.deadCedilla', 'Dead Cedilla');
    VK_DEAD_OGONEK: result := Toolkit.getProperty('AWT.deadOgonek', 'Dead Ogonek');
    VK_DEAD_IOTA: result := Toolkit.getProperty('AWT.deadIota', 'Dead Iota');
    VK_DEAD_VOICED_SOUND: result := Toolkit.getProperty('AWT.deadVoicedSound', 'Dead Voiced Sound');
    VK_DEAD_SEMIVOICED_SOUND: result := Toolkit.getProperty('AWT.deadSemivoicedSound', 'Dead Semivoiced Sound');

    VK_AMPERSAND: result := Toolkit.getProperty('AWT.ampersand', 'Ampersand');
    VK_ASTERISK: result := Toolkit.getProperty('AWT.asterisk', 'Asterisk');
    VK_QUOTEDBL: result := Toolkit.getProperty('AWT.quoteDbl', 'Double Quote');
    VK_LESS: result := Toolkit.getProperty('AWT.Less', 'Less');
    VK_GREATER: result := Toolkit.getProperty('AWT.greater', 'Greater');
    VK_BRACELEFT: result := Toolkit.getProperty('AWT.braceLeft', 'Left Brace');
    VK_BRACERIGHT: result := Toolkit.getProperty('AWT.braceRight', 'Right Brace');
    VK_AT: result := Toolkit.getProperty('AWT.at', 'At');
    VK_COLON: result := Toolkit.getProperty('AWT.colon', 'Colon');
    VK_CIRCUMFLEX: result := Toolkit.getProperty('AWT.circumflex', 'Circumflex');
    VK_DOLLAR: result := Toolkit.getProperty('AWT.dollar', 'Dollar');
    VK_EURO_SIGN: result := Toolkit.getProperty('AWT.euro', 'Euro');
    VK_EXCLAMATION_MARK: result := Toolkit.getProperty('AWT.exclamationMark', 'Exclamation Mark');
    VK_INVERTED_EXCLAMATION_MARK: result := Toolkit.getProperty('AWT.invertedExclamationMark', 'Inverted Exclamation Mark');
    VK_LEFT_PARENTHESIS: result := Toolkit.getProperty('AWT.leftParenthesis', 'Left Parenthesis');
    VK_NUMBER_SIGN: result := Toolkit.getProperty('AWT.numberSign', 'Number Sign');
    VK_MINUS: result := Toolkit.getProperty('AWT.minus', 'Minus');
    VK_PLUS: result := Toolkit.getProperty('AWT.plus', 'Plus');
    VK_RIGHT_PARENTHESIS: result := Toolkit.getProperty('AWT.rightParenthesis', 'Right Parenthesis');
    VK_UNDERSCORE: result := Toolkit.getProperty('AWT.underscore', 'Underscore');

    VK_FINAL: result := Toolkit.getProperty('AWT.final', 'Final');
    VK_CONVERT: result := Toolkit.getProperty('AWT.convert', 'Convert');
    VK_NONCONVERT: result := Toolkit.getProperty('AWT.noconvert', 'No Convert');
    VK_ACCEPT: result := Toolkit.getProperty('AWT.accept', 'Accept');
    VK_MODECHANGE: result := Toolkit.getProperty('AWT.modechange', 'Mode Change');
    VK_KANA: result := Toolkit.getProperty('AWT.kana', 'Kana');
    VK_KANJI: result := Toolkit.getProperty('AWT.kanji', 'Kanji');
    VK_ALPHANUMERIC: result := Toolkit.getProperty('AWT.alphanumeric', 'Alphanumeric');
    VK_KATAKANA: result := Toolkit.getProperty('AWT.katakana', 'Katakana');
    VK_HIRAGANA: result := Toolkit.getProperty('AWT.hiragana', 'Hiragana');
    VK_FULL_WIDTH: result := Toolkit.getProperty('AWT.fullWidth', 'Full-Width');
    VK_HALF_WIDTH: result := Toolkit.getProperty('AWT.halfWidth', 'Half-Width');
    VK_ROMAN_CHARACTERS: result := Toolkit.getProperty('AWT.romanCharacters', 'Roman Characters');
    VK_ALL_CANDIDATES: result := Toolkit.getProperty('AWT.allCandidates', 'All Candidates');
    VK_PREVIOUS_CANDIDATE: result := Toolkit.getProperty('AWT.previousCandidate', 'Previous Candidate');
    VK_CODE_INPUT: result := Toolkit.getProperty('AWT.codeInput', 'Code Input');
    VK_JAPANESE_KATAKANA: result := Toolkit.getProperty('AWT.japaneseKatakana', 'Japanese Katakana');
    VK_JAPANESE_HIRAGANA: result := Toolkit.getProperty('AWT.japaneseHiragana', 'Japanese Hiragana');
    VK_JAPANESE_ROMAN: result := Toolkit.getProperty('AWT.japaneseRoman', 'Japanese Roman');
    VK_KANA_LOCK: result := Toolkit.getProperty('AWT.kanaLock', 'Kana Lock');
    VK_INPUT_METHOD_ON_OFF: result := Toolkit.getProperty('AWT.inputMethodOnOff', 'Input Method On/Off');

    VK_AGAIN: result := Toolkit.getProperty('AWT.again', 'Again');
    VK_UNDO: result := Toolkit.getProperty('AWT.undo', 'Undo');
    VK_COPY: result := Toolkit.getProperty('AWT.copy', 'Copy');
    VK_PASTE: result := Toolkit.getProperty('AWT.paste', 'Paste');
    VK_CUT: result := Toolkit.getProperty('AWT.cut', 'Cut');
    VK_FIND: result := Toolkit.getProperty('AWT.find', 'Find');
    VK_PROPS: result := Toolkit.getProperty('AWT.props', 'Props');
    VK_STOP: result := Toolkit.getProperty('AWT.stop', 'Stop');
  end;

  if result<>'' then
    exit;

  if (keyCode >= VK_NUMPAD0) and (keyCode <= VK_NUMPAD9) then begin
    numpad := Toolkit.getProperty('AWT.numpad', 'NumPad');
    c := uchar(keyCode - VK_NUMPAD0 + int(uchar('0')));
    result := ustring('') + numpad + uchar('-') + c;
    exit;
  end;

  if (keyCode and $01000000) <> 0 then begin
    result := ustring('') + uchar(keyCode xor $01000000);
    exit;
  end;

  unknown := Toolkit.getProperty('AWT.unknown', 'Unknown');
  result := unknown + ustring(' keyCode: $') + ustring(lowerCase(intToHex(keyCode, 8)));
end;

class function KeyEvent.getKeyModifiersText(modifiers : int) : ustring;
var
  strm : TStringStream;
begin
  result := '';
  strm := TStringStream.create('');
  try
    if (modifiers and npl_awt_event_InputEvent.META_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.meta', 'Meta'), '+'));
    if (modifiers and npl_awt_event_InputEvent.CTRL_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.control', 'Ctrl'), '+'));
    if (modifiers and npl_awt_event_InputEvent.ALT_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.alt', 'Alt'), '+'));
    if (modifiers and npl_awt_event_InputEvent.SHIFT_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.shift', 'Shift'), '+'));
    if (modifiers and npl_awt_event_InputEvent.ALT_GRAPH_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.altGraph', 'Alt Graph'), '+'));
    if (modifiers and npl_awt_event_InputEvent.BUTTON1_MASK) <> 0 then
      strm.writeString(concat(Toolkit.getProperty('AWT.button1', 'Button1'), '+'));
    if strm.position>0 then
      result := copy(strm.dataString, 1, strm.position-1);
  finally
    strm.free;
  end;
end;

function KeyEvent.isActionKey : boolean;
begin
  case fKeyCode of
    VK_HOME,
    VK_END,
    VK_PAGE_UP,
    VK_PAGE_DOWN,
    VK_UP,
    VK_DOWN,
    VK_LEFT,
    VK_RIGHT,
    VK_BEGIN,

    VK_KP_LEFT,
    VK_KP_UP,
    VK_KP_RIGHT,
    VK_KP_DOWN,

    VK_F1,
    VK_F2,
    VK_F3,
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12,
    VK_F13,
    VK_F14,
    VK_F15,
    VK_F16,
    VK_F17,
    VK_F18,
    VK_F19,
    VK_F20,
    VK_F21,
    VK_F22,
    VK_F23,
    VK_F24,
    VK_PRINTSCREEN,
    VK_SCROLL_LOCK,
    VK_CAPS_LOCK,
    VK_NUM_LOCK,
    VK_PAUSE,
    VK_INSERT,

    VK_FINAL,
    VK_CONVERT,
    VK_NONCONVERT,
    VK_ACCEPT,
    VK_MODECHANGE,
    VK_KANA,
    VK_KANJI,
    VK_ALPHANUMERIC,
    VK_KATAKANA,
    VK_HIRAGANA,
    VK_FULL_WIDTH,
    VK_HALF_WIDTH,
    VK_ROMAN_CHARACTERS,
    VK_ALL_CANDIDATES,
    VK_PREVIOUS_CANDIDATE,
    VK_CODE_INPUT,
    VK_JAPANESE_KATAKANA,
    VK_JAPANESE_HIRAGANA,
    VK_JAPANESE_ROMAN,
    VK_KANA_LOCK,
    VK_INPUT_METHOD_ON_OFF,

    VK_AGAIN,
    VK_UNDO,
    VK_COPY,
    VK_PASTE,
    VK_CUT,
    VK_FIND,
    VK_PROPS,
    VK_STOP,

    VK_HELP,
    VK_WINDOWS,
    VK_CONTEXT_MENU: result := true;
    else result := false;
  end;
end;

end.
