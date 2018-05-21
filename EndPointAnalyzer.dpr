program EndPointAnalyzer;

uses
  Vcl.Forms,
  frmMainUnit in 'frmMainUnit.pas' {frmMain},
  InputStorageUnit in 'InputStorageUnit.pas',
  ReadModflowArrayUnit in 'ReadModflowArrayUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
