unit npl_awt_Toolkit;

interface

uses
  npl
  ;

type
  Toolkit = class(NPLObject)
  public
    class function getProperty(const key, defaultValue : string) : string;
  end;

implementation

uses
  classes
  ;

var
  Properties : TStringList;

class function Toolkit.getProperty(const key, defaultValue : string) : string;
begin
  if not assigned(Properties) then begin
    result := defaultValue;
    exit;
  end;

  if Properties.indexOfName(key)>=0 then
    result := Properties.values[key]
  else result := defaultValue;
end;

initialization
  Properties := TStringList.create;
  Properties.duplicates := dupIgnore;
  Properties.loadFromFile('../../resources/awt_pt_BR.properties');
finalization
  Properties.free;
end.
