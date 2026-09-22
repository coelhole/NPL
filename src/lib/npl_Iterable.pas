(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/lang/Iterable.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/lang/Iterable.html
*)
unit npl_Iterable;

interface

uses
  npl_util_Iterator;

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Iterable<T>{$ELSE}Iterable{$ENDIF}=interface
    ['{41911D2A-69A7-426B-9D52-3B7A5FEDADBE}']
    function iterator : {$IFDEF GENERICS}Iterator<T>{$ELSE}Iterator{$ENDIF};
  end;

implementation

end.
