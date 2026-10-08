(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/util/Comparator.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/util/Comparator.html
*)
unit npl_util_Comparator;

interface

uses
  npl
  ;

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Comparator<T>{$ELSE}Comparator{$ENDIF}=interface
    ['{74800574-DC0D-42B5-98C0-C8EC477DBA1D}']
    function compare(o1, o2 : {$IFDEF GENERICS}T{$ELSE}NPLObject{$ENDIF}) : int;
    function equals(obj : TObject) : boolean;
  end;

implementation

end.
