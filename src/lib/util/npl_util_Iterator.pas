unit npl_util_Iterator;

interface

uses
  npl
  ;

const
  ITERATORGSTR = '{7405C282-E0BF-4FB2-86D2-4D6C68267F87}';

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Iterator<E>{$ELSE}Iterator{$ENDIF}=interface(INPLObject)
    [ITERATORGSTR]
    function hasNext : boolean;
    function next : {$IFDEF GENERICS}E{$ELSE}NPLObject{$ENDIF};
    procedure remove;
  end;

  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF}
  ArrOfIterator<E> = array of {$IFDEF FPC_OBJFPC}specialize{$ENDIF} Iterator<E>;
  {$ELSE}
  ArrOfIterator = array of Iterator;
  {$ENDIF}

function implementsIterator(cls : TClass) : boolean; overload;
function implementsIterator(obj : NPLObject) : boolean; overload;

implementation

function implementsIterator(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(Iterator) <> nil);
end;

function implementsIterator(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(Iterator) <> nil);
end;

end.
