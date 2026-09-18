unit npl_awt_peer;

interface

uses
  npl
  ,graphics
  ,npl_awt_graphics
  ,npl_awt_geom
  ,windows
  ;

const
  SET_LOCATION = 1;
  SET_SIZE = 2;
  SET_BOUNDS = 3;
  SET_CLIENT_SIZE = 4;
  RESET_OPERATION = 5;
  NO_EMBEDDED_CHECK = 1 shl 14;
  DEFAULT_OPERATION = SET_BOUNDS;

type
  AWTComponentPeer = class(NPLObject)
    procedure setVisible(v : boolean); virtual; abstract;
    procedure setEnabled(e : boolean); virtual; abstract;
    procedure paint(g : AWTGraphics); virtual; abstract;
    procedure print(g : AWTGraphics); virtual; abstract;
    procedure setBounds(x, y, width, height, op : int); virtual; abstract;
    procedure handleEvent(var awtmsg); virtual; abstract;
    function getLocationOnScreen : AWTPoint; virtual; abstract;
    function getPreferredSize : AWTDimension; virtual; abstract;
    function getMinimumSize : AWTDimension; virtual; abstract;
    procedure setForeground(c : TColor); virtual; abstract;
    procedure setBackground(c : TColor); virtual; abstract;
    procedure setFont(f : AWTFont); virtual; abstract;
    procedure updateCursorImmediately(); virtual; abstract;
    function isFocusable : boolean; virtual; abstract;
    function createImage(width, height : int) : AWTImage; virtual; abstract;
    function handlesWheelScrolling : boolean; virtual; abstract;
    procedure layout; virtual; abstract;
  end;

implementation

end.
