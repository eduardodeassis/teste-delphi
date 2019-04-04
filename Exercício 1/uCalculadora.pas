unit uCalculadora;

interface

  type TCalculadora = class
    private
      valor, valorIgual :Double;
      operacao :String;
      primeiraVez :Boolean;
      limparVisor :Boolean;
    public
      constructor Create();
      function getValor :Double;
      function getOperacao :String;
      function getLimpaVisor :Boolean;
      function Calculo(pValor :Double; pOperacao :String) :Double;
      function ImpostoA(pValor :Double) :Double;
      function ImpostoB(pValor :Double) :Double;
      function ImpostoC(pValor :Double) :Double;
      procedure Zerar;
  end;

implementation

{ TCalculadora }

function TCalculadora.Calculo(pValor: Double; pOperacao: String): Double;
begin
  if (Pos(pOperacao, 'ABC')>0) then
  begin
    if (pOperacao = 'A') then
    begin
      valor := ImpostoA(pValor);
    end
    else if (pOperacao = 'B') then
    begin
      valor := ImpostoB(pValor);
    end
    else if (pOperacao = 'C') then
    begin
      valor := ImpostoC(pValor);
    end;
    Result := valor;
    primeiraVez := true;
    limparVisor := true;
  end
  else
  begin
    if (pOperacao = '=') then
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
    if (pOperacao <> '=') and (valorIgual > 0) then
    begin
      if (pOperacao = '/') then
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
    if (operacao = ' ') then
    begin
      valor := pValor;
    end
    else if (operacao = '+') then
    begin
      valor := valor + pValor;
    end
    else if (operacao = '-') then
    begin
      valor := valor - pValor;
    end
    else if (operacao = 'X') then
    begin
      valor := valor * pValor;
    end
    else if (operacao = '/') then
    begin
      valor := valor / pValor;
    end;
    //
    if (pOperacao <> '=') then
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

function TCalculadora.getOperacao: String;
begin
  Result := operacao;
end;

function TCalculadora.getValor: Double;
begin
  Result := valor;
end;

function TCalculadora.ImpostoA(pValor: Double): Double;
begin
  Result := (pValor * (20/100)) - 500;
end;

function TCalculadora.ImpostoB(pValor: Double): Double;
begin
  Result := ImpostoA(pValor) - 15;
end;

function TCalculadora.ImpostoC(pValor: Double): Double;
begin
  Result := ImpostoA(pValor) + ImpostoB(pValor);
end;

procedure TCalculadora.Zerar;
begin
  valor := 0;
  valorIgual := 0;
  operacao := ' ';
  primeiraVez := true;
  limparVisor := true;
end;

end.
