unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, uEntidades, Vcl.Dialogs, Vcl.Forms;

type TQryRegistro = (Atual=0, Proximo=1, Anterior=2);

type
  TDM = class(TDataModule)
    DB_Exercicio2: TFDConnection;
    TR_Exercicio2: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure getDBFuncionario(pFuncionario :TFuncionario; pRegistro :TQryRegistro = Atual);
    procedure gravaDBFuncionario(pFuncionario :TFuncionario);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  DB_Exercicio2.Close;
  DB_Exercicio2.Params.Database := ExtractFilePath(Application.ExeName)+'EXERCICIO2.FDB';
  DB_Exercicio2.Open;
end;

procedure TDM.getDBFuncionario(pFuncionario :TFuncionario; pRegistro :TQryRegistro = Atual);
var
  qry :TFDQuery;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := DM.DB_Exercicio2;
  qry.Transaction := DM.TR_Exercicio2;
  //
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT ID, NOME, CPF, SALARIO FROM FUNCIONARIO ORDER BY ID');
  qry.OpenOrExecute;
  if (qry.IsEmpty) then
  begin
    pFuncionario.limparDados;
  end
  else
  begin
    qry.First;
    if (pFuncionario.ID > 0) then
    begin
      if (qry.Locate('ID', pFuncionario.ID)) then
      begin
        if (pRegistro = Proximo) then
        begin
          qry.Next;
          if (qry.Eof) then
          begin
            pFuncionario.limparDados;
            Exit;
          end;
        end
        else if (pRegistro = Anterior) then
        begin
          qry.Prior;
        end;
      end
      else
      begin
        qry.First;
      end;
    end;
    pFuncionario.limparDados;
    pFuncionario.ID := qry.FieldByName('ID').AsInteger;
    pFuncionario.Nome := qry.FieldByName('NOME').AsString;
    pFuncionario.CPF := qry.FieldByName('CPF').AsString;
    pFuncionario.Salario := qry.FieldByName('SALARIO').AsFloat;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID_FUNCIONARIO, ID_DEPENDENTE, NOME, IS_CALCULA_IR, ');
    qry.SQL.Add('       IS_CALCULA_INSS FROM DEPENDENTE ');
    qry.SQL.Add('WHERE (ID_FUNCIONARIO = :ID) ');
    qry.SQL.Add('ORDER BY ID_DEPENDENTE');
    qry.ParamByName('ID').AsInteger := pFuncionario.ID;
    qry.OpenOrExecute;
    if (not(qry.IsEmpty)) then
    begin
      qry.First;
      while (not(qry.Eof)) do
      begin
        pFuncionario.adicionarDependente(qry.FieldByName('NOME').AsString,
                                         qry.FieldByName('IS_CALCULA_IR').AsString='S',
                                         qry.FieldByName('IS_CALCULA_INSS').AsString='S');
        qry.Next;
      end;
    end;
  end;
end;


procedure TDM.gravaDBFuncionario(pFuncionario: TFuncionario);
var
  qry :TFDQuery;
  i :Integer;
begin
  qry := TFDQuery.Create(self);
  qry.Connection := DM.DB_Exercicio2;
  qry.Transaction := DM.TR_Exercicio2;
  //
  try
    if (pFuncionario.ID <= 0) then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT GEN_ID(GENFUNCIONARIO,1) AS ID FROM RDB$DATABASE');
      qry.OpenOrExecute;
      pFuncionario.ID := qry.FieldByName('ID').AsInteger;
    end;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE OR INSERT INTO FUNCIONARIO (ID, NOME, CPF, SALARIO) ');
    qry.SQL.Add('VALUES (:ID, :NOME, :CPF, :SALARIO) ');
    qry.SQL.Add('MATCHING (ID) ');
    qry.ParamByName('ID').AsInteger := pFuncionario.ID;
    qry.ParamByName('NOME').AsString := pFuncionario.Nome;
    qry.ParamByName('CPF').AsString := pFuncionario.CPF;
    qry.ParamByName('SALARIO').AsFloat := pFuncionario.Salario;
    qry.ExecSQL;
    qry.Transaction.Commit;
    //
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM DEPENDENTE ');
    qry.SQL.Add('WHERE (ID_FUNCIONARIO = :ID) ');
    qry.ParamByName('ID').AsInteger := pFuncionario.ID;
    qry.ExecSQL;
    for i := 0 to pFuncionario.ListaDependente.Count-1 do
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO DEPENDENTE (ID_FUNCIONARIO, ID_DEPENDENTE, NOME, ');
      qry.SQL.Add('                        IS_CALCULA_IR, IS_CALCULA_INSS) ');
      qry.SQL.Add('VALUES (:ID_FUNCIONARIO, :ID_DEPENDENTE, :NOME, ');
      qry.SQL.Add('        :IS_CALCULA_IR, :IS_CALCULA_INSS) ');
      qry.ParamByName('ID_FUNCIONARIO').AsInteger := pFuncionario.ID;
      qry.ParamByName('ID_DEPENDENTE').AsInteger := i+1;
      qry.ParamByName('NOME').AsString := pFuncionario.ListaDependente[i].Nome;
      if (pFuncionario.ListaDependente[i].IsCalculaIR) then
      begin
        qry.ParamByName('IS_CALCULA_IR').AsString := 'S';
      end
      else
      begin
        qry.ParamByName('IS_CALCULA_IR').AsString := 'N';
      end;
      if (pFuncionario.ListaDependente[i].IsCalculaINSS) then
      begin
        qry.ParamByName('IS_CALCULA_INSS').AsString := 'S';
      end
      else
      begin
        qry.ParamByName('IS_CALCULA_INSS').AsString := 'N';
      end;
      qry.ExecSQL;
    end;
    qry.Transaction.Commit;
    MessageDlg('Registro gravado com sucesso.', mtInformation, [mbOk], 0);
  except on e: Exception do
    begin
      MessageDlg('Ocorreu um erro durante a grava��o do registro.'#13 +
                 e.Message, mtError, [mbOk], 0);
      qry.Transaction.Rollback;
    end;
  end;
end;

end.
