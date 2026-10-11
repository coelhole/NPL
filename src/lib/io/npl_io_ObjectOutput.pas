unit npl_io_ObjectOutput;

interface

uses
  npl
  ,npl_io_DataOutput
  ;

type
  ObjectOutput = interface(DataOutput)
    procedure writeObject(obj : NPLObject);
    procedure flush;
    procedure close;
  end;

implementation

end.
