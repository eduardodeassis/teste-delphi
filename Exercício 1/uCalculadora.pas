unit uCalculadora;

interface

  uses uImposto, System.SysUtils;

  type TTipoOperacao = (toFirst, toSoma, toSubtracao, toMultiplicacao, toDivisao,
                        toIgual, toImpostoA, toImpostoB, toImpostoC);

  type TCalculadora = class
    private
      valor, valorIgual :Double;
      operacao :TTipoOperacao;
      primeiraVez :Boolean;
      limparVisor :Boolean;
    public
      constructor Create();
      function getValor :Double;
      function getOperacao :TTipoOperacao;
      function getLimpaVisor :Boolean;
      function Calculo(pValor :Double; pOperacao :TTipoOperacao) :Double;
      function ImpostoA(pValor :Double) :Double;
      function ImpostoB(pValor :Double) :Double;
      function ImpostoC(pValor :Double) :Double;
      procedure Zerar;
  end;

implementation

{ TCalculadora }

function TCalculadora.Calculo(pValor: Double; pOperacao: TTipoOperacao): Double;
begin
  if (pOperacao in [toImpostoA, toImpostoB, toImpostoC]) then
  begin
    case pOperacao of
      toImpostoA: valor := ImpostoA(pValor);
      toImpostoB: valor := ImpostoB(pValor);
      toImpostoC: valor := ImpostoC(pValor);
    end;
    Result := valor;
    primeiraVez := true;
    limparVisor := true;
  end
  else
  begin
    if (pOperacao = toIgual) then
    begin
      if (valorIgual = 0) then
      begin
         valorIgual := pValor;
      end
      else
      begin
        pValor := valorIgual;
      end;
    end;
    //
    if (pOperacao <> toIgual) and (valorIgual > 0) then
    begin
      if (pOperacao in [toMultiplicacao, toDivisao]) then
      begin
        pValor := 1;
      end
      else
      begin
        pValor := 0;
      end;
      valorIgual := 0;
      operacao := pOperacao;
    end;
    if (operacao = toFirst) then
    begin
      valor := pValor;
    end
    else if (operacao = toSoma) then
    begin
      valor := valor + pValor;
    end
    else if (operacao = toSubtracao) then
    begin
      valor := valor - pValor;
    end
    else if (operacao = toMultiplicacao) then
    begin
      valor := valor * pValor;
    end
    else if (operacao = toDivisao) then
    begin
      valor := valor / pValor;
    end;
    //
    if (pOperacao <> toIgual) then
    begin
      operacao := pOperacao;
      valorIgual := 0;
    end;
    //
    Result := valor;
    primeiraVez := false;
    limparVisor := true;
  end;
end;

constructor TCalculadora.Create();
begin
  Zerar;
end;

function TCalculadora.getLimpaVisor: Boolean;
begin
  Result := limparVisor;
  limparVisor := false;
end;

function TCalculadora.getOperacao: TTipoOperacao;
begin
  Result := operacao;
end;

function TCalculadora.getValor: Double;
begin
  Result := valor;
end;

function TCalculadora.ImpostoA(pValor: Double): Double;
var
  imposto :TImpostoExt;
begin
  try
    Result := 0;
    imposto := TImpostoExt.Create;
    Result := imposto.calcImpostoA(pValor);
  finally
    FreeAndNil(imposto);
  end;
end;

function TCalculadora.ImpostoB(pValor: Double): Double;
var

  imposto :TImpostoExt;
begin
  try
    Result := 0;
    imposto := TImpostoExt.Create;
    Result := imposto.calcImpostoB(pValor);
  finally
    FreeAndNil(imposto);
  end;
end;

function TCalculadora.ImpostoC(pValor: Double): Double;
var
  imposto :TImpostoExt;
begin
  try
    Result := 0;
    imposto := TImpostoExt.Create;
    Result := imposto.calcImpostoC(pValor);
  finally
    FreeAndNil(imposto);
  end;
end;

procedure TCalculadora.Zerar;
begin
  valor := 0;
  valorIgual := 0;
  operacao := toFirst;
  primeiraVez := true;
  limparVisor := true;
end;

end.
