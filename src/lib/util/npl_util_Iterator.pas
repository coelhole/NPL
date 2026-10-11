unit npl_util_Iterator;

interface

uses
  npl
  ;

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Iterator<E>{$ELSE}Iterator{$ENDIF}=interface(NPLInterface)
    ['{7405C282-E0BF-4FB2-86D2-4D6C68267F87}']
    function hasNext : boolean;
    function next : {$IFDEF GENERICS}E{$ELSE}NPLObject{$ENDIF};
    procedure remove;
  end;

implementation

end.
