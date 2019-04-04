object FrmEntidadesDeCalculo: TFrmEntidadesDeCalculo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Entidades de C'#225'lculo'
  ClientHeight = 437
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnAnterior: TSpeedButton
    Left = 8
    Top = 401
    Width = 23
    Height = 22
    Caption = '<'
    OnClick = btnAnteriorClick
  end
  object btnProximo: TSpeedButton
    Left = 410
    Top = 401
    Width = 23
    Height = 22
    Caption = '>'
    OnClick = btnProximoClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 425
    Height = 89
    Caption = ' Funcion'#225'rio: '
    TabOrder = 0
    object Label1: TLabel
      Left = 43
      Top = 27
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object Label2: TLabel
      Left = 43
      Top = 54
      Width = 23
      Height = 13
      Caption = 'CPF:'
    end
    object Label3: TLabel
      Left = 207
      Top = 54
      Width = 52
      Height = 13
      Caption = 'Sal'#225'rio: R$'
    end
    object edtNomeFuncionario: TEdit
      Left = 80
      Top = 24
      Width = 305
      Height = 21
      MaxLength = 50
      TabOrder = 0
      OnChange = edtNomeFuncionarioChange
    end
    object edtCPFFuncionario: TEdit
      Left = 80
      Top = 51
      Width = 105
      Height = 21
      MaxLength = 14
      TabOrder = 1
      OnChange = edtCPFFuncionarioChange
      OnKeyPress = edtCPFFuncionarioKeyPress
    end
    object edtSalarioFuncionario: TEdit
      Left = 264
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 2
      OnChange = edtSalarioFuncionarioChange
      OnKeyPress = edtSalarioFuncionarioKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 103
    Width = 425
    Height = 226
    Caption = ' Dependentes: '
    TabOrder = 1
    object Label4: TLabel
      Left = 43
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object sgDependente: TStringGrid
      Left = 9
      Top = 94
      Width = 406
      Height = 120
      TabStop = False
      ColCount = 3
      FixedCols = 0
      RowCount = 2
      ScrollBars = ssVertical
      TabOrder = 0
      OnSelectCell = sgDependenteSelectCell
      ColWidths = (
        224
        75
        75)
    end
    object edtNomeDependente: TEdit
      Left = 80
      Top = 29
      Width = 177
      Height = 21
      MaxLength = 50
      TabOrder = 1
    end
    object chkIRDependente: TCheckBox
      Left = 264
      Top = 32
      Width = 31
      Height = 17
      Caption = 'IR'
      TabOrder = 2
    end
    object chkINSSDependente: TCheckBox
      Left = 301
      Top = 33
      Width = 44
      Height = 17
      Caption = 'INSS'
      TabOrder = 3
    end
    object btnAdicionar: TButton
      Left = 78
      Top = 60
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 4
      OnClick = btnAdicionarClick
    end
    object btnAlterar: TButton
      Left = 159
      Top = 60
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 5
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 240
      Top = 60
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 6
      OnClick = btnExcluirClick
    end
  end
  object btnGravar: TButton
    Left = 64
    Top = 401
    Width = 153
    Height = 25
    Caption = 'Gravar Altera'#231#245'es'
    TabOrder = 2
    OnClick = btnGravarClick
  end
  object btnCancelar: TButton
    Left = 231
    Top = 401
    Width = 153
    Height = 25
    Caption = 'Reverter Altera'#231#245'es'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 335
    Width = 425
    Height = 60
    TabOrder = 4
    object Label5: TLabel
      Left = 13
      Top = 9
      Width = 121
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Valor IR'
    end
    object Label6: TLabel
      Left = 147
      Top = 9
      Width = 121
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Valor INSS'
    end
    object Label7: TLabel
      Left = 289
      Top = 9
      Width = 121
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sal'#225'rio com Descontos'
    end
    object edtValorIR: TEdit
      Left = 13
      Top = 28
      Width = 121
      Height = 21
      Alignment = taCenter
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
    end
    object edtValorINSS: TEdit
      Left = 147
      Top = 28
      Width = 121
      Height = 21
      Alignment = taCenter
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
    end
    object edtSalarioComDescontos: TEdit
      Left = 289
      Top = 28
      Width = 121
      Height = 21
      Alignment = taCenter
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
    end
  end
end
