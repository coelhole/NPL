unit npl_Iterable;

interface

uses
  npl
  ,npl_util_Iterator
  ;

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Iterable<T>{$ELSE}Iterable{$ENDIF}=interface(IObject)
    ['{41911D2A-69A7-426B-9D52-3B7A5FEDADBE}']
    function iterator : {$IFDEF GENERICS}Iterator<T>{$ELSE}Iterator{$ENDIF};
  end;

implementation

end.
