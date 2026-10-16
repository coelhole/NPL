unit npl_Float;

interface

uses
  npl;

const
  POSITIVE_INFINITY : float = 1.0/0.0;
  NEGATIVE_INFINITY : float = -1.0/0.0;
  NaN               : float = 0.0/0.0;
  MAX_VALUE         : float = 3.4028235e+38;
  MIN_NORMAL        : float = 1.17549435E-38;
  MIN_VALUE         : float = 1.4e-45;
  MAX_EXPONENT      : int   = 127;
  MIN_EXPONENT      : int   = -126;
  SIZE              : int   = 32; 

implementation

end.
