unit npl_windows;

interface

uses
  Windows;

type
{$IFDEF WIN64}
  LONG_PTR = Int64;
{$ELSE}
  LONG_PTR = Longint;
{$ENDIF}

const
  GWL_USERDATA  = (-21);
  GWLP_USERDATA = GWL_USERDATA;

  WM_NCMOUSEHOVER     = $02A0;
  WM_NCPOINTERUPDATE  = $0241;
  WM_NCPOINTERDOWN    = $0242;
  WM_NCPOINTERUP      = $0243;

{$IFDEF WIN64}
  function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: LONG_PTR): LONG_PTR;
    stdcall; external 'user32.dll' name 'SetWindowLongPtrW';

  function GetWindowLong(hWnd: HWND; nIndex: Integer): LONG_PTR;
    stdcall; external 'user32.dll' name 'GetWindowLongPtrW';
{$ELSE}
  {$IFDEF WIN9X}
  function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; stdcall;
  function GetWindowLong(hWnd: HWND; nIndex: Integer): Longint; stdcall;
  {$ELSE}
  function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: LONG_PTR): LONG_PTR;
    stdcall; external 'user32.dll' name 'SetWindowLongW';

  function GetWindowLong(hWnd: HWND; nIndex: Integer): LONG_PTR;
    stdcall; external 'user32.dll' name 'GetWindowLongW';
  {$ENDIF}
{$ENDIF}

implementation

end.
 