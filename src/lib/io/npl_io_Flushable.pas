(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/io/Flushable.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/io/Flushable.html
*)
unit npl_io_Flushable;

interface

uses
  npl
  ;

type
  Flushable = interface
    ['{7C909324-85A9-478C-B5B8-2C3DA06AFD20}']
    procedure flush;
  end;

implementation

end.
