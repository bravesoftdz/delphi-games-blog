object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ASCII Converter - DelphiGames Blog'
  ClientHeight = 451
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 391
    Width = 611
    Height = 60
    Align = alBottom
    TabOrder = 0
    object imgShades: TImage
      Left = 3
      Top = 4
      Width = 36
      Height = 32
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 611
    Height = 37
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 635
    object Button1: TButton
      Left = 156
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Convert'
      TabOrder = 0
      OnClick = Button1Click
    end
    object cbxFont: TComboBox
      Left = 5
      Top = 9
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Terminal'
      OnChange = cbxFontChange
      Items.Strings = (
        'Terminal'
        'Consolas'
        'Courrier')
    end
    object ckbInvert: TCheckBox
      Left = 237
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Inverter'
      TabOrder = 2
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 37
    Width = 611
    Height = 354
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 635
    ExplicitHeight = 371
    object TabSheet1: TTabSheet
      Caption = 'Texto'
      ExplicitWidth = 627
      ExplicitHeight = 343
      object memOut: TMemo
        Left = 0
        Top = 0
        Width = 603
        Height = 326
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        ExplicitWidth = 627
        ExplicitHeight = 343
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Imagem'
      ImageIndex = 1
      ExplicitWidth = 627
      ExplicitHeight = 343
      object imgOrigem: TImage
        Left = 0
        Top = 0
        Width = 603
        Height = 326
        Cursor = crHandPoint
        Align = alClient
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
          001008060000001FF3FF61000000097048597300000B1300000B1301009A9C18
          000009D46943435050686F746F73686F70204943432070726F66696C65000078
          DAED987B705C7515C73FBB699A264D4B29B19442CB65A925A0D957DE314D4936
          34AD343426A14DA23C6EEEFE7673E9EEDEEBBD77B309450414060707F101A382
          534554945144D0415486117C200C96820CAF412D4506794365D4C1A97FDCBBBB
          77B39B64A9A5A8D3CD4CE6CEEF711EDFDFF9FDCEF71C38657F424D695E099229
          CB18ECEB914646C7A4AAA7A96215951CC5625931F5FEA18DC394FE79E0ADC7F0
          003CD230C7BAD97E3551612AC0DBE0B958D10D0BBC1701A18CA55BE0FD215067
          8C8C8E81F73EA02E6E7F3F0ED48DDBDF2F0175C6F060042A006F6D7C78300295
          B5E0AD1D1F1E8C40D54AF0D6F60F058350BD16D6EC76F4028C98837D3D525435
          F5843C2DE98616531342CAA8D6446E704236A219D91092A2A5626A3C6DC896AA
          A5A4A86CC9525418EAA4884A31434B4A8A9C50C7ED59D0AD9E4160375B91D011
          18C4504920114546423085CA382ACFF32C1A122683F4D18384824612090DD359
          1FCD7D0B673E450C9538690CE49C0C7B7E0219832819640CC41C3A5F70F618A8
          4C3A7AB2AB156412A88C6320134790E450FC544B4C5900114D9F36D4F88425D5
          2BA74AE160B049EA57154333B59825453443D7B268C2C8E898646F7F73180FE0
          59717F7E4CDB096DF74285951F53A6E0CE4760C565F9B193F7C1D20BE0A72D4A
          DA98CC8531D4514F27032864B88A5DDCCE6F78C9E3F5ACF2347AFA3DAAE70ACF
          4D9E7B3DFBBC0BBDA77ACFF25ADE1BBCBFF2BE5A717CC5A68A4CC5772A9E5850
          BBA07BC1D4825B17BC50B9B652AEDC55F9C785D24265E1CD0B5FA96AA9BAA4EA
          81452B17C517DD595D537D6EF51D358B6B44CD3D8B572FDEB9F8E9DAAEDA1B97
          2C5AA22F7972E9C6A5B71FE53BEA4BCBAA965DB4ECCDA313473FBF3CBA7CEF31
          CA317FA9DB51F7FAFB2E5C51B9E20BC74AC7DEB6B277E513C7E9ABAA57DD747C
          CFF17F3EE1B2D5EB563FB0C63C71F589F74B9993EA4F7AD2F7B993379E7C60ED
          5DEF9F5AD7BAEE1FA7FCA2FED3A76E39EDD8D3F67DE08E0F5EDE30EA0F041605
          F606EF09ED0A5FDA289ACE6C6E6C59D35ADBFA76DB2BED7B3B9EF8D09ECE87D6
          3FD0F5E086DF9FFE68F7533DCF45DE38C3B37179DFBA4D9D9BCFFEB07EE6D55B
          7ED0FFF0596F0DACFE48DFA035F4CDE13F6CABDE7EFAC8F4E88FC7F67FACE99C
          A973EF3EBF4A1E1CFFBAF29A88C4BE127F5DDD72C1F71235C9646A8FDEF1F16F
          99CBADCBD27FCB5C30F5EC85E7EC7CEA131FBDF8994B944B5FFCD4E4E50BAEB8
          F6CAFACFDC7DD5B6CFBE71F535D7843EFFE817775EBBF6BADD5FFEE45783D73F
          F7B51B766DFBC63137EEB9E9DA6F8FDDECFBEECBB7FCECFB57DD7ADE6DCDB72F
          BDE3AF3FB9FFCE5BEEBAE6E799BBC7EFD9FACB0DF7857F5DFFDB937EB7FAC113
          1E5AB3DBB7E7B4479B1FEB797CE8C9D8D3173D73DD9F7EB4F7E17DFB9F3FEE85
          EE17132F5FFFEA836FB0BFED2DE3EFB7FEF3B57F351E983E70E0482C1C898523
          B170241666C642FF5028E8E42C09969D0ECBCE8745F5B0F24A58B8A9930D4C91
          2481C424020313158D14EBF111C24F101F1282140A1A515452C4598F8F341631
          1A08D1828F0D74B1841A3A518892A483081A09340C7A114CA2A220E847238A20
          81E4684E61D2E1EC5A8F8F092C2C743A0810C0446102411219133F4954140C34
          4C346258F81DB21120834A8A281A194C02840912A4990041C20450721605E6B5
          CE57649F4CE25DB1AF9500214245F6B9A98BE59CCA4CAB3228988711B5ED2898
          44D048924423C500069A430C05C34CA323308B2C4DA29461A7868E20E5EC8CA1
          619044C672660DE204482263B083343A0D8E1FBA83D2382A09542CA673BEB4E0
          73A2B3DA159F85969F854C12915B574DA7836E07C308A6B0721E759040CEDD03
          1D8B067A18C44717036511E542621A45A3934091BEBCCD8132ADCE7BD78BC044
          C14045CFC5CF7FEADDFF5729502EE6736399C7BC9B3416136818FF31D285F7BF
          1091081A06C2C15043621B2F1345B8FCED2FBAF1E57A5BCA8BBC8FFD08644CD2
          18089208525844D0481145CDA1631620509C1386D0915110741161336730C228
          630596945E5D2C753B13A8580806D0504961B96E462F2D3417C89D7B7D3122EF
          DCE7BC6D430812C4D8429A242A2934D298746161904614689A7D75F139C84CB9
          10924961D1E5E4EC42EB4BAF2C96A8922AB12E584262E9953325DA2FC036540C
          2CD2C8240AB26DA9B32C8D752F32163212C3A824110C61219344673D3EC20409
          11A68120AD3410A685618234D341C8F91F726581EA32B03C1B1341F41D609ADF
          515A4B29D4F27BCAC5796E2DEED836509D5C398DC408EBF1D14E337E8234E343
          62D4E1794147BBCDF6C672A36DF86927888FC02CFA06114467D1D544083F619A
          5CBAC2CE584B81263FED34CEA1A50F038170F846B1A6469AF1D3EA48B535B512
          C24F33E1024DB6AEF01CBA7A48909E15BF106D45F8B5E2275CA0C78DF25C7A64
          1476CCA229E8D2E03E97E09C38C9244922B39518314C04167DC8A8A4D8824A0A
          818C911B935C7BECF3F13BE7E59660EBB53DB23DCFEECFCEB4D3442B6DB4D08A
          0FA9A42E1BBF70EE0424869DA8365DAF68FE4DCE6B6D224853119AF3BFD1D977
          A3D4AB5EEEEBE4CE5EA53879E12B2693A0836EA2C8E85808C77F1BE14811D729
          96E29633808CE16426CB613617228812218DC124A220D316F20DFB6E0E3348A4
          E89C43F809D14E334D25CF34E4BC07D9BF991111729DCECC7874DB90BFB9EFAD
          1DD95B7DF8ADB063EEE0CED3BDF7E063AA9053CD1EC3A5B957E9FA38BBA39CFE
          81BB3720CF90DE8D8EEEBC1332A9A21EC1667A0F637D6B7345BF63A75EB20BF0
          DE7429E6C6E97FB72F3055D2CE0C1932F8C9D0E8AAFB6D0B420418A19F2D0CB9
          BC69402585899543A7B0E6970F69CD2F48D1C0D90CE1A38BED441842422F902E
          39FD0B772D3C898A70908DE76ADFC21A62FE3A4D2EB313201FD24E40A1CFBD08
          62C8A44960CDE1BB5CE0BF1D1B2A96336B3390ECA9459D4AFFD0E2347FF52E1F
          82EABD109DE2EA3B5BB5EB0E93CFDA51AE17B355E5F6ECB602BCE6AFC6E57758
          37CB65D7CD6EF93D0EBF8D63A0912645D4C5A3DB73DDE5D15C0DE72F60BA76AD
          D04A5B11EFCB6A18228DE192DE45B79387EC1E8FDBFAE2B5C5F2F27577F615D9
          4ACC95796D7C37A2224838B5618BAB6E3B5829C596F422883BDCA970B73B6B87
          8A227DFE3DC5B1556EF4B8F7949B990E8E27C449BAEA993416FDC8E8EF2133E8
          47104545660895247EC7C6628E608F1F3ECB66C7E8082B989B1564A3ECDD6105
          B6545BAE9DC51A903051499226818C85404247767AEA0192B928935C48CE9723
          CAF323EFEFBBC308EC77C04043C740CDF99765029B89104142661C138D046967
          45DE53D5A98C0C5414240C04A95C4FDF46D1CE3B767D2F9141C3600731124E4C
          968BD67CBC20BBEEBF9317CC655DE149E7595A0F32268284D39B99FDE5E86213
          03B9FE632FE7D13DE3D4662279705AB25965FEF7DE5EFB6F3B2D01081B438E37
          000000904944415478DA63FCFFFF3F03258011644052D5DAFFB71EBC2149A39A
          8208C3BCB66046B001365133C972C69165E9C419A02A2FCCD05DE6C92022C80D
          E603D59366C086A93170CD6419005488A291642F906D004C233A20DA0B20BF83
          00CCFF6FDE7F05D301D94B864A18106D805BF2FCFF1A4A62380D9854ED0DA6F3
          5AB7C2C56EDC7BC5B06B6E22950CA03833510200F77497E1A948624D00000000
          49454E44AE426082}
        OnDblClick = imgOrigemDblClick
        ExplicitLeft = 120
        ExplicitTop = 80
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 560
    Top = 408
  end
end
