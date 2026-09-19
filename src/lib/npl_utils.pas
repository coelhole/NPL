unit npl_utils;

interface

function PID:cardinal;
function CURRENT_PROCESS_EXE_PATH: string;
function CURRENT_PROCESS_HANDLE : LongWord;
function CURRENT_TIMESTAMP:ansistring;

implementation

uses
  SysUtils
  ,Windows
  ;

function CURRENT_PROCESS_EXE_PATH: string;
var
  Buffer: array[0..MAX_PATH] of Char;
  ExtendedBuffer: string;
  AllocatedSize: DWORD;
  ResultSize: DWORD;
begin
  Result := '';

  ResultSize := GetModuleFileName(0, Buffer, Length(Buffer));
  
  if ResultSize = 0 then
    {$IFDEF DELPHI6UPORFPC}RaiseLastOSError{$ELSE}RaiseLastWin32Error{$ENDIF};

  if ResultSize >= DWORD(Length(Buffer)) then
  begin
    AllocatedSize := 32768;
    SetLength(ExtendedBuffer, AllocatedSize);
    ResultSize := GetModuleFileName(0, PChar(ExtendedBuffer), AllocatedSize);
    if (ResultSize = 0) or (ResultSize >= AllocatedSize) then
      {$IFDEF DELPHI6UPORFPC}RaiseLastOSError{$ELSE}RaiseLastWin32Error{$ENDIF};
    SetLength(ExtendedBuffer, ResultSize);
    Result := ExtendedBuffer;
  end
  else
  begin
    SetLength(Result, ResultSize);
    Move(Buffer[0], Result[1], ResultSize * SizeOf(Char));
  end;
end;

function CURRENT_PROCESS_HANDLE:LongWord;
begin
  result:=GetCurrentProcess;
end;

function PID:cardinal;
begin
  result:=GetCurrentProcessId;
end;

function CURRENT_TIMESTAMP:ansistring;
begin
  result:=FormatDatetime('yyyymmddhhnnsszzz',now);
end;

end.
 