unit npl_console;

interface

uses
  Windows
  ;

procedure HideConsole;
procedure ShowConsole;
function ConsoleIsVisible:boolean;
function CONSOLE_HANDLE : HWND;

implementation

uses
  npl_utils;

//function GetConsoleWindow:HWND; stdcall; external kernel32;

var
  consoleHandle : HWND = 0;
  consoleVisible : boolean = FALSE;

function CONSOLE_HANDLE : HWND;
begin
  result := consoleHandle;
end;

procedure HideConsole;
begin
  if isConsole and consoleVisible then begin
    ShowWindow(consoleHandle,SW_HIDE);
    consoleVisible:=FALSE;
  end;
end;

procedure ShowConsole;
begin
  if isConsole and (not consoleVisible) then begin
    ShowWindow(consoleHandle,SW_NORMAL);
    consoleVisible:=TRUE;
  end;
end;

function ConsoleIsVisible:boolean;
begin
  result:=consoleVisible;
end;

initialization
  consoleVisible:=isConsole;
  if isConsole then begin
    SetConsoleTitle(PAnsiChar(CURRENT_PROCESS_EXE_PATH));
    //consoleHandle := GetConsoleWindow;
  end;
end.
