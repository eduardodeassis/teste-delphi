program EntidadesDeCalculo;

uses
  Vcl.Forms,
  uEntidadesDeCalculo in 'uEntidadesDeCalculo.pas' {FrmEntidadesDeCalculo},
  uEntidades in 'uEntidades.pas',
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmEntidadesDeCalculo, FrmEntidadesDeCalculo);
  Application.Run;
end.
