program NPLIntegerTest;

{$APPTYPE Console}

uses
  sysUtils
  ,npl in '..\lib\npl.pas'
  ,npl_Integer in '..\lib\npl_Integer.pas'
  ;

begin
writeln(NPLInteger.parseInt('-2147483648'));////////
Assert(NPLInteger.parseInt('0') = 0);
Assert(NPLInteger.parseInt('2147483647') = 2147483647);
Assert(NPLInteger.parseInt('-2147483648') = -2147483647-1);
Assert(NPLInteger.decode('0') = 0);
Assert(NPLInteger.decode('077') = 63);
Assert(NPLInteger.decode('0xFF') = 255);
Assert(NPLInteger.decode('#FF') = 255);
//Assert(NPLInteger.decode('-2147483648') = -2147483648);
Assert(NPLInteger.rotateLeft(1, 0) = 1);
Assert(NPLInteger.rotateLeft(1, 32) = 1);
Assert(NPLInteger.rotateRight(1, 32) = 1);
Assert(NPLInteger.rotateRight(1, 33) = NPLInteger.rotateRight(1, 1));
Assert(NPLInteger.rotateLeft(int($40000000), 1) = int($80000000));
Assert(NPLInteger.rotateRight(1, 1) = int($80000000));
Assert(NPLInteger.rotateLeft($80000000, 1) = 1);
Assert(NPLInteger.rotateRight($80000000, 1) = $40000000);
assert(NPLInteger.rotateLeft(0,-npl_Integer.MIN_VALUE) = 0);

  readln;
end.
