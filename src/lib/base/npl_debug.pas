unit npl_debug;

interface

uses
  sysUtils
  ,npl_utils
  ;

procedure debug(smessage : string = 'debug'); overload;
procedure debug(smessage : string; const args: array of const); overload;
procedure debug(aSelf : pointer; const procname : string); overload;

implementation

uses
  npl;

procedure debug(smessage : string = 'debug');
begin
  writeln(format('%s %s',[CURRENT_TIMESTAMP,smessage]));
end;

procedure debug(smessage : string; const args: array of const);
begin
  writeln(CURRENT_TIMESTAMP + ' ' + format(smessage,args));
end;

procedure debug(aSelf : pointer; const procname : string);
begin
  writeln(CURRENT_TIMESTAMP + ' ' + format('SELF:%p @SELF:%p SELF.HASHCODE:%d CLASS:%s PARENTCLASS:%s PROC:%s',[
    pointer(aSelf),
    @aSelf,
    NPLObject(aSelf).hashcode,
    NPLObject(aSelf).classname,
    NPLObject(aSelf).classparent.classname,
    procname
  ]));
end;

end.
