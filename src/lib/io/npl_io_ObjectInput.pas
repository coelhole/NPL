unit npl_io_ObjectInput;

interface

uses
  npl
  ,npl_io_DataInput
  ;

type
  ObjectInput = interface(DataInput)
    ['{74620994-0409-4A49-BCF4-35FD17ECE9B7}']
    function readObject : NPLObject;
    function read : int; overload;
    function read(var b : sbytearr) : int; overload;
    function read(var b : sbytearr; off, len : int) : int; overload;
    function skip(n : long) : long;
    function available : int;
    procedure close;
  end;

implementation

end.
