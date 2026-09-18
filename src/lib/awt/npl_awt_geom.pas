unit npl_awt_geom;

interface

uses
  npl
  ,Windows
  ;

type
  PAWTPoint = ^AWTPoint;
  AWTPoint = packed record
    x, y : int;
  end;

  PAWTDimension = ^AWTDimension;
  AWTDimension = packed record
    width, height : int;
  end;

  PAWTRectangle = ^AWTRectangle;
  AWTRectangle = packed record
    x, y, width, height : int;
  end;

implementation

end.
