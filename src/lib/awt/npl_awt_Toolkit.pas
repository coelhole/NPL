(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/awt/Toolkit.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/awt/Toolkit.html
*)
unit npl_awt_Toolkit;

interface

uses
  npl
  ;

type
  Toolkit = class(NPLObject)
  public
    class function getProperty(key : string; defaultValue : string) : string;
  end;

implementation

uses
  classes
  ;

var
  Properties : TStringList;

class function Toolkit.getProperty(key : string; defaultValue : string) : string;
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
  Properties.loadFromFile('../resources/awt_pt_BR.properties');
finalization
  Properties.free;
end.
