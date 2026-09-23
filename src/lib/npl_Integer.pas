unit npl_Integer;

interface

uses
  npl;

const
  MIN_VALUE : int = int($80000000);
  MAX_VALUE : int = int($7fffffff);
  SIZE      : int = 32;

  digits : array[0..35] of char = (
    '0' , '1' , '2' , '3' , '4' , '5' ,
    '6' , '7' , '8' , '9' , 'a' , 'b' ,
    'c' , 'd' , 'e' , 'f' , 'g' , 'h' ,
    'i' , 'j' , 'k' , 'l' , 'm' , 'n' ,
    'o' , 'p' , 'q' , 'r' , 's' , 't' ,
    'u' , 'v' , 'w' , 'x' , 'y' , 'z'
  );

  DigitTens : array[0..99] of char = (
    '0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
    '1', '1', '1', '1', '1', '1', '1', '1', '1', '1',
    '2', '2', '2', '2', '2', '2', '2', '2', '2', '2',
    '3', '3', '3', '3', '3', '3', '3', '3', '3', '3',
    '4', '4', '4', '4', '4', '4', '4', '4', '4', '4',
    '5', '5', '5', '5', '5', '5', '5', '5', '5', '5',
    '6', '6', '6', '6', '6', '6', '6', '6', '6', '6',
    '7', '7', '7', '7', '7', '7', '7', '7', '7', '7',
    '8', '8', '8', '8', '8', '8', '8', '8', '8', '8',
    '9', '9', '9', '9', '9', '9', '9', '9', '9', '9'
  );

  DigitOnes : array[0..99] of char = (
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
  );

  sizeTable : array[0..9] of int = (
    9, 99, 999, 9999, 99999, 999999, 9999999,
    99999999, 999999999, int($7fffffff)
  );

  procedure getChars(i, index : int; var buf : chararr);
  function stringSize(x : int) : int;

implementation

procedure getChars(i, index : int; var buf : chararr);
var
  q, r, charPos : int;
  sign : char;
begin
  charPos := index;
  sign := #0;

  if i < 0 then begin
    sign := '-';
    i := -i;
  end;

  while (i >= 65536) do begin
    q := i div 100;
    r := i - ((q shl 6) + (q shl 5) + (q shl 2));
    i := q;
    dec(charPos);
    buf[charPos] := DigitOnes[r];
    dec(charPos);
    buf[charPos] := DigitTens[r];
  end;

  while true do begin
    q := (i * 52429) shr 19;
    r := i - ((q shl 3) + (q shl 1));
    dec(charPos);
    buf[charPos] := digits[r];
    i := q;
    if i = 0 then
      break;
  end;

  if sign <> #0 then begin
    dec(charPos);
    buf[charPos] := sign;
  end;
end;

function stringSize(x : int) : int;
var
  i : int;
begin
  i := 0;
  while(true) do begin
    if x <= sizeTable[i] then
      break;
    inc(i);
  end;
  result := i + 1;
end;

end.
