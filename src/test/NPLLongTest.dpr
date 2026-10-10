program NPLLongTest;

{$APPTYPE Console}

uses
  sysUtils,
  npl in '..\lib\npl.pas',
  npl_Long in '..\lib\npl_Long.pas';

begin
writeln('NPLLong.decode(''12345'') = ',NPLLong.decode('12345'));
writeln('NPLLong.decode(''123'') = ',NPLLong.decode('123'));
Assert(NPLLong.parseLong('9223372036854775807') =
       9223372036854775807);
//Assert(NPLLong.parseLong('-9223372036854775808') =
//       -9223372036854775808);
Assert(NPLLong.rotateLeft(1, 64) = 1);
Assert(NPLLong.rotateRight(1, 64) = 1);
Assert(NPLLong.rotateLeft(1, 128) = 1);
Assert(NPLLong.rotateRight(1, 128) = 1);
Assert(NPLLong.rotateRight(1, 65) = NPLLong.rotateRight(1, 1));
Assert(NPLLong.rotateLeft($4000000000000000, 1) = $8000000000000000);
Assert(NPLLong.rotateLeft($8000000000000000, 1) = 1);
Assert(NPLLong.rotateRight(1, 1) = $8000000000000000);
Assert(NPLLong.rotateRight($8000000000000000, 1) =
       $4000000000000000);

  readln;
end.
