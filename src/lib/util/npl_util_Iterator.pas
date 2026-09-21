(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/util/Iterator.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/util/Iterator.html
*)
unit npl_util_Iterator;

interface

uses
  npl
  ;

type
  Iterator=interface
    ['{43D18F32-A48B-45C4-8A36-79BA86804109}']
    function hasNext : boolean;
    function next : NPLObject;
    procedure remove;
  end;

implementation

end.
