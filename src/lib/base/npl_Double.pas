unit npl_Double;

interface

uses
  npl;

const
  POSITIVE_INFINITY : double  = 1.0/0.0;
  NEGATIVE_INFINITY : double  = -1.0/0.0;
  NaN               : double  = 0.0/0.0;
  MAX_VALUE         : double  = 1.7976931348623157e+308;
  MIN_NORMAL        : double  = 2.2250738585072014E-308;
  MIN_VALUE         : double  = 4.9e-324;
  MAX_EXPONENT      : int     = 1023;
  MIN_EXPONENT      : int     = -1022;
  SIZE              : int     = 64;

implementation

end.
