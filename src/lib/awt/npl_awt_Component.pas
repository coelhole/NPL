unit npl_awt_Component;

interface

uses
  Classes
  ,Graphics
  ,Messages
  ,Windows
  ,SyncObjs
  ,npl
  ,npl_awt_peer
  ,npl_awt_graphics
  ,npl_awt_geom
  ,npl_windows
  ,npl_beans_PropertyChangeListener
  ,npl_beans_PropertyChangeSupport
  ;

const
  TOP_ALIGNMENT     : float = 0.0;
  CENTER_ALIGNMENT  : float = 0.5;
  BOTTOM_ALIGNMENT  : float = 1.0;
  LEFT_ALIGNMENT    : float = 0.0;
  RIGHT_ALIGNMENT   : float = 1.0;

type
  ComponentOrientation = (
    LEFT_TO_RIGHT,
    RIGHT_TO_LEFT,
    UNKNOWN
  );

  BaselineResizeBehavior = (
    CONSTANT_ASCENT,
    CONSTANT_DESCENT,
    CENTER_OFFSET,
    OTHER
  );

  AWTCriticalSection = class(TCriticalSection)
  private
    fOwnerThreadID : DWORD;
    fRecursion : int;
  public
    constructor create;
    procedure acquire; override;
    procedure release; override;
    function isHeldByCurrentThread : boolean;
    function isHeldByThread(AThreadID : DWORD) : boolean;
    property ownerThreadID: DWORD read fOwnerThreadID;
    property recursion: int read fRecursion;
  end;

  AWTTreeLock = class(NPLObject)
  private
    fCriticalSection : AWTCriticalSection;
  public
    constructor create;
    destructor destroy; override;
    procedure enter;
    procedure leave;
    function isHeldByCurrentThread : boolean;
    function isHeldByThread(aThreadID : DWORD) : boolean;
  end;

  AWTContainer=class;

  AWTComponent=class(NPLObject)
  private
    fValid : boolean;
    fName : string;
    fNameExplicitlySet : boolean;
    fFocusable : boolean;
    fIsFocusTraversableOverridden : int;
    fFocusTraversalKeysEnabled : boolean;
    fChangeSupport : PropertyChangeSupport;
    fBoundsOp : int;
    fIsAddNotifyComplete : boolean;

    //
    fPeer : AWTComponentPeer;
    fParent : AWTContainer;
    fX, fY, fWidth, fHeight : int;
    fForeground, fBackground : TColor;
    fFont, fPeerFont : AWTFont;
    fIgnoreRepaint, fVisible,
      fEnabled : boolean;
    fMinSize : AWTDimension;
    fMinSizeSet : boolean;
    fPrefSize : AWTDimension;
    fPrefSizeSet : boolean;
    fMaxSize : AWTDimension;
    fMaxSizeSet : boolean;
    fComponentOrientation : ComponentOrientation;
    fNewEventsOnly : boolean;
    fIsPacked : boolean;
    fIsForegroundSet : boolean;
    fIsBackgroundSet : boolean;
  protected
    function getBounds : AWTRectangle; virtual;
    function getSize : AWTDimension; virtual;
    function getLocation : AWTPoint; virtual;
    function getPreferredSize : AWTDimension; virtual;
    procedure setPreferredSize(preferredSize : AWTDimension); virtual;
    function getMinimumSize : AWTDimension; virtual;
    procedure setMinimumSize(minimumSize : AWTDimension); virtual;
    function getMaximumSize : AWTDimension; virtual;
    procedure setMaximumSize(maximumSize : AWTDimension); virtual;
    function getAlignmentX : float; virtual;
    function getAlignmentY : float; virtual;
    function getBoundsOp : int; virtual;
    procedure setBoundsOp(op : int); virtual;
    function constructComponentName : string; virtual;
    function getName : string; virtual;
    procedure setName(name : string); virtual;
    function getParent : AWTContainer; virtual;
    function getContainer : AWTContainer; virtual;
    function isRecursivelyVisible : boolean; virtual;

    procedure firePropertyChange(propertyName : string; oldValue, newValue : NPLObject); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : string); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : boolean); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : int); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : sbyte); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : short); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : long); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : char); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : float); overload; virtual;
    procedure firePropertyChange(propertyName : string; oldValue, newValue : double); overload; virtual;            
  public
    constructor create;virtual;
    destructor destroy;override;
    function getTreeLock : AWTTreeLock;
    function holdsTreeLock : boolean;
    function isDoubleBuffered : boolean; virtual;
    function isFontSet : boolean; virtual;
    function isValid : boolean; virtual;
    function isDisplayable : boolean; virtual;
    function isVisible : boolean; virtual;
    function getBaseline(width, height : int) : int; virtual;
    function getBaselineResizeBehavior : BaselineResizeBehavior; virtual;
    procedure addPropertyChangeListener(listener : PropertyChangeListener); overload; virtual;
    procedure removePropertyChangeListener(listener : PropertyChangeListener); overload; virtual;
    function getPropertyChangeListeners : PropertyChangeListenerArray; overload; virtual;
    procedure addPropertyChangeListener(propertyName : string; listener : PropertyChangeListener); overload; virtual;
    procedure removePropertyChangeListener(propertyName : string; listener : PropertyChangeListener); overload; virtual;
    function getPropertyChangeListeners(propertyName : string) : PropertyChangeListenerArray; overload; virtual;
    procedure doLayout; virtual; abstract;
    property x : int read fX;
    property y : int read fY;
    property width : int read fWidth;
    property height : int read fHeight;
    property bounds : AWTRectangle read getBounds;
    property size : AWTDimension read getSize;
    property location : AWTPoint read getLocation;
    property isPreferredSizeSet : boolean read fPrefSizeSet;
    property prefSize : AWTDimension read getPreferredSize write setPreferredSize;
    property isMinimumSizeSet : boolean read fMinSizeSet;
    property minimumSize : AWTDimension read getMinimumSize write setMinimumSize;
    property isMaximumSizeSet : boolean read fMaxSizeSet;
    property maximumSize : AWTDimension read getMaximumSize write setMaximumSize;
    property alignmentX : float read getAlignmentX;
    property alignmentY : float read getAlignmentY;
    property name : string read getName write setName;
    property parent : AWTContainer read getParent;
  end;

  AWTContainer=class(AWTComponent);

implementation

uses
  SysUtils
  ;

const
  FOCUS_TRAVERSABLE_UNKNOWN = 0;
  FOCUS_TRAVERSABLE_DEFAULT = 1;
  FOCUS_TRAVERSABLE_SET     = 2;

  focusTraversalKeyPropertyNames: array[0..3] of string = (
    'forwardFocusTraversalKeys',
    'backwardFocusTraversalKeys',
    'upCycleFocusTraversalKeys',
    'downCycleFocusTraversalKeys'
  );

constructor AWTCriticalSection.create;
begin
  inherited create;
  fOwnerThreadID := 0;
  fRecursion := 0;
end;

procedure AWTCriticalSection.acquire;
var
  threadID : DWORD;
begin
  threadID := getCurrentThreadID;

  if fOwnerThreadID = threadID then
  begin
    inc(fRecursion);
    exit;
  end;

  inherited acquire;

  fOwnerThreadID := threadID;
  fRecursion := 1;
end;

procedure AWTCriticalSection.release;
var
  threadID : DWORD;
begin
  threadID := getCurrentThreadID;

  if (fOwnerThreadID <> threadID) or
     (fRecursion <= 0) then
    raise NPLException.create(
      'CriticalSection released by thread that does not own it'
    );

  dec(fRecursion);

  if fRecursion = 0 then
  begin
    fOwnerThreadID := 0;
    inherited release;
  end;
end;

function AWTCriticalSection.isHeldByCurrentThread : boolean;
begin
  result :=
    (fOwnerThreadID = getCurrentThreadID) and
    (fRecursion > 0);
end;

function AWTCriticalSection.isHeldByThread(aThreadID : DWORD) : boolean;
begin
  result :=
    (fOwnerThreadID = aThreadID) and
    (fRecursion > 0);
end;

constructor AWTTreeLock.create;
begin
  inherited create;
  fCriticalSection := AWTCriticalSection.create;
end;

destructor AWTTreeLock.destroy;
begin
  fCriticalSection.free;
  inherited destroy;
end;

procedure AWTTreeLock.enter;
begin
  fCriticalSection.acquire;
end;

procedure AWTTreeLock.leave;
begin
  fCriticalSection.release;
end;

function AWTTreeLock.isHeldByCurrentThread : boolean;
begin
  result := fCriticalSection.isHeldByCurrentThread;
end;

function AWTTreeLock.isHeldByThread(aThreadID : DWORD) : boolean;
begin
  result := fCriticalSection.isHeldByThread(aThreadID);
end;

var LOCK : AWTTreeLock;
constructor AWTComponent.create;
begin
  inherited create;
  fIgnoreRepaint := false;
  fVisible := true;
  fEnabled := true;
  fValid := false;
  fNameExplicitlySet := false;
  fFocusable := true;
  fIsFocusTraversableOverridden := npl_awt_component.FOCUS_TRAVERSABLE_UNKNOWN;
  fFocusTraversalKeysEnabled := true;
  fComponentOrientation := UNKNOWN;
  fNewEventsOnly := false;
  fIsPacked := false;
  fBoundsOp := npl_awt_peer.DEFAULT_OPERATION;
  fIsAddNotifyComplete := false;
end;

destructor AWTComponent.destroy;
begin
  if assigned(fChangeSupport) then
    fChangeSupport.free;
  //
  inherited destroy;
end;

function AWTComponent.getTreeLock : AWTTreeLock;
begin
  result := LOCK;
end;

function AWTComponent.holdsTreeLock : boolean;
begin
  result := getTreeLock.isHeldByCurrentThread;
end;

function AWTComponent.isDoubleBuffered : boolean;
begin
  result := false;
end;

function AWTComponent.isFontSet : boolean;
begin
  result := assigned(fFont);
end;

function AWTComponent.getBounds : AWTRectangle;
begin
  result.x := fX;
  result.y := fY;
  result.width := fWidth;
  result.height := fHeight;
end;

function AWTComponent.getSize : AWTDimension;
begin
  result.width := fWidth;
  result.height := fHeight;
end;

function AWTComponent.getLocation : AWTPoint;
begin
  result.x := fX;
  result.y := fY;
end;

function AWTComponent.getPreferredSize : AWTDimension;
begin
  result := fPrefSize;
  if (result.width*result.height = 0) or (not (isPreferredSizeSet or isValid)) then begin
    getTreeLock.enter;
    try
      if assigned(fPeer) then
        fPrefSize := fPeer.getPreferredSize
      else fPrefSize := getMinimumSize;
      result := fPrefSize;
    finally
      getTreeLock.leave;
    end;
  end;
end;

procedure AWTComponent.setPreferredSize(preferredSize : AWTDimension);
var
  old : AWTDimension;
begin
  old.width := 0;
  old.height := 0;
  if fPrefSizeSet then
    old := fPrefSize;
  fPrefSize := preferredSize;
  fPrefSizeSet := (preferredSize.width>0) and (preferredSize.height>0);
  if old.width<>preferredSize.width then
    firePropertyChange('preferredSize.width', old.width, preferredSize.width);
  if old.height<>preferredSize.height then
    firePropertyChange('preferredSize.height', old.height, preferredSize.height);
end;

function AWTComponent.getMinimumSize : AWTDimension;
begin
  result := fMinSize;
  if not (isMinimumSizeSet or isValid) then begin
    getTreeLock.enter;
    try
      if assigned(fPeer) then
        fMinSize := fPeer.getMinimumSize
      else fMinSize := size;
      result := fMinSize;
    finally
      getTreeLock.leave;
    end;
  end;
end;

procedure AWTComponent.setMinimumSize(minimumSize : AWTDimension);
var
  old : AWTDimension;
begin
  old.width := 0;
  old.height := 0;
  if fMinSizeSet then
    old := fMinSize;
  fMinSize := minimumSize;
  fMinSizeSet := (minimumSize.width>0) and (minimumSize.height>0);
  if old.width<>minimumSize.width then
    firePropertyChange('minimumSize.width', old.width, minimumSize.width);
  if old.height<>minimumSize.height then
    firePropertyChange('minimumSize.height', old.height, minimumSize.height);
end;

function AWTComponent.getMaximumSize : AWTDimension;
begin
  if fmaxSizeSet then
    result := fMaxSize
  else begin
    result.width := high(short);
    result.height := high(short);    
  end;
end;

procedure AWTComponent.setMaximumSize(maximumSize : AWTDimension);
var
  old : AWTDimension;
begin
  old.width := 0;
  old.height := 0;
  if fMaxSizeSet then
    old := fMaxSize;
  fMaxSize := maximumSize;
  fMaxSizeSet := (maximumSize.width>0) and (maximumSize.height>0);
  if old.width<>maximumSize.width then
    firePropertyChange('maximumSize.width', old.width, maximumSize.width);
  if old.height<>maximumSize.height then
    firePropertyChange('maximumSize.height', old.height, maximumSize.height);
end;

function AWTComponent.getAlignmentX : float;
begin
  result := npl_awt_component.CENTER_ALIGNMENT;
end;

function AWTComponent.getAlignmentY : float;
begin
  result := npl_awt_component.CENTER_ALIGNMENT;
end;

function AWTComponent.getBoundsOp : int;
begin
  assert(holdsTreeLock);
  result := fBoundsOp;
end;

procedure AWTComponent.setBoundsOp(op : int);
begin
  assert(holdsTreeLock);
  if op = npl_awt_peer.RESET_OPERATION then
    fBoundsOp := npl_awt_peer.DEFAULT_OPERATION
  else if fBoundsOp = npl_awt_peer.DEFAULT_OPERATION then
    fBoundsOp := op;
end;

function AWTComponent.constructComponentName : string;
begin
  result := '';
end;

function AWTComponent.getName: string;
begin
  if (fName = '') and (not fNameExplicitlySet) then
  begin
    getTreeLock.enter;
    try
      if (fName = '') and (not fNameExplicitlySet) then
        fName := constructComponentName;
    finally
      getTreeLock.leave;
    end;
  end;
  result := fName;
end;

procedure AWTComponent.setName(name : string);
var
  oldName : string;
begin
  getTreeLock.enter;
  try
    oldName := fName;
    fName := name;
    fNameExplicitlySet := true;
  finally
    getTreeLock.leave;
  end;
  firePropertyChange('name', oldName, name);
end;

function AWTComponent.getParent : AWTContainer;
begin
  result := fParent;
end;

function AWTComponent.getContainer : AWTContainer;
begin
  result := getParent;
end;

function AWTComponent.isValid : boolean;
begin
  result := assigned(fPeer) and fValid;
end;

function AWTComponent.isDisplayable : boolean;
begin
  result := assigned(fPeer);
end;

function AWTComponent.isVisible : boolean;
begin
  result := fVisible;
end;

function AWTComponent.isRecursivelyVisible : boolean;
begin
  result := fVisible and ((not assigned(fParent)) or fParent.isRecursivelyVisible);
end;

function AWTComponent.getBaseline(width, height : int) : int;
begin
  if (width < 0) or (height < 0) then
    raise IllegalArgumentException.create('Width and height must be >= 0');
  result := -1;
end;

function AWTComponent.getBaselineResizeBehavior : BaselineResizeBehavior;
begin
  result := OTHER;
end;

procedure AWTComponent.addPropertyChangeListener(listener : PropertyChangeListener);
begin
  getTreeLock.enter;
  try
    if listener=NIL then
      Exit;
    if not assigned(fChangeSupport) then
      fChangeSupport := PropertyChangeSupport.create(self);
    fChangeSupport.addPropertyChangeListener(listener);
  finally
    getTreeLock.leave;
  end;
end;

procedure AWTComponent.removePropertyChangeListener(listener : PropertyChangeListener);
begin
  getTreeLock.enter;
  try
    if (listener=NIL) or (not assigned(fChangeSupport)) then
      Exit;
    fChangeSupport.removePropertyChangeListener(listener);
  finally
    getTreeLock.leave;
  end;
end;

function AWTComponent.getPropertyChangeListeners : PropertyChangeListenerArray;
begin
  getTreeLock.enter;
  try
    if not assigned(fChangeSupport) then
      result := NIL
    else result := fChangeSupport.getPropertyChangeListeners;
  finally
    getTreeLock.leave;
  end;
end;

procedure AWTComponent.addPropertyChangeListener(propertyName : string; listener : PropertyChangeListener);
begin
  getTreeLock.enter;
  try
    if (listener = NIL) then
      exit;
    if (not assigned(fChangeSupport)) then
      fChangeSupport := PropertyChangeSupport.create(self);
    fChangeSupport.addPropertyChangeListener(propertyName, listener);
  finally
    getTreeLock.leave;
  end;
end;

procedure AWTComponent.removePropertyChangeListener(propertyName : string; listener : PropertyChangeListener);
begin
  getTreeLock.enter;
  try
    if (listener = NIL) or (not assigned(fChangeSupport)) then
      exit;
    fChangeSupport.removePropertyChangeListener(propertyName, listener);
  finally
    getTreeLock.leave;
  end;
end;

function AWTComponent.getPropertyChangeListeners(propertyName : string) : PropertyChangeListenerArray;
begin
  getTreeLock.enter;
  try
    if not assigned(fChangeSupport) then
      result := NIL
    else result := fChangeSupport.getPropertyChangeListeners(propertyName);
  finally
    getTreeLock.leave;
  end;
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : NPLObject);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if ((changeSupport = NIL) or ((oldValue <> NIL) and (newValue <> NIL) and (oldValue.equals(newValue)))) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : string);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : boolean);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : int);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : sbyte);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : short);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : long);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : char);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : float);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

procedure AWTComponent.firePropertyChange(propertyName : string; oldValue, newValue : double);
var
  changeSupport : PropertyChangeSupport;
begin
  getTreeLock.enter;
  try
    changeSupport := fChangeSupport;
  finally
    getTreeLock.leave;
  end;

  if (changeSupport = NIL) or (oldValue = newValue) then
    exit;

  changeSupport.firePropertyChange(propertyName, oldValue, newValue);
end;

initialization
  LOCK := AWTTreeLock.create;
finalization
  LOCK.free;
end.
