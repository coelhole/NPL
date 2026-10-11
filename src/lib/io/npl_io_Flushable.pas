unit npl_io_Flushable;

interface

uses
  npl
  ;

type
  Flushable = interface(IObject)
    ['{7C909324-85A9-478C-B5B8-2C3DA06AFD20}']
    procedure flush;
  end;

implementation

end.
