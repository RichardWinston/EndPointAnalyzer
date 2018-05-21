unit frmMainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, RbwDataGrid4, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Menus, Vcl.ExtDlgs,
  System.Generics.Collections, System.Generics.Defaults, VCLTee.TeEngine,
  VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, JvSpin;

type
  TFlowCol = (fcColumn, fcRow, fcLayer, fcFlowTop, fcFlowBottom, fcFlowFront,
    fcFlowBack, fcFlowRight, fcFlowLeft);

  TEndPointData = class(TObject)
    ID: Integer;
    TravelTime: Double;
    AssociatedFlow: Double;
    IFACE: Integer;
    CellIndex: Integer;
    LowestLayer: integer;
  end;

  TEndPointComparer = TComparer<TEndPointData>;

  TEndPointList = TObjectList<TEndPointData>;

  TfrmMain = class(TForm)
    pc1: TPageControl;
    tabFlows: TTabSheet;
    rdgFlowData: TRbwDataGrid4;
    tabFiles: TTabSheet;
    fedEndpoints: TJvFilenameEdit;
    tabChart: TTabSheet;
    mm1: TMainMenu;
    miFile1: TMenuItem;
    miSave1: TMenuItem;
    miAnalyze1: TMenuItem;
    miSaveAnalysis1: TMenuItem;
    miExit1: TMenuItem;
    miOpen1: TMenuItem;
    svtxtfldlg1: TSaveTextFileDialog;
    opntxtfldlg1: TOpenTextFileDialog;
    cht1: TChart;
    lsFlowTravelTime: TLineSeries;
    svtxtfldlg2: TSaveTextFileDialog;
    fedPathline: TJvFilenameEdit;
    seArsenicLayer: TJvSpinEdit;
    lblArsenicLayer: TLabel;
    edArsenicFlow: TLabeledEdit;
    edNonArsenicFlow: TLabeledEdit;
    miSavePlot1: TMenuItem;
    svpctrdlg1: TSavePictureDialog;
    lsTill: TLineSeries;
    lsBedrock: TLineSeries;
    pbAnalyze: TProgressBar;
    pnl1: TPanel;
    seNumberOfCells: TJvSpinEdit;
    lblNumberOfCells: TLabel;
    fedBudget: TJvFilenameEdit;
    miCheckboxVisibility1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure miExit1Click(Sender: TObject);
    procedure miSave1Click(Sender: TObject);
    procedure miOpen1Click(Sender: TObject);
    procedure miAnalyze1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miSaveAnalysis1Click(Sender: TObject);
    procedure miSavePlot1Click(Sender: TObject);
    procedure svpctrdlg1TypeChange(Sender: TObject);
    procedure rdgFlowDataEndUpdate(Sender: TObject);
    procedure seNumberOfCellsChange(Sender: TObject);
    procedure fedEndpointsChange(Sender: TObject);
    procedure fedPathlineChange(Sender: TObject);
    procedure fedBudgetChange(Sender: TObject);
    procedure miCheckboxVisibility1Click(Sender: TObject);
  private
    FFlowData: array of array of double;
    FParticleCounts: array of array of integer;
    FColNumbers: TList<Integer>;
    FRowNumbers: TList<Integer>;
    FLayerNumbers: TList<Integer>;
    FEndPointList: TEndPointList;
    procedure InitializeFlowData;
    procedure ReadEndPoints;
    procedure PlotData;
    procedure ReadBudgetData;
    procedure UpdateCurrentDir(FileName: TFileName);
    function ReadAnaylzerFile(AnalyzerFileName: TFileName): Boolean;
    procedure SaveAnalysisResult(ResultFileName: TFileName);
    function Analyze: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Math, System.IOUtils, Vcl.Imaging.pngimage, Vcl.Clipbrd,
  Vcl.Imaging.jpeg, InputStorageUnit, ReadModflowArrayUnit;

{$R *.dfm}

procedure TfrmMain.fedBudgetChange(Sender: TObject);
begin
  UpdateCurrentDir(fedBudget.FileName);
end;

procedure TfrmMain.fedEndpointsChange(Sender: TObject);
begin
  UpdateCurrentDir(fedEndpoints.FileName);
end;

procedure TfrmMain.fedPathlineChange(Sender: TObject);
begin
  UpdateCurrentDir(fedPathline.FileName);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  AnalysisFileName: string;
  AnalysisResultsFile: string;
begin
  FColNumbers := TList<Integer>.Create;
  FRowNumbers := TList<Integer>.Create;
  FLayerNumbers := TList<Integer>.Create;
  FEndPointList := TEndPointList.Create;

  rdgFlowData.Cells[Ord(fcColumn),0] := 'IFACE';
  rdgFlowData.Cells[Ord(fcFlowTop),0] := '6';
  rdgFlowData.Cells[Ord(fcFlowBottom),0] := '5';
  rdgFlowData.Cells[Ord(fcFlowFront),0] := '3';
  rdgFlowData.Cells[Ord(fcFlowBack),0] := '4';
  rdgFlowData.Cells[Ord(fcFlowRight),0] := '2';
  rdgFlowData.Cells[Ord(fcFlowLeft),0] := '1';

  rdgFlowData.Cells[Ord(fcColumn),1] := 'Column';
  rdgFlowData.Cells[Ord(fcRow),1] := 'Row';
  rdgFlowData.Cells[Ord(fcLayer),1] := 'Layer';
  rdgFlowData.Cells[Ord(fcFlowTop),1] := 'Flow Top';
  rdgFlowData.Cells[Ord(fcFlowBottom),1] := 'Flow Bottom';
  rdgFlowData.Cells[Ord(fcFlowFront),1] := 'Flow Front';
  rdgFlowData.Cells[Ord(fcFlowBack),1] := 'Flow Back';
  rdgFlowData.Cells[Ord(fcFlowRight),1] := 'Flow Right';
  rdgFlowData.Cells[Ord(fcFlowLeft),1] := 'Flow Left';

  if ParamCount >= 1 then
  begin
    AnalysisFileName := ParamStr(1);
    if FileExists(AnalysisFileName) then
    begin
      if ReadAnaylzerFile(AnalysisFileName) then
      begin
        if ParamCount >= 2 then
        begin
          AnalysisResultsFile := ParamStr(2);
          Show;
          if Analyze then
          begin
            SaveAnalysisResult(AnalysisResultsFile);
            Application.Terminate;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FEndPointList.Free;
  FColNumbers.Free;
  FRowNumbers.Free;
  FLayerNumbers.Free;
end;

function TfrmMain.Analyze: boolean;
begin
  result := True;
  if not FileExists(fedEndpoints.FileName) then
  begin
    Beep;
    MessageDlg('The endpoint file, "' + fedEndpoints.FileName
      + '" does not exist.', mtError, [mbOK], 0);
    result := False;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    pbAnalyze.Position := 0;
    ReadBudgetData;
    InitializeFlowData;
    ReadEndPoints;
    PlotData;
    pc1.ActivePage := tabChart;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.miAnalyze1Click(Sender: TObject);
begin
  Analyze;
  Beep;


end;

procedure TfrmMain.miCheckboxVisibility1Click(Sender: TObject);
begin
  Cht1.Legend.CheckBoxes := not Cht1.Legend.CheckBoxes;
end;

procedure TfrmMain.miExit1Click(Sender: TObject);
begin
  Close;
end;

resourcestring
  StrTheFileCanNotBe = 'The file can not be opened because it is empty.';

procedure TfrmMain.miOpen1Click(Sender: TObject);
var
  AnalyzerFileName: TFileName;
begin
  if opntxtfldlg1.Execute then
  begin
    AnalyzerFileName := opntxtfldlg1.FileName;
    if ReadAnaylzerFile(AnalyzerFileName) then
    begin
      svtxtfldlg1.FileName := AnalyzerFileName;
    end;
  end;
end;

function TfrmMain.ReadAnaylzerFile(AnalyzerFileName: TFileName): boolean;
var
  TempStream: TMemoryStream;
  ItemIndex: Integer;
  FlowItem: TFlowItem;
  RowIndex: Integer;
  FFileStream: TFileStream;
  Input: TEndPointAnalysis;
begin
  result := true;
  SetCurrentDir(ExtractFileDir(AnalyzerFileName));
  svtxtfldlg1.FileName := '';
  FFileStream := TFileStream.Create(AnalyzerFileName,
    fmOpenRead or fmShareDenyWrite);
  try
    FFileStream.Position := 0;
    if FFileStream.Size = 0 then
    begin
      Beep;
      MessageDlg(StrTheFileCanNotBe, mtError, [mbOK], 0);
      result := False;
      Exit;
    end;
    TempStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(FFileStream, TempStream);
      TempStream.Position := 0;
      Input := TEndPointAnalysis.Create(nil);
      try
        TempStream.ReadComponent(Input);
        fedEndpoints.FileName := ExpandFileName(Input.EndPointFile);
        fedPathline.FileName := ExpandFileName(Input.PathLineFile);
        fedBudget.FileName := ExpandFileName(Input.BudgetFile);
        seArsenicLayer.AsInteger := Input.ArsenicLayer;
        seNumberOfCells.asInteger := Max(1, Input.Flows.Count);
        rdgFlowData.RowCount := seNumberOfCells.asInteger + 2;
        rdgFlowData.BeginUpdate;
        try
          for ItemIndex := 0 to Input.Flows.Count - 1 do
          begin
            FlowItem := Input.Flows[ItemIndex];
            RowIndex := ItemIndex + 2;
            rdgFlowData.IntegerValue[Ord(fcColumn), RowIndex] := FlowItem.Column;
            rdgFlowData.IntegerValue[Ord(fcRow), RowIndex] := FlowItem.Row;
            rdgFlowData.IntegerValue[Ord(fcLayer), RowIndex] := FlowItem.Layer;
            rdgFlowData.RealValue[Ord(fcFlowTop), RowIndex] := FlowItem.FlowTop.Value;
            rdgFlowData.RealValue[Ord(fcFlowBottom), RowIndex] := FlowItem.FlowBottom.Value;
            rdgFlowData.RealValue[Ord(fcFlowFront), RowIndex] := FlowItem.FlowFront.Value;
            rdgFlowData.RealValue[Ord(fcFlowBack), RowIndex] := FlowItem.FlowBack.Value;
            rdgFlowData.RealValue[Ord(fcFlowRight), RowIndex] := FlowItem.FlowRight.Value;
            rdgFlowData.RealValue[Ord(fcFlowLeft), RowIndex] := FlowItem.FlowLeft.Value;
          end;
        finally
          rdgFlowData.EndUpdate;
        end;
      finally
        Input.Free;
      end;
    finally
      TempStream.Free;
    end;
    SetCurrentDir(ExtractFileDir(AnalyzerFileName));
  finally
    FFileStream.Free;
  end;
end;

procedure TfrmMain.SaveAnalysisResult(ResultFileName: TFileName);
var
  StrBuilder: TStringBuilder;
  ItemIndex: Integer;
  MyFile: TStringList;
  EndPointItem: TEndPointData;
begin
  MyFile := TStringList.Create;
  StrBuilder := TStringBuilder.Create;
  try
    MyFile.Capacity := FEndPointList.Count + 3;
    if FileExists(fedPathline.FileName) then
    begin
      MyFile.Add('Arsenic Flow:'#9'' + edArsenicFlow.Text);
      MyFile.Add('Non-Arsenic Flow:'#9'' + edNonArsenicFlow.Text);
    end;
    StrBuilder.Append('ID');
    StrBuilder.Append(''#9'');
    StrBuilder.Append('Travel Time');
    StrBuilder.Append(''#9'');
    StrBuilder.Append('IFACE');
    StrBuilder.Append(''#9'');
    StrBuilder.Append('Associated Flow');
    StrBuilder.Append(''#9'');
    StrBuilder.Append('Lowest Layer');
    MyFile.Add(StrBuilder.ToString);
    for ItemIndex := 0 to FEndPointList.Count - 1 do
    begin
      EndPointItem := FEndPointList[ItemIndex];
      StrBuilder.Clear;
      StrBuilder.Append(EndPointItem.ID);
      StrBuilder.Append(''#9'');
      StrBuilder.Append(EndPointItem.TravelTime);
      StrBuilder.Append(''#9'');
      StrBuilder.Append(EndPointItem.IFACE);
      StrBuilder.Append(''#9'');
      StrBuilder.Append(EndPointItem.AssociatedFlow);
      StrBuilder.Append(''#9'');
      StrBuilder.Append(EndPointItem.LowestLayer);
      MyFile.Add(StrBuilder.ToString);
    end;
    MyFile.SaveToFile(ResultFileName);
  finally
    MyFile.Free;
    StrBuilder.Free;
  end;
end;

procedure TfrmMain.miSave1Click(Sender: TObject);
var
  RowIndex: Integer;
  Input: TEndPointAnalysis;
  FlowItem: TFlowItem;
  MemStream: TMemoryStream;
  FileStream: TFileStream;
begin
  if svtxtfldlg1.Execute then
  begin
    Input := TEndPointAnalysis.Create(nil);
    try
      Input.EndPointFile := ExtractRelativePath(svtxtfldlg1.FileName, fedEndpoints.FileName);
      Input.PathLineFile := ExtractRelativePath(svtxtfldlg1.FileName, fedPathline.FileName);
      Input.BudgetFile := ExtractRelativePath(svtxtfldlg1.FileName, fedBudget.FileName);
      Input.ArsenicLayer := seArsenicLayer.AsInteger;
      for RowIndex := 2 to rdgFlowData.RowCount - 1 do
      begin
        FlowItem := Input.Flows.Add;
        FlowItem.FlowTop.Value := StrToFloatDef(rdgFlowData.Cells[Ord(fcFlowTop), RowIndex], 0);
        FlowItem.FlowBottom.Value := StrToFloatDef(rdgFlowData.Cells[Ord(fcFlowBottom), RowIndex], 0);
        FlowItem.FlowFront.Value := StrToFloatDef(rdgFlowData.Cells[Ord(fcFlowFront), RowIndex], 0);
        FlowItem.FlowBack.Value := StrToFloatDef(rdgFlowData.Cells[Ord(fcFlowBack), RowIndex], 0);
        FlowItem.FlowRight.Value := StrToFloatDef(rdgFlowData.Cells[Ord(fcFlowRight), RowIndex], 0);
        FlowItem.FlowLeft.Value := StrToFloatDef(rdgFlowData.Cells[Ord(fcFlowLeft), RowIndex], 0);
        FlowItem.Column := StrToIntDef(rdgFlowData.Cells[Ord(fcColumn), RowIndex], 0);
        FlowItem.Row := StrToIntDef(rdgFlowData.Cells[Ord(fcRow), RowIndex], 0);
        FlowItem.Layer := StrToIntDef(rdgFlowData.Cells[Ord(fcLayer), RowIndex], 0);
      end;

      MemStream := TMemoryStream.Create;
      try
        FileStream := nil;
        try
          FileStream := TFileStream.Create(svtxtfldlg1.FileName, fmCreate or fmShareDenyWrite);
//            ReadWritePermissions);
//          try
            MemStream.WriteComponent(Input);
//          except on EOutOfMemory do
//            begin
//              Beep;
//              MessageDlg(Format(StrYouRanOutOfMemor, ['.gpt']), mtError, [mbOK], 0);
//              Exit;
//            end;
//          end;
//          PhastModel.ClearScreenObjectCollection;
          MemStream.Position := 0;
//          try
            ObjectBinaryToText(MemStream, FileStream);
//          except on EAccessViolation do
//            begin
//              Beep;
//              MessageDlg(StrAnErrorOccuredWhe, mtError, [mbOK], 0);
//            end;
//          end;
        finally
          FileStream.Free;
        end;
      finally
        MemStream.Free;
      end;


    finally
      Input.Free;
    end;

//    AFile := TStringList.Create;
//    StringBuilder := TStringBuilder.Create;
//    try
//      AFile.Add(ExtractRelativePath(svtxtfldlg1.FileName, fedEndpoints.FileName));
//      AFile.Add(ExtractRelativePath(svtxtfldlg1.FileName, fedPathline.FileName));
//      AFile.Add(IntToStr(seArsenicLayer.AsInteger));
//      for RowIndex := 2 to rdgFlowData.RowCount - 1 do
//      begin
//        StringBuilder.Clear;
//        for ColIndex := 0 to rdgFlowData.ColCount - 1 do
//        begin
//          StringBuilder.Append(rdgFlowData.Cells[ColIndex, RowIndex]);
//          if ColIndex <> rdgFlowData.ColCount - 1 then
//          begin
//            StringBuilder.Append(#9);
//          end;
//        end;
//        AFile.Add(StringBuilder.ToString);
//      end;
//      AFile.SaveToFile(svtxtfldlg1.FileName);
//    finally
//      StringBuilder.Free;
//      AFile.Free;
//    end;
  end;
end;

procedure TfrmMain.miSaveAnalysis1Click(Sender: TObject);
var
  ResultFileName: TFileName;
begin
  if svtxtfldlg2.Execute then
  begin
    ResultFileName := svtxtfldlg2.Filename;
    SaveAnalysisResult(ResultFileName);
  end;
end;

procedure TfrmMain.miSavePlot1Click(Sender: TObject);
var
  PngImage: TPngImage;
  Bmp: TBitmap;
  JpgImage: TJPEGImage;
begin
  if svpctrdlg1.Execute then
  begin
    case svpctrdlg1.FilterIndex  of
      1:
        begin
          PngImage := TPngImage.Create;
          Bmp := TBitMap.Create;
          try
            cht1.CopyToClipboardBitmap;
            Bmp.Assign(Clipboard);
            PngImage.Assign(Bmp);
            PngImage.SaveToFile(svpctrdlg1.Filename);
          finally
            PngImage.Free;
            Bmp.Free;
          end;
        end;
      2:
        begin
          JpgImage := TJPEGImage.Create;
          Bmp := TBitMap.Create;
          try
            cht1.CopyToClipboardBitmap;
            Bmp.Assign(Clipboard);
            JpgImage.Assign(Bmp);
            JpgImage.SaveToFile(svpctrdlg1.Filename);
          finally
            JpgImage.Free;
            Bmp.Free;
          end;
        end;
      3:
        begin
          cht1.SaveToMetafileEnh(svpctrdlg1.Filename);
        end;
    end;
  end;
end;

procedure TfrmMain.InitializeFlowData;
var
  Row: Integer;
  AValue: Integer;
  IFaceCols: System.Generics.Collections.TList<Integer>;
  ColIndex: Integer;
  FlowValue: Extended;
  Col: Integer;
  RowIndex: Integer;
begin
  SetLength(FFlowData, 7, rdgFlowData.RowCount - 2);
  SetLength(FParticleCounts, 7, rdgFlowData.RowCount - 2);

  for RowIndex := 0 to rdgFlowData.RowCount - 3 do
  begin
    for ColIndex := 0 to 6 do
    begin
      FFlowData[ColIndex, RowIndex] := 0;
      FParticleCounts[ColIndex, RowIndex] := 0;
    end;
  end;
  FColNumbers.Clear;
  FRowNumbers.Clear;
  FLayerNumbers.Clear;
  for RowIndex := 2 to rdgFlowData.RowCount - 1 do
  begin
    if not TryStrToInt(rdgFlowData.Cells[Ord(fcColumn), RowIndex], AValue) then
    begin
      AValue := -1;
    end;
    FColNumbers.Add(AValue);
    if not TryStrToInt(rdgFlowData.Cells[Ord(fcRow), RowIndex], AValue) then
    begin
      AValue := -1;
    end;
    FRowNumbers.Add(AValue);
    if not TryStrToInt(rdgFlowData.Cells[Ord(fcLayer), RowIndex], AValue) then
    begin
      AValue := -1;
    end;
    FLayerNumbers.Add(AValue);
  end;
  IFaceCols := TList<Integer>.Create;
  try
    IFaceCols.Add(-1);
    for ColIndex := 1 to rdgFlowData.ColCount - 1 do
    begin
      if not TryStrToInt(rdgFlowData.Cells[ColIndex, 0], AValue) then
      begin
        AValue := -1;
      end;
      IFaceCols.Add(AValue);
    end;
    for RowIndex := 2 to rdgFlowData.RowCount - 1 do
    begin
      Row := RowIndex - 2;
      Assert(Row < Length(FFlowData[0]));
      for ColIndex := 3 to rdgFlowData.ColCount - 1 do
      begin
        Col := IFaceCols[ColIndex];
        Assert(Col < Length(FFlowData));
        Assert(Col > 0);
        if TryStrToFloat(rdgFlowData.Cells[ColIndex, RowIndex], FlowValue) then
        begin
          FFlowData[Col, Row] := FlowValue;
        end;
      end;
    end;
  finally
    IFaceCols.Free;
  end;
end;

procedure TfrmMain.ReadBudgetData;
var
  BudgetFile: TFileStream;
  HufFormat: Boolean;
  Precision: TModflowPrecision;
  KSTP: Integer;
  KPER: Integer;
  PERTIM: TModflowDouble;
  TOTIM: TModflowDouble;
  DESC: TModflowDesc;
  NCOL: Integer;
  NROW: Integer;
  NLAY: Integer;
  A3DArray: T3DTModflowArray;
  CurrentPosition: Int64;
  ShouldReadArray: Boolean;
  RightPosition: Int64;
  FrontPosition: Int64;
  LowerPosition: Int64;
  RightArray: T3DTModflowArray;
  FrontArray: T3DTModflowArray;
  LowerArray: T3DTModflowArray;
  RowIndex: Integer;
  Column: Integer;
  Row: Integer;
  Layer: Integer;
  Description: string;
  ColIndex: Integer;
begin
  Assert(FileExists(fedBudget.FileName));
  BudgetFile := TFileStream.Create(fedBudget.FileName, fmOpenRead);
  try
    Precision := CheckBudgetPrecision(BudgetFile, HufFormat);
    ShouldReadArray := False;
    RightPosition := -1;
    FrontPosition := -1;
    LowerPosition := -1;
    while BudgetFile.Position < BudgetFile.Size do
    begin
      CurrentPosition := BudgetFile.Position;
      case Precision of
        mpSingle:
          ReadModflowSinglePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, A3DArray, HufFormat, ShouldReadArray);
        mpDouble:
          ReadModflowDoublePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, A3DArray, HufFormat, ShouldReadArray);
        else Assert(False);
      end;
      Description := Trim(string(DESC));
      if Description = 'FLOW RIGHT FACE' then
      begin
        RightPosition := CurrentPosition;
      end
      else if Description = 'FLOW FRONT FACE' then
      begin
        FrontPosition := CurrentPosition;
      end
      else if Description = 'FLOW LOWER FACE' then
      begin
        LowerPosition := CurrentPosition;
      end;
    end;

    ShouldReadArray := True;
    RightArray := nil;
    if RightPosition >= 0 then
    begin
      BudgetFile.Position := RightPosition;
      case Precision of
        mpSingle:
          ReadModflowSinglePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, RightArray, HufFormat, ShouldReadArray);
        mpDouble:
          ReadModflowDoublePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, RightArray, HufFormat, ShouldReadArray);
        else Assert(False);
      end;
    end;

    FrontArray := nil;
    if FrontPosition >= 0 then
    begin
      BudgetFile.Position := FrontPosition;
      case Precision of
        mpSingle:
          ReadModflowSinglePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, FrontArray, HufFormat, ShouldReadArray);
        mpDouble:
          ReadModflowDoublePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, FrontArray, HufFormat, ShouldReadArray);
        else Assert(False);
      end;
    end;

    LowerArray := nil;
    if LowerPosition >= 0 then
    begin
      BudgetFile.Position := LowerPosition;
      case Precision of
        mpSingle:
          ReadModflowSinglePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, LowerArray, HufFormat, ShouldReadArray);
        mpDouble:
          ReadModflowDoublePrecFluxArray(BudgetFile, KSTP, KPER, PERTIM, TOTIM, DESC,
            NCOL, NROW, NLAY, LowerArray, HufFormat, ShouldReadArray);
        else Assert(False);
      end;
    end;

    rdgFlowData.BeginUpdate;
    try
      for RowIndex := 2 to rdgFlowData.RowCount - 1 do
      begin
        Column := rdgFlowData.IntegerValueDefault[Ord(fcColumn), RowIndex, 0];
        Row := rdgFlowData.IntegerValueDefault[Ord(fcRow), RowIndex, 0];
        Layer := rdgFlowData.IntegerValueDefault[Ord(fcLayer), RowIndex, 0];
        if (Column > 0) and (Row > 0) and (Layer > 0) then
        begin
          if LowerArray <> nil then
          begin
            if Layer > 1 then
            begin
              rdgFlowData.Cells[Ord(fcFlowTop),RowIndex] :=
                FloatToStr(LowerArray[Layer-2,Row-1,Column-1])
            end
            else
            begin
              rdgFlowData.Cells[Ord(fcFlowTop),RowIndex] := '';
            end;
            rdgFlowData.Cells[Ord(fcFlowBottom),RowIndex] :=
              FloatToStr(LowerArray[Layer-1,Row-1,Column-1])
          end
          else
          begin
            rdgFlowData.Cells[Ord(fcFlowTop),RowIndex] := '';
            rdgFlowData.Cells[Ord(fcFlowBottom),RowIndex] := '';
          end;

          if FrontArray <> nil then
          begin
            if Row > 1 then
            begin
              rdgFlowData.Cells[Ord(fcFlowBack),RowIndex] :=
                FloatToStr(FrontArray[Layer-1,Row-2,Column-1])
            end
            else
            begin
              rdgFlowData.Cells[Ord(fcFlowBack),RowIndex] := '';
            end;
            rdgFlowData.Cells[Ord(fcFlowFront),RowIndex] :=
              FloatToStr(FrontArray[Layer-1,Row-1,Column-1])
          end
          else
          begin
            rdgFlowData.Cells[Ord(fcFlowBack),RowIndex] := '';
            rdgFlowData.Cells[Ord(fcFlowFront),RowIndex] := '';
          end;

          if RightArray <> nil then
          begin
            if Column > 1 then
            begin
              rdgFlowData.Cells[Ord(fcFlowLeft),RowIndex] :=
                FloatToStr(RightArray[Layer-1,Row-1,Column-2])
            end
            else
            begin
              rdgFlowData.Cells[Ord(fcFlowLeft),RowIndex] := '';
            end;
            rdgFlowData.Cells[Ord(fcFlowRight),RowIndex] :=
              FloatToStr(RightArray[Layer-1,Row-1,Column-1])
          end
          else
          begin
            rdgFlowData.Cells[Ord(fcFlowLeft),RowIndex] := '';
            rdgFlowData.Cells[Ord(fcFlowRight),RowIndex] := '';
          end;
        end
        else
        begin
          for ColIndex := Ord(fcFlowTop) to rdgFlowData.ColCount - 1 do
          begin
            rdgFlowData.Cells[ColIndex,RowIndex] := '';
          end;
        end;
      end;
    finally
      rdgFlowData.EndUpdate;
    end;
  finally
    BudgetFile.Free;
  end;
end;

procedure TfrmMain.UpdateCurrentDir(FileName: TFileName);
begin
  if FileExists(FileName) then
  begin
    SetCurrentDir(ExtractFileDir(FileName));
  end;
end;

procedure TfrmMain.ReadEndPoints;
const
  IDPosition = 0;
  InitTimePosition = 3;
  FinalTimePosition = 4;
  InitLayerPosition = 6;
  InitRowPosition = 7;
  InitColPosition = 8;
  InitCellFacePostion = 9;
  PathlineLayerPosition = 8;
var
  Column: Integer;
  FoundData: Boolean;
  Flow: Double;
  EndPointFile: TStringList;
  FinalTime: Extended;
  LineIndex: Integer;
  InitialTime: Double;
  Splitter: TStringList;
  IFace: Integer;
  EndPoint: TEndPointData;
  ItemIndex: Integer;
  ID: Integer;
  PathLineReader: TStreamReader;
  ALine: string;
  Layer: integer;
  NewPosition: Int64;
  PathStream: TFileStream;
  Cell: Integer;
  Row: Integer;
  CellIndex: Integer;
begin
  FEndPointList.Clear;
  EndPointFile := TStringList.Create;
  Splitter := TStringList.Create;
  try
    EndPointFile.LoadFromFile(fedEndpoints.FileName);
    Splitter.Delimiter := ' ';
    FoundData := False;
    for LineIndex := 0 to EndPointFile.Count - 1 do
    begin
      if FoundData then
      begin
        Splitter.DelimitedText := EndPointFile[LineIndex];
        if Splitter.Count > 0 then
        begin
          Assert(Splitter.Count >= 30);
          ID := StrToInt(Splitter[IDPosition]);
          InitialTime := StrToFloat(Splitter[InitTimePosition]);
          FinalTime := StrToFloat(Splitter[FinalTimePosition]);
          Column := StrToInt(Splitter[InitColPosition]);
          Assert(Column > 0);
          Row := StrToInt(Splitter[InitRowPosition]);
          Assert(Row > 0);
          Layer := StrToInt(Splitter[InitLayerPosition]);
          Assert(Layer > 0);

          IFace := StrToInt(Splitter[InitCellFacePostion]);
          Assert(IFace in [1..6]);


          CellIndex := -1;
          for Cell := 0 to FColNumbers.Count - 1 do
          begin
            if (FColNumbers[Cell] = Column) and (FRowNumbers[Cell] = Row)
              and (FLayerNumbers[Cell] = Layer) then
            begin
              CellIndex := Cell;
              break;
            end;
          end;

          Assert(CellIndex >= 0);
          FParticleCounts[IFace, CellIndex] := FParticleCounts[IFace, CellIndex]+1;

          EndPoint := TEndPointData.Create;
          FEndPointList.Add(EndPoint);
          EndPoint.ID := ID;
          EndPoint.TravelTime := (FinalTime - InitialTime);
//          EndPoint.AssociatedFlow := Flow;
          EndPoint.IFACE := IFace;
          EndPoint.CellIndex := CellIndex;
          EndPoint.LowestLayer := -1;
        end;
      end
      else if Trim(EndPointFile[LineIndex]) = 'END HEADER' then
      begin
        FoundData := True;
      end;
    end;
  finally
    EndPointFile.Free;
    Splitter.Free;
  end;

  for ItemIndex := 0 to FEndPointList.Count - 1 do
  begin
    EndPoint := FEndPointList[ItemIndex];
    Flow := FFlowData[EndPoint.IFace, EndPoint.CellIndex];
    EndPoint.AssociatedFlow := Flow/FParticleCounts[EndPoint.IFace, EndPoint.CellIndex];
//    if EndPoint.AssociatedFlow = 0 then
//    begin
//      Assert(False);
//    end;
    Assert(EndPoint.AssociatedFlow <> 0);
  end;

  if FileExists(fedPathline.FileName) then
  begin
    PathLineReader := TFile.OpenText(fedPathline.FileName);
    Splitter := TStringList.Create;
    try
      Splitter.Delimiter := ' ';
      FoundData := False;
      PathStream := PathLineReader.BaseStream as TFileStream;
      pbAnalyze.Max := 1000;
      while not PathLineReader.EndOfStream do
      begin
        ALine := PathLineReader.ReadLine;
        NewPosition := Round(PathStream.Position / PathStream.Size * 1000);
        if NewPosition <> pbAnalyze.Position then
        begin
          pbAnalyze.Position := NewPosition;
        end;
        if FoundData then
        begin
          Splitter.DelimitedText := ALine;
          if Splitter.Count > 0 then
          begin
            Assert(Splitter.Count = 16);
            ID := StrToInt(Splitter[IDPosition]);
            Layer := StrToInt(Splitter[PathlineLayerPosition]);
            EndPoint := FEndPointList[ID-1];
            Assert(EndPoint.ID = ID);
            if Layer > EndPoint.LowestLayer then
            begin
              EndPoint.LowestLayer := Layer;
            end;
          end;
        end
        else if Trim(ALine) = 'END HEADER' then
        begin
          FoundData := True;
        end;
      end;

    finally
      PathLineReader.Free;
      Splitter.Free;
    end;
  end;
  pbAnalyze.Position := 0;

//  Sort in ascending order.
  FEndPointList.Sort(TEndPointComparer.Construct(
    function (const L, R: TEndPointData): integer
    begin
     result := Sign(L.TravelTime - R.TravelTime);
    end
    )) ;

end;

procedure TfrmMain.seNumberOfCellsChange(Sender: TObject);
begin
  rdgFlowData.RowCount := Max(3, seNumberOfCells.asInteger + 2);
end;

procedure TfrmMain.svpctrdlg1TypeChange(Sender: TObject);
begin
  case svpctrdlg1.FilterIndex of
    1: svpctrdlg1.DefaultExt := '.png';
    2: svpctrdlg1.DefaultExt := '.jpg';
    3: svpctrdlg1.DefaultExt := '.emf';
  end;
  svpctrdlg1.FileName :=
    ChangeFileExt(svpctrdlg1.FileName, svpctrdlg1.DefaultExt);
end;

procedure TfrmMain.PlotData;
var
  EndPointData: TEndPointData;
  CumulativeFlow: Double;
  ItemIndex: Integer;
  ArsenicLayer: integer;
  ArsenicFlow: double;
  NonArsenicFlow: double;
begin
  lsFlowTravelTime.Clear;
  lsFlowTravelTime.BeginUpdate;
  lsBedrock.Clear;
  lsBedrock.BeginUpdate;
  lsTill.Clear;
  lsTill.BeginUpdate;
  ArsenicLayer := seArsenicLayer.AsInteger;
  try
    CumulativeFlow := 0;
    ArsenicFlow := 0;
    NonArsenicFlow := 0;
    for ItemIndex := 0 to FEndPointList.Count - 1 do
    begin
      EndPointData := FEndPointList[ItemIndex];
      CumulativeFlow := CumulativeFlow + Abs(EndPointData.AssociatedFlow);
      lsFlowTravelTime.AddXY(EndPointData.TravelTime, CumulativeFlow);
      if EndPointData.LowestLayer >= ArsenicLayer then
      begin
        ArsenicFlow := ArsenicFlow + Abs(EndPointData.AssociatedFlow);
        lsBedrock.AddXY(EndPointData.TravelTime, ArsenicFlow);
      end
      else
      begin
        NonArsenicFlow := NonArsenicFlow + Abs(EndPointData.AssociatedFlow);
        lsTill.AddXY(EndPointData.TravelTime, NonArsenicFlow);
      end;
    end;
    edNonArsenicFlow.Text := FloatToStr(NonArsenicFlow);
    edArsenicFlow.Text := FloatToStr(ArsenicFlow);
  finally
    lsFlowTravelTime.EndUpdate;
    lsBedrock.EndUpdate;
    lsTill.EndUpdate;
  end;
end;

procedure TfrmMain.rdgFlowDataEndUpdate(Sender: TObject);
begin
  seNumberOfCells.asInteger := rdgFlowData.RowCount -2;
end;

{ TEndPointData }

end.
