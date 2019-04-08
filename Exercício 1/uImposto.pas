unit uImposto;

interface

type TImposto = class
  private
    FValorBruto: Double;
    FValorImposto: Double;
  public
    property ValorBruto: Double read FValorBruto write FValorBruto;
    property ValorImposto: Double read FValorImposto;
    function calcImpostoA: Double; virtual; abstract;
  end;

type TImposto2 = class(TImposto)
  public
    constructor Create();
    function calcImpostoA: Double;
    function calcImpostoB: Double;
  end;

  type TImpostoExt = class(TImposto2)
  public
    function calcImpostoA(pValor :Double) :Double; overload;
    function calcImpostoB: Double; overload;
    function calcImpostoB(pValor :Double): Double; overload;
    function calcImpostoC: Double; overload;
    function calcImpostoC(pValor :Double): Double; overload;
  end;

implementation

{ TImposto2 }

function TImposto2.calcImpostoA: Double;
begin
  FValorImposto := (ValorBruto * (20/100)) - 500;
  Result := FValorImposto;
end;

function TImposto2.calcImpostoB: Double;
begin
  Result := 0
end;

constructor TImposto2.Create;
begin
  FValorBruto := 0;
  FValorImposto := 0;
end;

{ TImpostoExt }

function TImpostoExt.calcImpostoA(pValor: Double): Double;
begin
  FValorBruto := pValor;
  Result := calcImpostoA;
end;

function TImpostoExt.calcImpostoB: Double;
begin
  Result := calcImpostoA(FValorBruto) - 15;
end;

function TImpostoExt.calcImpostoB(pValor: Double): Double;
begin
  FValorBruto := pValor;
  Result := calcImpostoB;
end;

function TImpostoExt.calcImpostoC: Double;
begin
  Result := calcImpostoA(FValorBruto) + calcImpostoB(FValorBruto);
end;

function TImpostoExt.calcImpostoC(pValor: Double): Double;
begin
  FValorBruto := pValor;
  Result := calcImpostoC;
end;

end.
