(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/util/EventObject.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/util/EventObject.html
*)
unit npl_util_EventObject;

interface

uses
  npl
  ;

type
  EventObject = class(NPLObject)
  protected
    fSource : NPLObject;
  public
    constructor create(source : NPLObject); virtual;
    function toString : string; override;
    property source : NPLObject read fSource;
  end;

implementation

uses
  SysUtils
  ;

constructor EventObject.create(source : NPLObject);
begin
  if source=NIL then
    raise IllegalArgumentException.create('null source');
  inherited create;
  fSource := source;
end;

function EventObject.toString : string;
begin
  result := format('%s[source=%s]',[className,source.toString]);
end;

end.
