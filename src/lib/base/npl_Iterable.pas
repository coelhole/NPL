unit npl_Iterable;

interface

uses
  npl
  ,npl_util_Iterator
  ;

const
  ITERABLEGSTR = '{41911D2A-69A7-426B-9D52-3B7A5FEDADBE}';

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Iterable<T>{$ELSE}Iterable{$ENDIF}=interface(INPLObject)
    [ITERABLEGSTR]
    function iterator : {$IFDEF GENERICS}Iterator<T>{$ELSE}Iterator{$ENDIF};
  end;

  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF}
  ArrOfIterable<T> = array of {$IFDEF FPC_OBJFPC}specialize{$ENDIF} Iterable<T>;
  {$ELSE}
  ArrOfIterable = array of Iterable;
  {$ENDIF}

function implementsIterable(cls : TClass) : boolean; overload;
function implementsIterable(obj : NPLObject) : boolean; overload;

implementation

uses
  sysUtils;

function implementsIterable(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(stringToGUID(ITERABLEGSTR)) <> nil);
end;

function implementsIterable(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(stringToGUID(ITERABLEGSTR)) <> nil);
end;

end.
