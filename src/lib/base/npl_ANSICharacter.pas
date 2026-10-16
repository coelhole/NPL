unit npl_ANSICharacter;

interface

uses
  npl
  ;

const
  MIN_RADIX : int = 2;
  MAX_RADIX : int = 36;

  UpperANSILetterCodePoints : ANSICodePoints =
    [Low(UpperASCIILetterCodePoint)..High(UpperASCIILetterCodePoint)] +
    [138,140,142,159,192..214,216..222]  //extended ASCII
  ;
  LowerANSILetterCodePoints : ANSICodePoints =
    [Low(LowerASCIILetterCodePoint)..High(LowerASCIILetterCodePoint)] +
    [131,154,156,158,170,181,186,223..246,248..255]  //extended ASCII
  ;
  ANSILetterCodePoints : ANSICodePoints =
    [Low(UpperASCIILetterCodePoint)..High(UpperASCIILetterCodePoint)] +
    [Low(LowerASCIILetterCodePoint)..High(LowerASCIILetterCodePoint)] +
    [131,138,140,142,154,156,158,159,170,181,186,192..214,216..246,248..255]  //extended ASCII
  ;
  ANSIDigitCodePoints : ANSICodePoints  = [Low(ANSIDigitCodePoint)..High(ANSIDigitCodePoint)];
  ANSIDigits          : set of ansichar = [Low(ANSIDigit)..High(ANSIDigit)];
  ASCIILetters        : set of ansichar = [Low(UpperASCIILetter)..High(UpperASCIILetter)] + [Low(LowerASCIILetter)..High(LowerASCIILetter)];

implementation

end.
