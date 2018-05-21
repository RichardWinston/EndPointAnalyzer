unit InputStorageUnit;

interface

uses Classes, System.SysUtils;

type
  TRealStorage = class(TPersistent)
  private
    FValue: real;
    FOnChange: TNotifyEvent;
    procedure SetValue(const Value: real);
  protected
    procedure ReadValue(Reader: TReader);
    procedure ReadStringValue(Reader: TReader);
    procedure WriteValue(Writer: TWriter);
    procedure WriteStringValue(Writer: TWriter);
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Value: real read FValue write SetValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TFlowItem = class(TCollectionItem)
  private
    FFlowBack: TRealStorage;
    FFlowTop: TRealStorage;
    FFlowRight: TRealStorage;
    FFlowFront: TRealStorage;
    FFlowBottom: TRealStorage;
    FFlowLeft: TRealStorage;
    FLayer: Integer;
    FRow: Integer;
    FColumn: Integer;
    procedure SetFlowBack(const Value: TRealStorage);
    procedure SetFlowBottom(const Value: TRealStorage);
    procedure SetFlowFront(const Value: TRealStorage);
    procedure SetFlowRight(const Value: TRealStorage);
    procedure SetFlowTop(const Value: TRealStorage);
    procedure SetFlowLeft(const Value: TRealStorage);
    procedure SetColumn(const Value: Integer);
    procedure SetLayer(const Value: Integer);
    procedure SetRow(const Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property FlowTop: TRealStorage read FFlowTop write SetFlowTop;
    property FlowBottom: TRealStorage read FFlowBottom write SetFlowBottom;
    property FlowFront: TRealStorage read FFlowFront write SetFlowFront;
    property FlowBack: TRealStorage read FFlowBack write SetFlowBack;
    property FlowRight: TRealStorage read FFlowRight write SetFlowRight;
    property FlowLeft: TRealStorage read FFlowLeft write SetFlowLeft;
    property Layer: Integer read FLayer write SetLayer;
    property Row: Integer read FRow write SetRow;
    property Column: Integer read FColumn write SetColumn;
  end;

  TFlowCollection = class(TCollection)
  private
    function GetItems(Index: Integer): TFlowItem;
    procedure SetItems(Index: Integer; const Value: TFlowItem);
  public
    constructor Create;
    function Add: TFlowItem;
    property Items[Index: Integer]: TFlowItem read GetItems write SetItems; default;
  end;

  TEndPointAnalysis = class(TComponent)
  private
    FFlows: TFlowCollection;
    FPathLineFile: string;
    FArsenicLayer: integer;
    FEndPointFile: string;
    FBudgetFile: string;
    procedure SetArsenicLayer(const Value: integer);
    procedure SetEndPointFile(const Value: string);
    procedure SetFlows(const Value: TFlowCollection);
    procedure SetPathLineFile(const Value: string);
    procedure SetBudgetFile(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Flows: TFlowCollection read FFlows write SetFlows;
    property EndPointFile: string read FEndPointFile write SetEndPointFile;
    property PathLineFile: string read FPathLineFile write SetPathLineFile;
    property BudgetFile: string read FBudgetFile write SetBudgetFile;
    property ArsenicLayer: integer read FArsenicLayer write SetArsenicLayer;
  end;

implementation

uses
  System.Math, System.StrUtils;

function FortranStrToFloat(AString: string): Extended;
var
  OldDecimalSeparator: Char;
  SignPos: Integer;
begin
  AString := Trim(AString);
  OldDecimalSeparator := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    AString := StringReplace(AString, ',', '.', [rfReplaceAll, rfIgnoreCase]);
    AString := StringReplace(AString, 'd', 'e', [rfReplaceAll, rfIgnoreCase]);
    SignPos := Max(PosEx('+', AString, 2), PosEx('-', AString, 2));
    if SignPos > 0 then
    begin
      if not CharInSet(AString[SignPos-1], ['e', 'E']) then
      begin
        Insert('E', AString, SignPos);
      end;
    end;
    result := StrToFloat(AString);
  finally
    FormatSettings.DecimalSeparator := OldDecimalSeparator;
  end;
end;


{ TRealStorage }

procedure TRealStorage.Assign(Source: TPersistent);
begin
  if Source is TRealStorage then
  begin
    Value := TRealStorage(Source).Value;
  end
  else
  begin
    inherited;
  end;
end;

procedure TRealStorage.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Value', ReadValue, WriteValue, Value = 0);
  Filer.DefineProperty('StringValue', ReadStringValue, WriteStringValue,
   (Value <> 0) and (Abs(Value) < 1e-10));
end;

procedure TRealStorage.ReadStringValue(Reader: TReader);
begin
  Value := FortranStrToFloat(Reader.ReadString)
end;

procedure TRealStorage.ReadValue(Reader: TReader);
begin
  Value := Reader.ReadFloat;
end;

procedure TRealStorage.SetValue(const Value: real);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    if Assigned(OnChange) then
    begin
      OnChange(self);
    end;
  end;
end;

var
  LFormatSettings: TFormatSettings;

procedure TRealStorage.WriteStringValue(Writer: TWriter);
begin
  Writer.WriteString(FloatToStrF(Value, ffGeneral, 16, 18, LFormatSettings));
end;

procedure TRealStorage.WriteValue(Writer: TWriter);
begin
  Writer.WriteFloat(Value);
end;

{ TFlowItem }

procedure TFlowItem.Assign(Source: TPersistent);
var
  SourceFlow: TFlowItem;
begin
  if Source is TFlowItem then
  begin
    SourceFlow := TFlowItem(Source);
    FlowTop := SourceFlow.FlowTop;
    FlowBottom := SourceFlow.FlowBottom;
    FlowFront := SourceFlow.FlowFront;
    FlowBack := SourceFlow.FlowBack;
    FlowRight := SourceFlow.FlowRight;
    FlowLeft := SourceFlow.FlowLeft;
    Layer := SourceFlow.Layer;
    Row := SourceFlow.Row;
    Column := SourceFlow.Column;
  end
  else
  begin
    inherited;
  end;
end;

constructor TFlowItem.Create(Collection: TCollection);
begin
  inherited;
  FFlowBack := TRealStorage.Create;
  FFlowTop := TRealStorage.Create;
  FFlowRight := TRealStorage.Create;
  FFlowFront := TRealStorage.Create;
  FFlowBottom := TRealStorage.Create;
  FFlowLeft := TRealStorage.Create;
end;

destructor TFlowItem.Destroy;
begin
  FFlowLeft.Free;
  FFlowBottom.Free;
  FFlowFront.Free;
  FFlowRight.Free;
  FFlowTop.Free;
  FFlowBack.Free;
  inherited;
end;

procedure TFlowItem.SetColumn(const Value: Integer);
begin
  FColumn := Value;
end;

procedure TFlowItem.SetFlowBack(const Value: TRealStorage);
begin
  FFlowBack.Assign(Value);
end;

procedure TFlowItem.SetFlowBottom(const Value: TRealStorage);
begin
  FFlowBottom.Assign(Value);
end;

procedure TFlowItem.SetFlowFront(const Value: TRealStorage);
begin
  FFlowFront.Assign(Value);
end;

procedure TFlowItem.SetFlowLeft(const Value: TRealStorage);
begin
  FFlowLeft.Assign(Value);
end;

procedure TFlowItem.SetFlowRight(const Value: TRealStorage);
begin
  FFlowRight.Assign(Value);
end;

procedure TFlowItem.SetFlowTop(const Value: TRealStorage);
begin
  FFlowTop.Assign(Value);
end;

procedure TFlowItem.SetLayer(const Value: Integer);
begin
  FLayer := Value;
end;

procedure TFlowItem.SetRow(const Value: Integer);
begin
  FRow := Value;
end;

{ TFlowCollection }

function TFlowCollection.Add: TFlowItem;
begin
  result := inherited Add as TFlowItem;
end;

constructor TFlowCollection.Create;
begin
  inherited Create(TFlowItem);
end;

function TFlowCollection.GetItems(Index: Integer): TFlowItem;
begin
  Result := inherited Items[Index] as TFlowItem;
end;

procedure TFlowCollection.SetItems(Index: Integer; const Value: TFlowItem);
begin
  inherited Items[Index] := Value;
end;

{ TEndPointAnalysis }

constructor TEndPointAnalysis.Create(AOwner: TComponent);
begin
  inherited;
  FFlows := TFlowCollection.Create;
end;

destructor TEndPointAnalysis.Destroy;
begin
  FFlows.Free;
  inherited;
end;

procedure TEndPointAnalysis.SetArsenicLayer(const Value: integer);
begin
  FArsenicLayer := Value;
end;

procedure TEndPointAnalysis.SetBudgetFile(const Value: string);
begin
  FBudgetFile := Value;
end;

procedure TEndPointAnalysis.SetEndPointFile(const Value: string);
begin
  FEndPointFile := Value;
end;

procedure TEndPointAnalysis.SetFlows(const Value: TFlowCollection);
begin
  FFlows.Assign(Value);
end;

procedure TEndPointAnalysis.SetPathLineFile(const Value: string);
begin
  FPathLineFile := Value;
end;

initialization
  LFormatSettings := TFormatSettings.Create('en-US'); // do not localize
  LFormatSettings.DecimalSeparator := AnsiChar('.');
  RegisterClass(TEndPointAnalysis);


end.
