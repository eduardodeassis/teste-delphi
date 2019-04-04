unit uEntidadesDeCalculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uEntidades, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons;

type
  TFrmEntidadesDeCalculo = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtNomeFuncionario: TEdit;
    Label2: TLabel;
    edtCPFFuncionario: TEdit;
    Label3: TLabel;
    edtSalarioFuncionario: TEdit;
    GroupBox2: TGroupBox;
    sgDependente: TStringGrid;
    edtNomeDependente: TEdit;
    Label4: TLabel;
    chkIRDependente: TCheckBox;
    chkINSSDependente: TCheckBox;
    btnAdicionar: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtValorIR: TEdit;
    edtValorINSS: TEdit;
    edtSalarioComDescontos: TEdit;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure atualizaTelaFuncionario;
    procedure atualizaTelaDependentes;
    procedure atualizaTelaValores;
    procedure sgDependenteSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtSalarioFuncionarioChange(Sender: TObject);
    procedure edtSalarioFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure edtNomeFuncionarioChange(Sender: TObject);
    procedure edtCPFFuncionarioChange(Sender: TObject);
    procedure edtCPFFuncionarioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    Funcionario :TFuncionario;
  end;

var
  FrmEntidadesDeCalculo: TFrmEntidadesDeCalculo;

implementation

{$R *.dfm}

uses uDM;

procedure TFrmEntidadesDeCalculo.atualizaTelaDependentes;
var
  i: Integer;
begin
  sgDependente.RowCount := Funcionario.ListaDependente.Count + 1;
  for i := 1 to Funcionario.ListaDependente.Count do
  begin
    sgDependente.Cells[0,i] := Funcionario.ListaDependente[i-1].Nome;
    if (Funcionario.ListaDependente[i-1].IsCalculaIR) then
    begin
      sgDependente.Cells[1,i] := 'Sim';
    end
    else
    begin
      sgDependente.Cells[1,i] := 'N�o';
    end;
    if (Funcionario.ListaDependente[i-1].IsCalculaINSS) then
    begin
      sgDependente.Cells[2,i] := 'Sim';
    end
    else
    begin
      sgDependente.Cells[2,i] := 'N�o';
    end;
  end;
  if (sgDependente.RowCount > 1) then
  begin
    sgDependente.Row := 1;
    sgDependente.Col := 0;
    edtNomeDependente.Text := sgDependente.Cells[0, 1];
    chkIRDependente.Checked := sgDependente.Cells[1, 1] = 'Sim';
    chkINSSDependente.Checked := sgDependente.Cells[2, 1] = 'Sim';
  end
  else
  begin
     edtNomeDependente.Text := '';
    chkIRDependente.Checked := false;
    chkINSSDependente.Checked := false;
  end;
  atualizaTelaValores;
end;

procedure TFrmEntidadesDeCalculo.atualizaTelaFuncionario;
begin
  edtNomeFuncionario.Text := Funcionario.Nome;
  edtCPFFuncionario.Text := Funcionario.CPF;
  edtSalarioFuncionario.Text := FormatFloat('0.00', Funcionario.Salario);
end;

procedure TFrmEntidadesDeCalculo.atualizaTelaValores;
begin
  edtValorIR.Text := FormatFloat('0.00', Funcionario.getValorIR);
  edtValorINSS.Text := FormatFloat('0.00', Funcionario.getValorINSS);
  edtSalarioComDescontos.Text := FormatFloat('0.00', Funcionario.getValorSalarioComDescontos);
end;

procedure TFrmEntidadesDeCalculo.btnAdicionarClick(Sender: TObject);
begin
  Funcionario.adicionarDependente(edtNomeDependente.Text,
                                  chkIRDependente.Checked,
                                  chkINSSDependente.Checked);
  atualizaTelaDependentes;
end;

procedure TFrmEntidadesDeCalculo.btnAlterarClick(Sender: TObject);
begin
  if (sgDependente.RowCount > 1) then
  begin
    Funcionario.alterarDependente(sgDependente.Row-1,
                                  edtNomeDependente.Text,
                                  chkIRDependente.Checked,
                                  chkINSSDependente.Checked);
    atualizaTelaDependentes;
  end;
end;

procedure TFrmEntidadesDeCalculo.btnAnteriorClick(Sender: TObject);
begin
  DM.getDBFuncionario(Funcionario, Anterior);
  atualizaTelaFuncionario;
  atualizaTelaDependentes;
end;

procedure TFrmEntidadesDeCalculo.btnCancelarClick(Sender: TObject);
begin
  DM.getDBFuncionario(Funcionario, Atual);
  atualizaTelaFuncionario;
  atualizaTelaDependentes;
end;

procedure TFrmEntidadesDeCalculo.btnExcluirClick(Sender: TObject);
begin
  if (MessageDlg('Confirma a exclus�o do dependente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    if (sgDependente.RowCount > 1) then
    begin
      Funcionario.deletaDependente(sgDependente.Row-1);
      atualizaTelaDependentes;
    end;
  end;
end;

procedure TFrmEntidadesDeCalculo.btnGravarClick(Sender: TObject);
begin
  DM.gravaDBFuncionario(Funcionario);
end;

procedure TFrmEntidadesDeCalculo.btnProximoClick(Sender: TObject);
begin
  DM.getDBFuncionario(Funcionario, Proximo);
  atualizaTelaFuncionario;
  atualizaTelaDependentes;
end;

procedure TFrmEntidadesDeCalculo.edtCPFFuncionarioChange(Sender: TObject);
begin
  Funcionario.CPF := edtCPFFuncionario.Text;
end;

procedure TFrmEntidadesDeCalculo.edtCPFFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '-', '.', '0'..'9', #8:
    begin

    end;
    else
    begin
       key := #0;
    end;
  end;
end;

procedure TFrmEntidadesDeCalculo.edtNomeFuncionarioChange(Sender: TObject);
begin
  Funcionario.Nome := edtNomeFuncionario.Text;
end;

procedure TFrmEntidadesDeCalculo.edtSalarioFuncionarioChange(Sender: TObject);
begin
  try
    if (trim(edtSalarioFuncionario.Text) <> '') then
    begin
      Funcionario.Salario := StrToFloat(edtSalarioFuncionario.Text);
    end
    else
    begin
      Funcionario.Salario := 0;
    end;
    atualizaTelaValores;
  except
    MessageDlg('O Sal�rio informado � inv�lido.', mtError, [mbOk], 0);
  end;
end;

procedure TFrmEntidadesDeCalculo.edtSalarioFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    ',':
    begin
      if (Pos(',', edtSalarioFuncionario.Text) > 0) then
      begin
        key := #0;
      end;
    end;
    '0'..'9', #8:
    begin

    end;
    else
    begin
       key := #0;
    end;
  end;
end;

procedure TFrmEntidadesDeCalculo.FormCreate(Sender: TObject);
begin
  Funcionario := TFuncionario.Create;
  DM := TDM.Create(nil);
  //
  sgDependente.Cells[0,0] := 'Nome';
  sgDependente.Cells[1,0] := 'IR';
  sgDependente.Cells[2,0] := 'INSS';
  //
  DM.getDBFuncionario(Funcionario, Atual);
  //
  atualizaTelaFuncionario;
  atualizaTelaDependentes;
end;

procedure TFrmEntidadesDeCalculo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Funcionario);
  FreeAndNil(DM);
end;

procedure TFrmEntidadesDeCalculo.sgDependenteSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  edtNomeDependente.Text := sgDependente.Cells[0, ARow];
  chkIRDependente.Checked := sgDependente.Cells[1, ARow] = 'Sim';
  chkINSSDependente.Checked := sgDependente.Cells[2, ARow] = 'Sim';
end;

end.

