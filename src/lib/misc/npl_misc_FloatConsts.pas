unit npl_misc_FloatConsts;

interface

uses
  npl
  ,npl_Float
  ;

const
  POSITIVE_INFINITY : float = 1.0/0.0;
  NEGATIVE_INFINITY : float = -1.0/0.0;
  NaN               : float = 0.0/0.0;
  MAX_VALUE         : float = 3.4028235e+38;
  MIN_VALUE         : float = 1.4e-45;
  MIN_NORMAL        : float = 1.17549435E-38;
  SIGNIFICAND_WIDTH : int   = 24;
  MAX_EXPONENT      : int   = 127;
  MIN_EXPONENT      : int   = -126;
  MIN_SUB_EXPONENT  : int   = -126 - (24 - 1);
  EXP_BIAS          : int   = 127;
  SIGN_BIT_MASK     : int   = $80000000;
  EXP_BIT_MASK      : int   = $7F800000;
  SIGNIF_BIT_MASK   : int   = $007FFFFF;

implementation

initialization
  assert(((SIGN_BIT_MASK or EXP_BIT_MASK or SIGNIF_BIT_MASK) = (not 0)) and
    (((SIGN_BIT_MASK and EXP_BIT_MASK) = 0) and
    ((SIGN_BIT_MASK and SIGNIF_BIT_MASK) = 0) and
    ((EXP_BIT_MASK and SIGNIF_BIT_MASK) = 0)));
end.
