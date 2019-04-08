program Calculadora;

uses
  Vcl.Forms,
  uFrmCalculadora in 'uFrmCalculadora.pas' {frmCalculadora},
  uCalculadora in 'uCalculadora.pas',
  uImposto in 'uImposto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCalculadora, frmCalculadora);
  Application.Run;
end.
