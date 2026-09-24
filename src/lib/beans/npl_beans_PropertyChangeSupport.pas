(*
  https://raw.githubusercontent.com/openjdk-mirror/jdk7u-jdk/refs/heads/master/src/share/classes/java/beans/PropertyChangeSupport.java @html(<br>)
  https://docs.oracle.com/javase/7/docs/api/java/beans/PropertyChangeSupport.html
*)
unit npl_beans_PropertyChangeSupport;

interface

uses
  classes
  ,npl
  ,npl_beans_PropertyChangeEvent
  ,npl_beans_PropertyChangeListener
  ;

type
  PropertyChangeSupport = class(NPLObject)
  private
    fSource: NPLObject;
    fListeners: TInterfaceList;
    fChildren: TStringList;
  public
    constructor create(sourceBean : NPLObject); virtual;
    destructor destroy; override;
    procedure addPropertyChangeListener(listener : PropertyChangeListener); overload; virtual;
    procedure removePropertyChangeListener(listener : PropertyChangeListener); overload; virtual;
    procedure addPropertyChangeListener(const propertyName: string; listener : PropertyChangeListener); overload; virtual;
    procedure removePropertyChangeListener(const propertyName: string; listener : PropertyChangeListener); overload; virtual;
    procedure firePropertyChange(evt : PropertyChangeEvent); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: NPLObject); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: int); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: sbyte); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: short); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: long); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: string); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: boolean); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: char); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: float); overload; virtual;
    procedure firePropertyChange(const propertyName: string; oldValue, newValue: double); overload; virtual;
    function hasListeners(const propertyName: string): boolean; virtual;
    function getPropertyChangeListeners : PropertyChangeListenerArray; overload; virtual;
    function getPropertyChangeListeners(const propertyName: string) : PropertyChangeListenerArray; overload; virtual;
  end;

implementation

constructor PropertyChangeSupport.Create(sourceBean : NPLObject);
begin
  inherited create;
  fSource := sourceBean;
  fListeners := TInterfaceList.create;
  fChildren := TStringList.create;
  fChildren.sorted := true;
  fChildren.duplicates := dupIgnore;
end;

destructor PropertyChangeSupport.Destroy;
var
  i : int;
begin
  fListeners.free;

  for i := 0 to fChildren.count - 1 do
  begin
    if assigned(fChildren.objects[i]) then
      TInterfaceList(fChildren.objects[i]).free;
  end;

  fChildren.free;

  inherited destroy;
end;

procedure PropertyChangeSupport.addPropertyChangeListener(listener : PropertyChangeListener);
begin
  if assigned(listener) and (fListeners.indexOf(listener) < 0) then
    fListeners.add(listener);
end;

procedure PropertyChangeSupport.removePropertyChangeListener(listener : PropertyChangeListener);
begin
  if assigned(listener) then
    fListeners.remove(listener);
end;

procedure PropertyChangeSupport.addPropertyChangeListener(const propertyName : string; listener : PropertyChangeListener);
var
  idx : int;
  list : TInterfaceList;
begin
  if not assigned(listener) or (propertyName = '') then
    exit;

  idx := fChildren.indexOf(propertyName);
  if idx < 0 then
  begin
    list := TInterfaceList.create;
    fChildren.addObject(propertyName, list);
  end
  else
    list := TInterfaceList(fChildren.objects[idx]);

  if list.indexOf(listener) < 0 then
    list.add(listener);
end;

procedure PropertyChangeSupport.removePropertyChangeListener(const propertyName : string; listener : PropertyChangeListener);
var
  idx : int;
  list : TInterfaceList;
begin
  if assigned(listener) and (propertyName <> '') then
  begin
    idx := fChildren.indexOf(propertyName);
    if idx >= 0 then
    begin
      list := TInterfaceList(fChildren.objects[idx]);
      list.remove(listener);
    end;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(evt : PropertyChangeEvent);
var
  i : int;
  idx : int;
  list : TInterfaceList;
  listener : PropertyChangeListener;
  oldVal, newVal : NPLObject;
begin
  if evt=NIL then
    exit;

  oldVal := evt.oldValue;
  newVal := evt.newValue;

  if (oldVal = NIL) and (newVal = NIL) then
    exit;

  if (oldVal = NIL) or (newVal = NIL) or (not oldVal.equals(newVal)) then begin
    idx := fChildren.indexOf(evt.propertyName);
    if idx >= 0 then
    begin
      list := TInterfaceList(fChildren.objects[idx]);
      if assigned(list) then
      begin
        for i := 0 to list.count - 1 do
        begin
          listener := PropertyChangeListener(list[i]);
          if assigned(listener) then
            listener.propertyChange(evt);
        end;
      end;
    end;

    if assigned(fListeners) then
    begin
      for i := 0 to fListeners.count - 1 do
      begin
        listener := PropertyChangeListener(fListeners[i]);
        if assigned(listener) then
          listener.propertyChange(evt);
      end;
    end;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : NPLObject);
var
  evt : PropertyChangeEvent;
begin
  if (oldValue = NIL) and (newValue = NIL) then
    exit;

  if (oldValue = NIL) or (newValue = NIL) or (not oldValue.equals(newValue)) then begin
    evt := PropertyChangeEvent.create(fSource, propertyName, oldValue, newValue);
    try
      firePropertyChange(evt);
    finally
      evt.free;
    end;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : int);
var
  evt : PropertyChangeEvent;
  oldInt, newInt : NPLInteger;
begin
  if oldValue = newValue then
    exit;

  oldInt := NPLInteger.create(oldValue);
  try
    newInt := NPLInteger.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldInt, newInt);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newInt.free;
    end;
  finally
    oldInt.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : sbyte);
var
  evt : PropertyChangeEvent;
  oldSByte, newSByte : NPLSByte;
begin
  if oldValue = newValue then
    exit;

  oldSByte := NPLSByte.create(oldValue);
  try
    newSByte := NPLSByte.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldSByte, newSByte);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newSByte.free;
    end;
  finally
    oldSByte.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : short);
var
  evt : PropertyChangeEvent;
  oldShort, newShort : NPLShort;
begin
  if oldValue = newValue then
    exit;

  oldShort := NPLShort.create(oldValue);
  try
    newShort := NPLShort.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldShort, newShort);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newShort.free;
    end;
  finally
    oldShort.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : long);
var
  evt : PropertyChangeEvent;
  oldLong, newLong : NPLLong;
begin
  if oldValue = newValue then
    exit;

  oldLong := NPLLong.create(oldValue);
  try
    newLong := NPLLong.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldLong, newLong);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newLong.free;
    end;
  finally
    oldLong.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : string);
var
  evt : PropertyChangeEvent;
  oldStr, newStr : NPLString;
begin
  if oldValue = newValue then
    exit;

  oldStr := NPLString.create(oldValue);
  try
    newStr := NPLString.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldStr, newStr);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newStr.free;
    end;
  finally
    oldStr.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : boolean);
var
  evt : PropertyChangeEvent;
  oldBool, newBool : NPLBoolean;
begin
  if oldValue = newValue then
    exit;

  oldBool := NPLBoolean.create(oldValue);
  try
    newBool := NPLBoolean.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldBool, newBool);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newBool.free;
    end;
  finally
    oldBool.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : char);
var
  evt : PropertyChangeEvent;
  oldChar, newChar : NPLCharacter;
begin
  if oldValue = newValue then
    exit;

  oldChar := NPLCharacter.create(oldValue);
  try
    newChar := NPLCharacter.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldChar, newChar);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newChar.free;
    end;
  finally
    oldChar.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : float);
var
  evt : PropertyChangeEvent;
  oldFloat, newFloat : NPLFloat;
begin
  if oldValue = newValue then
    exit;

  oldFloat := NPLFloat.create(oldValue);
  try
    newFloat := NPLFloat.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldFloat, newFloat);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newFloat.free;
    end;
  finally
    oldFloat.free;
  end;
end;

procedure PropertyChangeSupport.firePropertyChange(const propertyName : string; oldValue, newValue : double);
var
  evt : PropertyChangeEvent;
  oldDouble, newDouble : NPLDouble;
begin
  if oldValue = newValue then
    exit;

  oldDouble := NPLDouble.create(oldValue);
  try
    newDouble := NPLDouble.create(newValue);
    try
      evt := PropertyChangeEvent.create(fSource, propertyName, oldDouble, newDouble);
      try
        firePropertyChange(evt);
      finally
        evt.free;
      end;
    finally
      newDouble.free;
    end;
  finally
    oldDouble.free;
  end;
end;

function PropertyChangeSupport.hasListeners(const propertyName : string): boolean;
var
  idx : int;
  list : TInterfaceList;
begin
  result := (fListeners.count > 0);
  if not result and (propertyName <> '') then
  begin
    idx := fChildren.indexOf(propertyName);
    if idx >= 0 then
    begin
      list := TInterfaceList(fChildren.objects[idx]);
      result := assigned(list) and (list.count > 0);
    end;
  end;
end;

function PropertyChangeSupport.getPropertyChangeListeners : PropertyChangeListenerArray;
var
  i, j, totalCount, index : int;
  list : TInterfaceList;
begin
  totalCount := fListeners.count;
  for i := 0 to fChildren.count - 1 do
  begin
    list := TInterfaceList(fChildren.objects[i]);
    if assigned(list) then
      totalCount := totalCount + list.count;
  end;

  if totalCount = 0 then
  begin
    result := nil;
    exit;
  end;

  setLength(result, totalCount);
  index := 0;

  for i := 0 to fListeners.count - 1 do
  begin
    result[index] := PropertyChangeListener(fListeners[i]);
    inc(index);
  end;

  for i := 0 to fChildren.Count - 1 do
  begin
    list := TInterfaceList(fChildren.objects[i]);
    if assigned(list) then
    begin
      for j := 0 to list.count - 1 do
      begin
        result[index] := PropertyChangeListener(list[j]);
        inc(index);
      end;
    end;
  end;
end;

function PropertyChangeSupport.getPropertyChangeListeners(const propertyName : string) : PropertyChangeListenerArray;
var
  i, idx : int;
  list : TInterfaceList;
begin
  if propertyName = '' then
  begin
    result := nil;
    exit;
  end;

  idx := fChildren.indexOf(propertyName);
  if idx < 0 then
  begin
    result := nil;
    exit;
  end;

  list := TInterfaceList(fChildren.objects[idx]);
  if not assigned(list) or (list.count = 0) then
  begin
    result := nil;
    exit;
  end;

  setLength(result, list.count);
  for i := 0 to list.count - 1 do
    result[i] := PropertyChangeListener(list[i]);
end;

end.
