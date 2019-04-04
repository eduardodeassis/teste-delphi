unit uEntidades;

interface
  uses System.Generics.Collections, System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

  type TDependente = class
    private
      FID :Integer;
      FNome :String;
      FIsCalculaIR :Boolean;
      FIsCalculaINSS :Boolean;
    public
      property ID :Integer read FID;
      property Nome :String read FNome write FNome;
      property IsCalculaIR :Boolean read FIsCalculaIR write FIsCalculaIR;
      property IsCalculaINSS :Boolean read FIsCalculaINSS write FIsCalculaINSS;
  end;

  type TFuncionario = class
    private
      FID :Integer;
      FNome :String;
      FCPF :String;
      FSalario :Double;
      FListaDependente : TObjectList<TDependente>;
    public
      property ID :Integer read FID write FID;
      property Nome :String read FNome write FNome;
      property CPF :String read FCPF write FCPF;
      property Salario :Double read FSalario write FSalario;
      property ListaDependente :TObjectList<TDependente> read FListaDependente;

      constructor Create();
      destructor Destroy; override;
      procedure limparDados;

      procedure adicionarDependente(pNome :String; pIsCalculaIR :Boolean;
                                    pIsCalculaINSS :Boolean);
      procedure alterarDependente(pIndice :Integer; pNome :String;
                            pIsCalculaIR :Boolean; pIsCalculaINSS :Boolean);
      procedure deletaDependente(pIndice :Integer);

      function getValorIR :Double;
      function getValorINSS :Double;
      function getValorSalarioComDescontos :Double;
  end;


implementation

uses uDM;

{ TFuncionario }

procedure TFuncionario.adicionarDependente(pNome: String; pIsCalculaIR,
  pIsCalculaINSS: Boolean);
var
  x :Integer;
begin
  FListaDependente.Add(TDependente.Create);
  x := FListaDependente.Count-1;
  FListaDependente[x].Nome := pNome;
  FListaDependente[x].IsCalculaIR := pIsCalculaIR;
  FListaDependente[x].IsCalculaINSS := pIsCalculaINSS;
end;

procedure TFuncionario.alterarDependente(pIndice: Integer; pNome: String;
  pIsCalculaIR, pIsCalculaINSS: Boolean);
begin
  FListaDependente[pIndice].Nome := pNome;
  FListaDependente[pIndice].IsCalculaIR := pIsCalculaIR;
  FListaDependente[pIndice].IsCalculaINSS := pIsCalculaINSS;
end;

procedure TFuncionario.limparDados;
begin
  FID := 0;
  FNome := '';
  FCPF := '';
  FSalario := 0;
  FListaDependente.Clear;
end;

constructor TFuncionario.Create;
begin
  inherited;
  FListaDependente := TObjectList<TDependente>.Create();
end;

procedure TFuncionario.deletaDependente(pIndice: Integer);
begin
  FListaDependente.Delete(pIndice);
end;

destructor TFuncionario.Destroy;
begin
  FreeAndNil(FListaDependente);
  inherited;
end;

function TFuncionario.getValorINSS: Double;
var
  i :Integer;
  isCalculaINSS :Boolean;
begin
  Result := 0;
  if (FSalario <=0) then
  begin
    Exit;
  end;
  isCalculaINSS := false;
  for i := 0 to FListaDependente.Count-1 do
  begin
    if (FListaDependente[i].FIsCalculaINSS) then
    begin
      isCalculaINSS := true;
      Break;
    end;
  end;
  if (isCalculaINSS) then
  begin
    Result := FSalario * 0.08;
  end;
end;

function TFuncionario.getValorIR: Double;
var
  i :Integer;
  valorDesconto, valorIR :Double;
begin
  Result := 0;
  if (FSalario <=0) then
  begin
    Exit;
  end;
  valorDesconto := 0;
  for i := 0 to FListaDependente.Count-1 do
  begin
    if (FListaDependente[i].FIsCalculaIR) then
    begin
      valorDesconto := valorDesconto + 100;
    end;
  end;
  valorIR := (FSalario - valorDesconto) * 0.15;
  if (valorIR < 0) then
  begin
    valorIR := 0;
  end;
  Result := valorIR;
end;

function TFuncionario.getValorSalarioComDescontos: Double;
begin
  Result := FSalario - getValorIR - getValorINSS;
end;

end.
