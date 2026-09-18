(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/beans/PropertyChangeListener.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/beans/PropertyChangeListener.html
*)
unit npl_beans_PropertyChangeListener;

interface

uses
  npl_util_EventListener
  ,npl_beans_PropertyChangeEvent
  ;

type
  PropertyChangeListener = interface(EventListener)
  ['{3152F1FB-F2F9-450C-8BF8-24E5DD860E92}']
    procedure propertyChange(evt : PropertyChangeEvent);
  end;

  PropertyChangeListenerArray = array of PropertyChangeListener;

implementation

end.
