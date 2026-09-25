unit npl_io_ObjectOutput;

interface

uses
  npl
  ,npl_io_DataOutput
  ;

type
  ObjectOutput = interface(DataOutputAutoCloseable)
    procedure writeObject(obj : NObject);
    procedure flush;
  end;

implementation

end.
