unit uFrmCalculadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCalculadora, Vcl.Buttons;

type
  TfrmCalculadora = class(TForm)
    edtVisor: TEdit;
    btn0: TSpeedButton;
    btnIgual: TSpeedButton;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btnAdicao: TSpeedButton;
    btnSubtracao: TSpeedButton;
    btnMultiplicacao: TSpeedButton;
    btnDivisao: TSpeedButton;
    btnVirgula: TSpeedButton;
    btnImpostoA: TSpeedButton;
    btnImpostoB: TSpeedButton;
    btnImpostoC: TSpeedButton;
    btnZerar: TSpeedButton;
    procedure btnVirgulaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicaoClick(Sender: TObject);
    procedure btnZerarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Calculadora : TCalculadora;
  end;

var
  frmCalculadora: TfrmCalculadora;

implementation

{$R *.dfm}

procedure TfrmCalculadora.btnAdicaoClick(Sender: TObject);
var
  valor, resultado :Double;
  operacao :String;
begin
  try
    valor := StrToFloat(edtVisor.Text);
    operacao := TButton(Sender).Caption;
    if (Pos('Imp', operacao)>0) then
    begin
       operacao := TButton(Sender).Hint;
    end;
    resultado := Calculadora.Calculo(valor, operacao);
    edtVisor.Text := FloatToStr(resultado);
  except
    MessageDlg('Operação Inválida!', mtError, [mbOK], 0);
    btnZerar.Click;
  end;
end;

procedure TfrmCalculadora.btnVirgulaClick(Sender: TObject);
begin
  if (TButton(Sender).Caption = ',') then
  begin
    if (Calculadora.getLimpaVisor) then
    begin
      edtVisor.Text := '0,';
    end
    else if (Pos(',', edtVisor.Text) = 0) then
    begin
      edtVisor.Text := edtVisor.Text + ',';
    end;
  end
  else
  begin
    if (Calculadora.getLimpaVisor) or (edtVisor.Text='0') then
    begin
      edtVisor.Text := TButton(Sender).Caption;
    end
    else
    begin
      edtVisor.Text := edtVisor.Text + TButton(Sender).Caption;
    end;
  end;
  frmCalculadora.SetFocus;
end;

procedure TfrmCalculadora.btnZerarClick(Sender: TObject);
begin
  Calculadora.Zerar;
  edtVisor.Text := '0';
end;

procedure TfrmCalculadora.FormCreate(Sender: TObject);
begin
  Calculadora := TCalculadora.Create;
  //
  btnImpostoA.Caption := 'Imposto'#13'A';
  btnImpostoB.Caption := 'Imposto'#13'B';
  btnImpostoC.Caption := 'Imposto'#13'C';
end;

procedure TfrmCalculadora.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Calculadora);
end;

procedure TfrmCalculadora.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '*', 'x', 'X': btnMultiplicacao.Click;
    '/': btnDivisao.Click;
    '-': btnSubtracao.Click;
    '+': btnAdicao.Click;
    '=', #13: btnIgual.Click;
    ',', '.': btnVirgula.Click;
    '0'..'9':
    begin
      TButton(frmCalculadora.FindComponent('btn'+key)).Click;
    end;
  end;
  frmCalculadora.SetFocus;
end;

end.
