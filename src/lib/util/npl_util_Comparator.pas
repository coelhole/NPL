unit npl_util_Comparator;

interface

uses
  npl
  ;

const
  COMPARATORGSTR = '{74800574-DC0D-42B5-98C0-C8EC477DBA1D}';

type
  {$IFDEF GENERICS}{$IFDEF FPC_OBJFPC}generic{$ENDIF} Comparator<T>{$ELSE}Comparator{$ENDIF}=interface(IObject)
    [COMPARATORGSTR]
    function compare(o1, o2 : {$IFDEF GENERICS}T{$ELSE}NPLObject{$ENDIF}) : int;
    function equals(obj : NPLObject) : boolean;
  end;

function implementsComparator(cls : TClass) : boolean; overload;
function implementsComparator(obj : NPLObject) : boolean; overload;

implementation

uses
  sysUtils
  ;

function implementsComparator(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(stringToGUID(COMPARATORGSTR)) <> nil);
end;

function implementsComparator(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(stringToGUID(COMPARATORGSTR)) <> nil);
end;

end.
