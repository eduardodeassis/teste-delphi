object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 182
  Width = 206
  object DB_Exercicio2: TFDConnection
    Params.Strings = (
      
        'Database=D:\Eduardo\Curriculos\Testes\Theos\Exerc'#237'cio 2\DB\EXERC' +
        'ICIO2.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object TR_Exercicio2: TFDTransaction
    Options.AutoStop = False
    Connection = DB_Exercicio2
    Left = 120
    Top = 16
  end
end
