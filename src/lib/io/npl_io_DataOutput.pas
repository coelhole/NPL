unit npl_io_DataOutput;

interface

uses
  npl
  ;

type
  DataOutput = interface
    ['{B8B0FBAC-4D2B-4150-BF54-B6B0B6EC6219}']
      procedure write(b : int); overload;
      procedure write(b : sbytearr); overload;
      procedure write(b : sbytearr; off, len : int); overload;
      procedure writeBoolean(v : boolean);
      procedure writeByte(v : int);
      procedure writeShort(v : int);
      procedure writeChar(v : int);
      procedure writeInt(v : int);
      procedure writeLong(v : long);
      procedure writeFloat(v : float);
      procedure writeDouble(v : double);
      procedure writeBytes(s : NString);
      procedure writeChars(s : NString);
      procedure writeUTF(s : NString);
  end;

  DataOutputAutoCloseable = interface(AutoCloseable)
    ['{D11A59A7-48C3-4583-BCEE-4222233601F3}']
      procedure write(b : int); overload;
      procedure write(b : sbytearr); overload;
      procedure write(b : sbytearr; off, len : int); overload;
      procedure writeBoolean(v : boolean);
      procedure writeByte(v : int);
      procedure writeShort(v : int);
      procedure writeChar(v : int);
      procedure writeInt(v : int);
      procedure writeLong(v : long);
      procedure writeFloat(v : float);
      procedure writeDouble(v : double);
      procedure writeBytes(s : NString);
      procedure writeChars(s : NString);
      procedure writeUTF(s : NString);
  end;

implementation

end.
