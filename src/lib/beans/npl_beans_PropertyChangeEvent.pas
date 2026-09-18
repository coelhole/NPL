(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/beans/PropertyChangeEvent.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/beans/PropertyChangeEvent.html
*)
unit npl_beans_PropertyChangeEvent;

interface

uses
  npl
  ,npl_util_EventObject
  ;

type
  PropertyChangeEvent = class(EventObject)
  private
    fPropertyName : string;
    fOldValue : NPLObject;
    fNewValue : NPLObject;
  public
    constructor create(source: NPLObject; const propertyName : string; oldValue, newValue : NPLObject);
    function toString : string; override;
    property propertyName: string read fPropertyName;
    property oldValue: NPLObject read fOldValue;
    property newValue: NPLObject read fNewValue;
  end;

implementation

uses
  classes;

constructor PropertyChangeEvent.create(source : NPLObject; const propertyName : string; oldValue, newValue : NPLObject);
begin
  inherited create(source);
  fPropertyName := propertyName;
  fOldValue := oldValue;
  fNewValue := newValue;
end;

function PropertyChangeEvent.toString : string;
var
  stream : TStringStream;
begin
  stream := TStringStream.create('');
  try
    stream.writeString(className);
    stream.writeString('[propertyName=');
    stream.writeString(fPropertyName);
    stream.writeString('; oldValue=');
    stream.writeString(fOldValue.toString);
    stream.writeString('; newValue=');
    stream.writeString(fNewValue.toString);
    stream.writeString('; source=');
    stream.writeString(source.toString);
    stream.writeString(']');
    result := stream.dataString;
  finally
    stream.free;
  end;
end;

end.
