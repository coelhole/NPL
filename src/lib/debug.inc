{$IFDEF VER140}  { Delphi 6 }
  {$MESSAGE WARN 'Compilador v140 (Delphi 6)'}
{$ENDIF}

{$IFDEF VER150}  { Delphi 7 }
  {$MESSAGE WARN 'Compilador v150 (Delphi 7)'}
{$ENDIF}

{$IFDEF FPC}	{ Free Pascal Compiler }
  {$Message WARN 'Compilador FPC'}
  {$IFDEF CPU64}
    {$IFDEF WINDOWS}
      {$Message WARN 'Plataforma-alvo = WIN64'}
    {$ELSE}
      {$IFDEF LINUX}
        {$Message WARN 'Plataforma-alvo = LINUX64'}
      {$ELSE}
        {$Message WARN 'Plataforma-alvo = UNIX64'}
      {$ENDIF}
    {$ENDIF}
  {$ELSE}
    {$IFDEF WINDOWS}
      {$Message WARN 'Plataforma-alvo = WIN32'}
    {$ELSE}
      {$IFDEF LINUX}
        {$Message WARN 'Plataforma-alvo = LINUX32'}
      {$ELSE}
        {$Message WARN 'Plataforma-alvo = UNIX32'}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
