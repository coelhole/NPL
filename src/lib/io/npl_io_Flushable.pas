unit npl_io_Flushable;

interface

uses
  npl
  ;

const
  FLUSHABLEGSTR = '{7C909324-85A9-478C-B5B8-2C3DA06AFD20}';

type
  Flushable = interface(IObject)
    [FLUSHABLEGSTR]
    procedure flush;
  end;

function implementsFlushable(cls : TClass) : boolean; overload;
function implementsFlushable(obj : NPLObject) : boolean; overload;

implementation

function implementsFlushable(cls : TClass) : boolean;
begin
  result := false;
  if cls=nil then
    exit;
  result := (cls.getInterfaceEntry(Flushable) <> nil);
end;

function implementsFlushable(obj : NPLObject) : boolean;
begin
  result := false;
  if obj=nil then
    exit;
  result := (obj.classType.getInterfaceEntry(Flushable) <> nil);
end;

end.
