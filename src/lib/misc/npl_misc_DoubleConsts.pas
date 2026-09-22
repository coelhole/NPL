unit npl_misc_DoubleConsts;

interface

uses
  npl
  ;

const
  POSITIVE_INFINITY : double  = 1.0/0.0;
  NEGATIVE_INFINITY : double  = -1.0/0.0;
  NaN               : double  = 0.0/0.0;
  MAX_VALUE         : double  = 1.7976931348623157e+308;
  MIN_VALUE         : double  = 4.9e-324;
  MIN_NORMAL        : double  = 2.2250738585072014E-308;
  SIGNIFICAND_WIDTH : int     = 53;
  MAX_EXPONENT      : int     = 1023;
  MIN_EXPONENT      : int     = -1022;
  MIN_SUB_EXPONENT  : int     = -1022 - (53 - 1);
  EXP_BIAS          : int     = 1023;
  SIGN_BIT_MASK     : long    = long($8000000000000000);
  EXP_BIT_MASK      : long    = long($7FF0000000000000);
  SIGNIF_BIT_MASK   : long    = long($000FFFFFFFFFFFFF);

implementation

initialization
  assert(((SIGN_BIT_MASK or EXP_BIT_MASK or SIGNIF_BIT_MASK) = not 0) and
    (((SIGN_BIT_MASK and EXP_BIT_MASK) = 0.0) and
    ((SIGN_BIT_MASK and SIGNIF_BIT_MASK) = 0.0) and
    ((EXP_BIT_MASK and SIGNIF_BIT_MASK) = 0.0)));
end.
