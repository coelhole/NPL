unit npl_Long;

interface

uses
  npl;

const
  MIN_VALUE : long  = long($8000000000000000);
  MAX_VALUE : long  = long($7fffffffffffffff);
  SIZE      : int   = 64;

  procedure getChars(i : long; index : int; var buf : chararr);
  function stringSize(x : long) : int;

implementation

uses
  npl_Integer;

procedure getChars(i : long; index : int; var buf : chararr);
var
  q : long;
  r, charPos, i2, q2 : int;
  sign : char;
begin
  charPos := index;
  sign := #0;

  if i < 0 then begin
    sign := '-';
    i := -i;
  end;

  while (i > npl_Integer.MAX_VALUE) do begin
    q := i div 100;
    r := int(i - ((q shl 6) + (q shl 5) + (q shl 2)));
    i := q;
    dec(charPos);
    buf[charPos] := npl_Integer.DigitOnes[r];
    dec(charPos);
    buf[charPos] := npl_Integer.DigitTens[r];
  end;

  i2 := int(i);
  while (i2 >= 65536) do begin
    q2 := i2 div 100;
    r := i2 - ((q2 shl 6) + (q2 shl 5) + (q2 shl 2));
    i2 := q2;
    dec(charPos);
    buf[charPos] := npl_Integer.DigitOnes[r];
    dec(charPos);
    buf[charPos] := npl_Integer.DigitTens[r];
  end;

  while true do begin
    q2 := (i2 * 52429) shr 19;
    r := i2 - ((q2 shl 3) + (q2 shl 1));
    dec(charPos);
    buf[charPos] := npl_Integer.digits[r];
    i2 := q2;
    if i2 = 0 then
      break;
  end;
  if sign <> #0 then begin
    dec(charPos);
    buf[charPos] := sign;
  end;
end;

function stringSize(x : long) : int;
var
  p : long;
  i : int;
begin
  p := 10;
  for i:=1 to 18 do begin
    if x < p then begin
      result := i;
      exit;
    end;
    p := 10*p;
  end;
  result := 19;
end;

end.
