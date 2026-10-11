unit npl_io_DataOutput;

interface

uses
  npl
  ;

type
  DataOutput = interface(NPLInterface)
    ['{B8B0FBAC-4D2B-4150-BF54-B6B0B6EC6219}']
      procedure write(b : int); overload;
      procedure write(var b : sbytearr); overload;
      procedure write(var b : sbytearr; off, len : int); overload;
      procedure writeBoolean(v : boolean);
      procedure writeByte(v : int);
      procedure writeShort(v : int);
      procedure writeChar(v : int);
      procedure writeInt(v : int);
      procedure writeLong(v : long);
      procedure writeFloat(v : float);
      procedure writeDouble(v : double);
      procedure writeBytes(var s : string);
      procedure writeChars(var s : string);
      procedure writeUTF(var s : string);
  end;

implementation

end.
