unit npl_io_Externalizable;

interface

uses
  npl
  ,npl_io_ObjectInput
  ,npl_io_ObjectOutput
  ;

type
  Externalizable = interface(IObject)
    ['{F9F87EF1-DB53-4C19-ADCD-4B4DF4A210CF}']
    procedure writeExternal(oout : ObjectOutput);
    procedure readExternal(oin : ObjectInput);
  end;

implementation

end.
