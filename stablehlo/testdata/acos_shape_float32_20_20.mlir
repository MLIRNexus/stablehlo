// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.constant dense<-1.000000e+00> : tensor<f32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f32>) -> tensor<20x20xf32>
    %4 = stablehlo.compare  NE, %0, %3,  FLOAT : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %5 = stablehlo.multiply %0, %0 : tensor<20x20xf32>
    %6 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %7 = stablehlo.broadcast_in_dim %6, dims = [] : (tensor<f32>) -> tensor<20x20xf32>
    %8 = stablehlo.subtract %7, %5 : tensor<20x20xf32>
    %9 = stablehlo.sqrt %8 : tensor<20x20xf32>
    %10 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %11 = stablehlo.broadcast_in_dim %10, dims = [] : (tensor<f32>) -> tensor<20x20xf32>
    %12 = stablehlo.add %11, %0 : tensor<20x20xf32>
    %13 = stablehlo.atan2 %9, %12 : tensor<20x20xf32>
    %14 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [] : (tensor<f32>) -> tensor<20x20xf32>
    %16 = stablehlo.multiply %15, %13 : tensor<20x20xf32>
    %17 = stablehlo.constant dense<3.14159274> : tensor<f32>
    %18 = stablehlo.broadcast_in_dim %17, dims = [] : (tensor<f32>) -> tensor<20x20xf32>
    %19 = stablehlo.select %4, %16, %18 : tensor<20x20xi1>, tensor<20x20xf32>
    %20 = stablehlo.custom_call @check.eq(%19, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %20 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0xCC900240CE8B1340B9F657BFA3DBC240D98F324068F41EC0011A5B40135DA13E3B1CE440765C9ABF246A47C075EFAFC0778D07C09645063F89AA753FE2930BC1DB99853ECB991D40FA10D9BFEE431ABF9B18DEBF6608843FA13D79BE8926453E0C1117C01A4E40402C4D9B4017907140BAAF024137200540721A11409537153F4321EF3F62EC1FBF8BEA5D3E9E1C38C01DEEF1C0A2D9B9BF4290C6BE13AF233FDE3B523FA793803F8DF263BEA74639C09134BCBF9A88153FC1602DC0DF7DA7C07F13543FA0B6FFBF492ABB3FCAB611C0913693C02A8159C0679A26BFEC7A0540D0F8BFBFE2ACAD3D850A1F40DA8B11404F15B63F3F31403FE8A5C3C02A7C3F40C1713C401E834D40E4BC2EBF657825C0186D8A3F7D0AAEBFB3D55A3F65A475404356C4C078CCCDC090A31140833B3E3FB7C2E23F23B1BD40E85BCCBF1BBAC7BE9AF2B6BF20276BC05FBC16409FE7724055A67C3F4292FEBFE1599F402DD7A3BF1C2247C037A5194188AB233FBC318FC0B0D22D40D2DF784072D2934048D5A8BF27683FBDEB6131C08C534ABF3CAC3640B1ADA8408B8634C023132A405577093F195B32C0689ADC3FABAF72C060F145C0B0370741CAFC25C0B2727EBFF87F8B4048D088BF3551CF40A3EEE83E3C94A73F8275FFBF95ACDBBFBF80FA3F53EE2FC0143EC8C09572BFBF2CA6E03CA8082B3E52891AC0FBD5CABF104536C02CF5CF400772BB401AE112C01C9C2CBFEDBF13BE36975B407F43DCBFA22DB53EFDDDEF3F091A31402DAAC23F154C7F40B54AA0BDABB1CF3F9A7014404C46163FEEA738400B5741BDE5E1AABFCA9E233F64D177C0AF502A3FE7FA4B3F5069AC4077CB114044B2A4C09D55D0BF04605640ECEEF7BF33874F40B49E2C4047C0AABFCC2922C02C4F8A407540943F2682CC3FA96773C0F15405BE91FB84C0F6BF03C04E3042BF9E1FE13E6A9E373F3A977740F85D53C098A42E4034C239BE0F07ADBF5C7B76C06530953F1AC6F6BFE34CA9BF0F0DC9BF219541C02EE631C0CCD55540E40F02C0DBDD52BF58EB963F806075BE94EF4940DC8FFABF38DB49BF53A62BC03DF5DF40303E893FE8842BC00E1D02C088B116C02A219A404622AA3FD33D3E3ED3B69F402DB816BD75C5913FC57DFC3ED7C7613D678720C05E320F40D9C64CC0605BA0BFE11588C052A12DC01E1479BF37930EC020B025BFEB6925C05903CB3E2E5AFABF71444CBE02A70FBF36E70E40AE2E9D3FE503A3C02D9028BE35F741C003BC8B3FDB32E73E887F3E3EDA4F684030E92D3F8A0F56BF7BDCD63F7183AB3FE273B3C05A25B03DB756D43F24C6233DD0CB0DC041BFDDC0998607C080CF513F0368E93FC5C51DC0726C953E9A3681C0AA92B43FD3F1663F562B1040C18FC4C07730983E1CA5E8BE63F5A3C01700873FA20959C05BA67A3D768806C0A9449640A95F89401868193C727F0DC01810A440D6F96240E1C858BFEE042BBE51513AC0DF5C00C04EC06B4045878940C6E5A6C07309A4BDB6B40A3F3F76F6BE6B8465C0FC724AC0AC55FBC0A951A53FCD8E8B3F0D4304BE0EC1A040F650634062BE79C00C4A44C0715D9C3FA6C7F13ED3FBE2BFBAFC00404812D7BFE4D789403EB899BFB6D050C09FB223C05661AFC0EFE1753F2D4091C09DF6E93F45E7BDBFCE6680C046B78D3FA67D2D3E156CDABF9F9738C0517119C1E2C5993F387C67BF66059D3EC41D04C000587640D2B798BEEFD502BF7C1125BEB1A199BF450064C0118D893FC84596BF73B6B840AA5BE93F84DDC03F78F105C0031F12BF3C7D45BD838DECC01BF144C03CE8233FB59CA240FE2ECC40A1BC1DC01FF83DBFC26590BEB46419C0667DE13FA967C3BF0831E03FC43C87C0E3A094C0476FFB3F7E830BC0ED3A8A40F33A12C093F1E9BF58CD284012B9C8BF23890ABFC8B01AC064FD41BE32097DC0B521803FF34AF73FA9E964BF9D1846402E961D4054DB5340830DE03E25D4B8BFA5EF4AC033155DBECE4419C0E0BD9D40069B16C00B878C3FCD252F3F14A0E63E5968823EABE404401367A1BFF56E6040EF1C8D40E1458240FD30853F1ACA7940F30476C072EC86C056860D40134B1A3F5FD3A1C04E87414099E492403C3D59BF27080F3FB23BBC3FA1FC36BF0DED58405AD7043D1FAF1040FEBBD63FE42EC6C019CCA1407F42FC3F3A242340AFAAB8BF059A963F46AD22C07A2502BE9A7C3D3CA65C1140B4518940B496F63F7139EBBE2674C73E10B988BFCC673BC0E42E33C04316423F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x0000C0FF0000C0FFF2C824400000C0FF0000C0FF0000C0FF0000C0FF7E05A03F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFC263823FAFF8913E0000C0FF4245A73F0000C0FF0000C0FF58EC0D400000C0FF0000C0FF7C88E83F6643B03F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFC6D2723F0000C0FF00B70F40BE19AD3F0000C0FF0000C0FF0000C0FF310AFC3F1089603F15741B3F0000C0FFCCCBE53F0000C0FF0000C0FF016F723F0000C0FF0000C0FFDF31183F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF1BE211400000C0FF0000C0FFB531BE3F0000C0FF0000C0FF0000C0FF9CBA383F0000C0FF0000C0FF0000C0FF0000C0FFC99C14400000C0FF0000C0FF0000C0FF88AB0B3F0000C0FF0000C0FF0000C0FF0000C0FF38AD3B3F0000C0FF0000C0FF0000C0FF045BFC3F0000C0FF0000C0FF0000C0FF0000C0FF01D9253E0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFAD8D603F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFAA0BCF3F0000C0FFA4DB1E400000C0FF0000C0FF0000C0FF0000C0FF5381803F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFDB0242400000C0FF0000C0FF0000C0FF299B8C3F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF258DC53F0095B33F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF67E313406898DB3F0000C0FF0000C0FFB4C39A3F0000C0FF0000C0FF0000C0FF0000C0FF2617D33F0000C0FF0000C0FFFE84713F0000C0FF261BCF3F0000C0FF3E9E603F0000C0FFE6C8573F1519263F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF9FC6D93F0000C0FF0000C0FFEFA31B40F3C98E3FDB5B453F0000C0FF0000C0FF0000C0FF3969E03F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF087A22400000C0FF1209E83F0000C0FF0000C0FFA2AA1E400000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF8D24B13F0000C0FFE2C5CD3F0000C0FF480D873FB100C23F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF54253A400000C0FF1F9511400000C0FFF2DF943F0000C0FF8EC4E23FF1A80A400000C0FF0000C0FF0000C0FF893ADE3F0000C0FF0000C0FFA0178D3F311CB13F0000C0FF5BED523F87E823400000C0FF0000C0FF0000C0FF080ABE3F0000C0FF50F1C33F0000C0FF0000C0FF0000C0FF9B311C3F0000C0FF0000C0FF8227A33F0000C0FF0000C0FF016AE43E0000C0FF0000C0FF496EA23FF4B702400000C0FF0000C0FF0000C0FF6739C13F0000C0FF0000C0FF0000C0FF09DDC73F0000C0FF0000C0FF0000C0FF412B25403D8ADE3F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF4253D33FBC897F3F45AC04400000C0FF0000C0FF0000C0FF0000C0FF0000C0FF18A4D93F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF111C8A3F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFB56C903E0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF3D45B33F0000C0FF0000C0FF0000C0FF0000C0FF35D32C40E829A13F0000C0FF0000C0FFDFD4EF3FEADC064030C9DD3F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF98680B40623CCF3F0000C0FF0000C0FFB03E603F0000C0FF0000C0FF0000C0FF650B1A4069A8ED3F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF762009400000C0FF4575E13F0000C0FF0000C0FF0000C0FFC85A2B400000C0FF0000C0FF0000C0FF34168F3F0000C0FF0000C0FFA7EAE43F0000C0FF0000C0FF0000C0FF0000C0FF933C513FBD408D3FCA18A83F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF17856C3F0000C0FF0000C0FF0000C0FF17622540635B7A3F0000C0FFF47E17400000C0FFF0E8C43F0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FFD55FD93FDF94C73F0000C0FF0000C0FF0000C0FFBF140340AFD7953F0000C0FF0000C0FF0000C0FFA3D7353F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}
