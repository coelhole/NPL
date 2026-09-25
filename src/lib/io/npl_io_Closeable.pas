(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/io/Closeable.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/io/Closeable.html
*)
unit npl_io_Closeable;

interface

uses
  npl
  ;

type
  Closeable = interface(AutoCloseable)
    ['{BA01AE88-B1E2-4501-8326-CE789D9D6C72}']
    procedure close;
  end;

implementation

end.
