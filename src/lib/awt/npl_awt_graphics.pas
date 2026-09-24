unit npl_awt_graphics;

interface

uses
  npl
  ,Graphics
  ,Windows
  ,SysUtils
  ;

type
  AWTColor = TColor;

  AWTFont = TFont;

  AWTImage = TBitmap;

  AWTGraphics=interface
  ['{D8237552-9268-40DE-BAA1-6A1A8861EE27}']
    function getBrushColor:AWTColor;
    function getBrushStyle:TBrushStyle;
    function getPenColor:AWTColor;
    function getPenMode:TPenMode;
    function getPenStyle:TPenStyle;
    function getPenWidth:int;
    function getFontColor:AWTColor;
    function getFontPixelsPerInch:int;
    function getFontCharset:TFontCharset;
    function getFontHeight:int;
    function getFontName:TFontName;
    function getFontPitch:TFontPitch;
    function getFontSize:int;
    function getFontStyle:TFontStyles;
    function getTextBgColor:AWTColor;
    function getTextColor:AWTColor;
    procedure setBrushColor(color:AWTColor);
    procedure setBrushStyle(value:TBrushStyle);
    procedure setPenColor(color:AWTColor);
    procedure setPenMode(value:TPenMode);
    procedure setPenStyle(value:TPenStyle);
    procedure setPenWidth(value:int);
    procedure setFontColor(color:AWTColor);
    procedure setFontPixelsPerInch(value:int);
    procedure setFontCharset(value:TFontCharset);
    procedure setFontHeight(value:int);
    procedure setFontName(const value:TFontName);
    procedure setFontPitch(value:TFontPitch);
    procedure setFontSize(value:int);
    procedure setFontStyle(value:TFontStyles);
    procedure setTextBgColor(color:AWTColor);
    procedure setTextColor(color:AWTColor);
    procedure drawLine(x1, y1, x2, y2 : int);
    procedure drawRect(x, y, width, height : int);
    procedure drawString(str : string; x, y : int);
    procedure fillRect(x, y, width, height : int);
  end;

  GraphicContext=class(NPLObject,AWTGraphics)
  private
    fHWnd : HWND;
    fDC : HDC;
    fOldFont : HFONT;
    fFont : TFont;
    fOldPen : HPEN;
    fPen:TPen;
    fOldBrush : HBRUSH;
    fBrush : TBrush;
    fOldTextColor,fOldBgTextColor : COLORREF;
    constructor New;
  public
    constructor Create;
    destructor Destroy; override;
    function getBrushColor:AWTColor;
    function getBrushStyle:TBrushStyle;
    function getPenColor:AWTColor;
    function getPenMode:TPenMode;
    function getPenStyle:TPenStyle;
    function getPenWidth:int;
    function getFontColor:AWTColor;
    function getFontPixelsPerInch:int;
    function getFontCharset:TFontCharset;
    function getFontHeight:int;
    function getFontName:TFontName;
    function getFontPitch:TFontPitch;
    function getFontSize:int;
    function getFontStyle:TFontStyles;
    function getTextBgColor:AWTColor;
    function getTextColor:AWTColor;
    procedure setBrushColor(color:AWTColor);
    procedure setBrushStyle(value:TBrushStyle);
    procedure setPenColor(color:AWTColor);
    procedure setPenMode(value:TPenMode);
    procedure setPenStyle(value:TPenStyle);
    procedure setPenWidth(value:int);
    procedure setFontColor(color:AWTColor);
    procedure setFontPixelsPerInch(value:int);
    procedure setFontCharset(value:TFontCharset);
    procedure setFontHeight(value:int);
    procedure setFontName(const Value:TFontName);
    procedure setFontPitch(value:TFontPitch);
    procedure setFontSize(value:int);
    procedure setFontStyle(value:TFontStyles);
    procedure setTextBgColor(color:AWTColor);
    procedure setTextColor(color:AWTColor);
    procedure drawLine(x1, y1, x2, y2 : int);
    procedure drawRect(x, y, width, height : int);
    procedure drawString(str : string; x, y : int);
    procedure fillRect(x, y, width, height : int);
  end;

implementation

constructor GraphicContext.New;
begin
  inherited Create;
  fDC := 0;
  fOldPen := 0;
  fPen := TPen.Create;
  fPen.Style := psSolid;
  fPen.Width := 1;
  fOldBrush := 0;
  fBrush := TBrush.Create;
  fBrush.Style := bsSolid;
  fOldFont := 0;
  fFont := TFont.Create;
  fHWnd := 0;
end;

constructor GraphicContext.Create;
begin
  raise UnsupportedOperationException.Create(Format('um objeto %s não pode ser instanciado senão por um procedimento de pintura',[self.ClassName]));
end;

destructor GraphicContext.Destroy;
begin
  SelectObject(fDC,fOldPen);
  fPen.Free;
  SelectObject(fDC,fOldBrush);
  fBrush.Free;
  Windows.SetTextColor(fDC,fOldTextColor);
  Windows.SetBkColor(fDC,fOldBgTextColor);
  SelectObject(fDC,fOldFont);
  fFont.Free;
  if fHWnd<>0 then
    ReleaseDC(fHwnd,fDC);
  fDC := 0;
  fOldPen := 0;
  fOldBrush := 0;
  fOldFont := 0;
  fHWnd := 0;
  inherited Destroy;
end;

function GraphicContext.getBrushColor:TColor;
begin
  result := fBrush.Color;
end;

function GraphicContext.getBrushStyle: TBrushStyle;
begin
  result := fBrush.Style;
end;

function GraphicContext.getPenColor:TColor;
begin
  result := fPen.Color;
end;

function GraphicContext.getPenMode:TPenMode;
begin
  result := fPen.Mode;
end;

function GraphicContext.getPenStyle: TPenStyle;
begin
  result := fPen.Style;
end;

function GraphicContext.getPenWidth:int;
begin
  result := fPen.Width;
end;

function GraphicContext.getFontColor:TColor;
begin
  result := fFont.Color;
end;

function GraphicContext.getFontPixelsPerInch:int;
begin
  result := fFont.PixelsPerInch;
end;

function GraphicContext.getFontCharset:TFontCharset;
begin
  result := fFont.Charset;
end;

function GraphicContext.getFontHeight:int;
begin
  result := fFont.Height;
end;

function GraphicContext.getFontName:TFontName;
begin
  result := fFont.Name;
end;

function GraphicContext.getFontPitch:TFontPitch;
begin
  result := fFont.Pitch;
end;

function GraphicContext.getFontSize:int;
begin
  result := fFont.Size;
end;

function GraphicContext.getFontStyle:TFontStyles;
begin
  result := fFont.Style;
end;

function GraphicContext.getTextBgColor:AWTColor;
var
  clr: COLORREF;
begin
  clr := Windows.GetBkColor(fDC);
  if clr = CLR_INVALID then
    raise NPLException.Create('Failed to get background color.');
  result := AWTColor(clr);
end;


function GraphicContext.getTextColor:AWTColor;

var
  clr: COLORREF;
begin
  clr := Windows.GetTextColor(fDC);
  if clr = CLR_INVALID then
    raise NPLException.Create('Failed to get text color.');
  result := AWTColor(clr);
end;

procedure GraphicContext.setBrushColor(color:AWTColor);
begin
  if fBrush.Color <> color then begin
    fBrush.Color := color;
    SelectObject(fDC,fBrush.Handle);
  end;
end;

procedure GraphicContext.setBrushStyle(value:TBrushStyle);
begin
  if fBrush.Style <> value then begin
    fBrush.Style := value;
    SelectObject(fDC,fBrush.Handle);
  end;
end;

procedure GraphicContext.setPenColor(color:TColor);
begin
  if fPen.Color <> color then begin
    fPen.Color := color;
    SelectObject(fDC,fPen.Handle);
  end;
end;

procedure GraphicContext.setPenMode(value:TPenMode);
begin
  if fPen.Mode <> value then begin
    fPen.Mode := value;
    SelectObject(fDC,fPen.Handle);
  end;
end;

procedure GraphicContext.setPenStyle(value:TPenStyle);
begin
  if fPen.Style <> value then begin
    fPen.Style := value;
    SelectObject(fDC,fPen.Handle);
  end;
end;

procedure GraphicContext.setPenWidth(value:int);
begin
  if fPen.Width <> value then begin
    fPen.Width := value;
    SelectObject(fDC,fPen.Handle);
  end;
end;

procedure GraphicContext.setFontColor(color:TColor);
begin
  if fFont.Color <> color then begin
    fFont.Color := color;
    Windows.SetTextColor(fDC,color);
  end;
end;

procedure GraphicContext.setFontPixelsPerInch(value:int);
begin
  if fFont.PixelsPerInch <> value then begin
    fFont.PixelsPerInch := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setFontCharset(value:TFontCharset);
begin
  if fFont.Charset <> value then begin
    fFont.Charset := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setFontHeight(value:int);
begin
  if fFont.Height <> value then begin
    fFont.Height := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setFontName(const value:TFontName);
begin
  if fFont.Name <> value then begin
    fFont.Name := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setFontPitch(value:TFontPitch);
begin
  if fFont.Pitch <> value then begin
    fFont.Pitch := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setFontSize(value:int);
begin
  if fFont.Size <> value then begin
    fFont.Size := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setFontStyle(value:TFontStyles);
begin
  if fFont.Style <> value then begin
    fFont.Style := value;
    SelectObject(fDC,fFont.Handle);
  end;
end;

procedure GraphicContext.setTextBgColor(color:TColor);
begin
  Windows.SetBkColor(fDC,ColorToRGB(color));
end;

procedure GraphicContext.setTextColor(color:TColor);
begin
  Windows.SetTextColor(fDC,ColorToRGB(color));
end;

procedure GraphicContext.drawLine(x1, y1, x2, y2 : int);
begin
  MoveToEx(fDC, x1, y1, NIL);
  LineTo(fDC, x2, y2);
end;

procedure GraphicContext.drawRect(x, y, width, height : int);
begin
  if (width < 0) or (height < 0) then
    Exit;
  if (height = 0) or (width = 0) then
    drawLine(x, y, x + width, y + height)
  else begin
    drawLine(x, y, x + width - 1, y);
    drawLine(x + width, y, x + width, y + height - 1);
    drawLine(x + width, y + height, x + 1, y + height);
    drawLine(x, y + height, x, y + 1);
  end;
end;

procedure GraphicContext.drawString(str : string; x, y : int);
begin
  TextOut(fDC, x, y, PChar(str), Length(str));
end;

procedure GraphicContext.fillRect(x, y, width, height : int);
var
  r:TRect;
begin
  r.left := x;
  r.top := y;
  r.right := x + width;
  r.bottom := y + height;
  Windows.FillRect(fDC,r,fBrush.Handle);
end;

end.
