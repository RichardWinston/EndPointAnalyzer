object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Endpoint Analyzer'
  ClientHeight = 385
  ClientWidth = 816
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object pc1: TPageControl
    Left = 0
    Top = 0
    Width = 816
    Height = 368
    ActivePage = tabFiles
    Align = alClient
    TabOrder = 0
    object tabFlows: TTabSheet
      Caption = 'Flows'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object rdgFlowData: TRbwDataGrid4
        Left = 0
        Top = 0
        Width = 808
        Height = 293
        Align = alClient
        ColCount = 9
        FixedCols = 0
        RowCount = 7
        FixedRows = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 0
        ExtendedAutoDistributeText = False
        AutoMultiEdit = False
        AutoDistributeText = True
        AutoIncreaseColCount = False
        AutoIncreaseRowCount = True
        SelectedRowOrColumnColor = clAqua
        UnselectableColor = clBtnFace
        ColorRangeSelection = False
        Columns = <
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Integer
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Integer
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Integer
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end>
        OnEndUpdate = rdgFlowDataEndUpdate
        WordWrapRowCaptions = False
        RowHeights = (
          28
          28
          28
          28
          28
          28
          28)
      end
      object pnl1: TPanel
        Left = 0
        Top = 293
        Width = 808
        Height = 41
        Align = alBottom
        TabOrder = 1
        object lblNumberOfCells: TLabel
          Left = 143
          Top = 6
          Width = 111
          Height = 19
          Margins.Bottom = 2
          Caption = 'Number of cells'
        end
        object seNumberOfCells: TJvSpinEdit
          Left = 16
          Top = 6
          Width = 121
          Height = 27
          MaxValue = 2147483647.000000000000000000
          Value = 5.000000000000000000
          TabOrder = 0
          OnChange = seNumberOfCellsChange
        end
      end
    end
    object tabFiles: TTabSheet
      Caption = 'Files'
      ImageIndex = 1
      object lblArsenicLayer: TLabel
        Left = 130
        Top = 133
        Width = 91
        Height = 19
        Margins.Bottom = 2
        Caption = 'Arsenic layer'
      end
      object fedEndpoints: TJvFilenameEdit
        Left = 3
        Top = 24
        Width = 603
        Height = 27
        Filter = 'Endpoint files|*.end|All files (*.*)|*.*'
        ButtonWidth = 27
        TabOrder = 0
        Text = 'Endpoint File'
        OnChange = fedEndpointsChange
      end
      object fedPathline: TJvFilenameEdit
        Left = 3
        Top = 64
        Width = 603
        Height = 27
        Filter = 'Pathline files|*.path|All files (*.*)|*.*'
        ButtonWidth = 27
        TabOrder = 1
        Text = 'Pathline File'
        OnChange = fedPathlineChange
      end
      object seArsenicLayer: TJvSpinEdit
        Left = 3
        Top = 130
        Width = 121
        Height = 27
        MaxValue = 2147483647.000000000000000000
        MinValue = 1.000000000000000000
        Value = 11.000000000000000000
        TabOrder = 3
      end
      object edArsenicFlow: TLabeledEdit
        Left = 3
        Top = 163
        Width = 121
        Height = 27
        EditLabel.Width = 90
        EditLabel.Height = 19
        EditLabel.Caption = 'Arsenic Flow'
        LabelPosition = lpRight
        TabOrder = 4
      end
      object edNonArsenicFlow: TLabeledEdit
        Left = 3
        Top = 196
        Width = 121
        Height = 27
        EditLabel.Width = 125
        EditLabel.Height = 19
        EditLabel.Caption = 'Non-Arsenic Flow'
        LabelPosition = lpRight
        TabOrder = 5
      end
      object fedBudget: TJvFilenameEdit
        Left = 3
        Top = 97
        Width = 603
        Height = 27
        Filter = 'Budget Files (*.cbc)|*.cbc|All files (*.*)|*.*'
        ButtonWidth = 27
        TabOrder = 2
        Text = 'Budget File'
        OnChange = fedBudgetChange
      end
    end
    object tabChart: TTabSheet
      Caption = 'Chart'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cht1: TChart
        Left = 0
        Top = 0
        Width = 808
        Height = 334
        Legend.CheckBoxes = True
        Legend.Font.Charset = ANSI_CHARSET
        Legend.Font.Height = -13
        Legend.Font.Name = 'Times New Roman'
        Legend.LegendStyle = lsSeries
        Legend.Title.Font.Charset = ANSI_CHARSET
        Legend.Title.Font.Height = -13
        Legend.Title.Font.Name = 'Times New Roman'
        Title.Text.Strings = (
          '')
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Grid.Visible = False
        BottomAxis.LabelsFont.Height = -13
        BottomAxis.LabelsFont.Name = 'Times New Roman'
        BottomAxis.LabelsFont.Style = [fsBold]
        BottomAxis.Title.Caption = 'Travel Time (days)'
        BottomAxis.Title.Font.Height = -16
        BottomAxis.Title.Font.Name = 'Times New Roman'
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsFont.Height = -13
        LeftAxis.LabelsFont.Name = 'Times New Roman'
        LeftAxis.LabelsFont.Style = [fsBold]
        LeftAxis.Title.Caption = 'Cumulative Flow (cubic feet per day)'
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Name = 'Times New Roman'
        LeftAxis.Title.Font.Style = [fsBold]
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 0
        PrintMargins = (
          15
          21
          15
          21)
        ColorPaletteIndex = 13
        object lsFlowTravelTime: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'All'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object lsTill: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Till'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object lsBedrock: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Bedrock'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
  object pbAnalyze: TProgressBar
    Left = 0
    Top = 368
    Width = 816
    Height = 17
    Align = alBottom
    Step = 1
    TabOrder = 1
  end
  object mm1: TMainMenu
    Left = 304
    Top = 16
    object miFile1: TMenuItem
      Caption = 'File'
      object miOpen1: TMenuItem
        Caption = 'Open'
        OnClick = miOpen1Click
      end
      object miSave1: TMenuItem
        Caption = 'Save'
        OnClick = miSave1Click
      end
      object miAnalyze1: TMenuItem
        Caption = 'Analyze'
        OnClick = miAnalyze1Click
      end
      object miSaveAnalysis1: TMenuItem
        Caption = 'Save Analysis'
        OnClick = miSaveAnalysis1Click
      end
      object miSavePlot1: TMenuItem
        Caption = 'Save Plot'
        OnClick = miSavePlot1Click
      end
      object miExit1: TMenuItem
        Caption = 'Exit'
        OnClick = miExit1Click
      end
    end
    object miCheckboxVisibility1: TMenuItem
      Caption = 'Toggle Checkbox Visibility'
      OnClick = miCheckboxVisibility1Click
    end
  end
  object svtxtfldlg1: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 272
    Top = 56
  end
  object opntxtfldlg1: TOpenTextFileDialog
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 232
    Top = 56
  end
  object svtxtfldlg2: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 312
    Top = 56
  end
  object svpctrdlg1: TSavePictureDialog
    DefaultExt = '.png'
    Filter = 
      'Portable Network Graphics (*.png)|*.png|JPEG Image File (*.jpg, ' +
      '*.jpeg)|*.jpg;*.jpeg|Enhanced Metafiles (*.emf)|*.emf'
    OnTypeChange = svpctrdlg1TypeChange
    Left = 352
    Top = 64
  end
end
