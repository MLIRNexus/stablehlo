// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xf32>
    %1 = call @expected() : () -> tensor<20x30xf32>
    %2 = call @integer_pow(%0) : (tensor<20x30xf32>) -> tensor<20x30xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x30xf32>, tensor<20x30xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xf32> {
    %0 = stablehlo.constant dense<"0x2FEE0A40E21013C0425F5FBFF5DD3FC048EF204026B6E23FAD9BBD40FCA618C0EA9E30C04F51BBC00CF3083D033FDB40F2D92340E6211540A7E112C055F95C3D4C4A4CC0E3316B3F13EAC3BFEA853F4089850840AEF09FC0B8FA08C0793C3EC0E67400C0B3F2AC3C0C6642408B3D3D3F22459A40BDD31840C3F0F23F81C3AC40ECB655C0EB8363408A95F23FD79943C02D610BC07E92C0BF9BEE3C40AB18BBBE362EC6BF1233E03F1E7DCABF19B7663FC59CAD40DD6034BF9E9E0B4113D7EEBFD6ED33C02FDA4FC09DB2273F56B5CDBF377E254013D89DB94ED2663F0D75BAC0AA5954C0E8C2D83E888899BE90EE6840FD8510405968A63D04746C3F1A4532C0BF213DBF190C5DBE7C5D504048B02E3F424B6DC0B1039CBF57F1544058AC5040EA78CDC04EEFA0BE2B2DA13F89CC6EBFB0973A407A878B40547012BF61254FC0672B8A406D80E93F503C3840FDCB283D8AF11CBFE8A1F6BE6261D7BEEB21923FA6E7473F8B4995C0D0A2D5BFD0E851C09B4E8B40EEECACBFC58A4FC0758DF0BEAD34E5BE2CC28EC08C7FCB406E3155C092FB0D4036DECB3F21BB143F94471AC0057BDC401766A3406037EDBF55B696BEAA20034061D7DF40573289BF824865BF05B59640AD1588BF238B47C099B5973E91C8A3C0653A11BBD812913E26387EBFF65D543C6A97A83E88B4DE3FFF1C48C0F1536E3F1FC728C074795A3F36D216404208A0C09362773D9CD48A3F93C78B3E511DBD3F65DA62C09179B8BFAFEA1EC008C32C403A56C8400577D840004AC5BF999EACBFD32905408C38283F510C5FBE8E128740B5657DC067B91CBF67FC8CC01563BF3E64193DC05F687CC022018A407F5644C0F2BAA13FEE64CD3F3D7688BFBBA2833F6BF06AC0A036003F174E7EBFF12C4AC033ACE3BF1A81304080A1883F7C5A82BFD78B02C1D2DE6DC0DC1BB8BF765746C01085EABF05F3A4BEA20E35C017C2DCC0C00FB3C0334010C0E62AA4C0DD3F0940D00CD03F4313FCBD2897A13F90868BC0B1311FC08524F8BF68EADE3EDFD6C43F4A6530C099E1A8BF4BB88FC0FD9E67C062B38D3E72C4454059314EC01AAAA3BBD806A7C0008B23C0515BA83FF1DF05C04AF0C63E14A9B0BF8E7F83BF69D22A3F93E63D40B5FE4BC0059C6140696D5B40F15341C015208F3E5BE84EBFF7B24A3FF57FD3BFAEBBDF3D800C99407A2FE4BF2A13A4C06C06874038785BBF921A0D3F30E2D6C0654F1FC00C0D1740D9BCBABFD31A95C0855AADBFCFE686C098CF983F7560B7BF3EE6B4BF933D5240BCB986BE7CF754C025DC32C0131C0CC099CFE6BF0EED5DC0BC5CC3C0B8D39DBFCA6F8040C939E3BEF3F2A6BF07DCC8BFC54081407B59013E08217440E99739C090E981BFDB47FA3C401E30C066E5C7BF51C659BF6E32863FD98C6D3E25C4D0BED02B773E53E8E23F11B0E1C0F4C49C40D76A1940E669A83FF2269F3F4B15DD3F0B3694BF63E20740F23F8B3F16BC8F40E33994BCBE456D3F7A3649C073470CC0EA8FBF4002E088C07792174055F804407C687AC078644840B7D85540A5F89DBF94B84B3F740B8EBE44525B40AEF743BF8A76A4C069247C40CD71EBBF848C9C3DE58173BFBDCB5B403A8E663F2A0A6EBF6962E6BF2E9212405DCF79C09FCD2340E56A1E3F42742EC015707AC09D618D405758583F82B7EBBD67498F3F7F569B3EC03C2440F816D4C02D5C58BF77554040A1397DC0E6C794BE7C2C5D3F0CC8ECC0264E933F1DF6E13E3CCBE9BE71C5504031BA42C0E52A3E407EAB403FF2A25FC0058446C06D20E93F7827FDBFE5E9694052823AC05C22C0BF2D9F21405B4299BF8BFB6640C5007F402551CD3FA80398BF89C9493F9045C93CFA0C504042C94A3FBD516540619216C04DC3164033152AC0BD1D01BF64749BBE96C516C063D171BFD7C071C0B434603E06F60AC02F0835C02B1CC03F1DA50B40BB311640DA25594043FB9C40FE4087BFEB67223ED7CBE04023DD2940FDC780BF2F113840541D30402513923FE0770DBE36A0D2C057E5F73F647400406CF9B83FA62EDA3FDF406BC01DAA254093A0983F0D15D440A949004022FF593EF7562ABFC07A913DC5FF29C0526112C0885757C0BDB3D4BE8C0F4BC0A3E4E73FE8B279BFC647373F9F53EC40C92D8DC089958B3F0E12983E2F672E40FFD9A540755ABD403F47E7BFF353AC3F514885BF4C6EDFBFDE2D044093F705C0A38E89BDBC301E408A2AC9BF629DD83FC1430B3F1F37B1407353FEBDD8E31FBFB0B50C4056BD50BF1F46124020F1713FD7B89BC0D90E8DBF8194653F7B66DB3F03EE0640400033C09406CDBF2E9C8540D8E82D40A9A512C0543E6CBE6A7F70BECBA02F40D0F233C0C5C28C4096D721401F0625BE2B1243C0207DA540168CBC3ED71F67BFF4E8A640CA446CC08AF06940BFBBB2BF57CD44C0D51F3340F3409640C25A37C0B5BF5840D4162FC0F8C34A4069F33A3F5A3E7D40A80813C010D6CEBFFBE53F4033241E3D0CD1F4BF34541F3EE2BE9BC05C00F53F312A02C021D3D03FAC4A07C0D569933DD1257ABF41D5A9C03D6505C00B05353F40DD2C40706CBC3E5A9CB93F694F1DBF31E98CBF4A9E2BBD103245BF473B173F77625ABFBEC285BF29DD01C0DC618A3F93B5593F6902B6BF8380233E672BCF3F08BDCEBFB5317A40B689C5407EBA63C0E338D8BFE5149A3FADEA183E8F490EC01FA5174083FC8C3F80DFAEC0302F7C400D7DFDBEB97CCABF8F43883FFFC6B2C000CD15C0697D01C0EEB076BFF89FA73F205635C0EB274CC068A5F3BFF4D8893FF11E35C0BEFF6BBFB630B8C0B4478EC04506A43FB0BFA63F9175DFBFAFF2983F7905BEBE8B7188BEBC40EF3E40EE42BF4D3D9D3DD9DFD53EA76D3D400F94CABF36446DBDB26056BF714951BF42AE2440F62E894077AC3AC05BB0AB3FD1F0A0C0DD7706416613ECBFF4E332C014FB0FBF0FDBDD3F065CD640ECC71E408A2447C0FB9B2FC0CB53B940A7EDB13F4A08D74059A3E9BF426753400ECCA33ED5DCC940F3891740CB93B43E4A9DA4BFC728F2C099A40740FB6DF5BFD9E085BD9A4EA9BF245773C0CFDDF4BFEA463E406B50D63FA04D2CBFB7B4F4C0ECB0E33F2BB3A0C08643D1BFAB322C4043FF6240D49A783FD7049F3F14E24EC08545AC4033C16B40A441CEC0D16353C04BDAD73FAE72203F2D0E66406EE5793FE11CAB3F377E7D3F1E7A3C40C18CBBBF53BF6A400D7A714056FB84BF87BC94BFA7E830C0C1385F4092F412C075FA38C00D5722C0C5E3BFC0B2314AC0F85A594055ED02C06D3CE43F8E764C40FCFE9040BED66E3F3CF10DC0F30BF040A050B9408F792D40FEB4D53F1DC3583FADDD63BDA7C131BFB41556403FF3ECBE1BDC92C096F849C0E96EB73F2B2E2BC0D88CA0C0"> : tensor<20x30xf32>
    return %0 : tensor<20x30xf32>
  }
  func.func private @expected() -> tensor<20x30xf32> {
    %0 = stablehlo.constant dense<"0x0000807F000080FFD2C301B3000080FF0000807FBE95D5730000807F000080FF000080FF000080FF000000000000807F0000807F0000807F000080FF00000000000080FF383CB13758E47DE60000807F0000807F000080FF000080FF000080FFFC3249FF000000000000807FC025C7230000807F0000807FDEA2297A0000807F000080FF0000807F25C90C7A000080FF000080FFC169E4E40000807F000000808EBC88E7EF87CF72433383E9639DF6350000807FCCBB669F0000807FBF399CF8000080FF000080FF5B4FB4180432F3EA0000807F00000080FBBB0236000080FF000080FF00000000000000800000807F0000807F000000009D822E38000080FFC625B9A3000000800000807F7B097C1C000080FF469999D10000807F0000807F000080FF00000080EED29554A8D718B90000807F0000807F00E8498C000080FF0000807F579A8D760000807F00000000DF3EA39200000080000000803BC39A4BB870CD28000080FF146C67EE000080FF0000807F49FE0ADB000080FF0000008000000080000080FF0000807F000080FF0000807F3A5B1B6AA66EB50D000080FF0000807F0000807FFB5F03F8000000800000807F0000807FB8CCD1C59AB05FB50000807FEA4515C5000080FF00000000000080FF00000080000000000F00D3BE000000000000000067873172000080FF38E2ED38000080FFF79AF8300000807F000080FF00000000A2E3EB460000000045023763000080FF67CCF9E0000080FF0000807F0000807F0000807FAE421AE7BBFEDDDA0000807F55E70519000000800000807F000080FFB0AF8892000080FF00000000000080FF000080FF0000807F000080FFBE9EE754754CC86A632754C5BD3A0C42000080FF000000008D3ADCBE000080FFD5C136F40000807F4143784583D021C1000080FF000080FF291BC2E0000080FF990EF6F600000080000080FF000080FF000080FF000080FF000080FF0000807FDFFCFF6B000000803987CF54000080FF000080FF27501CFC0000000065E5E666000080FFAB3BDCD8000080FF000080FF000000000000807F000080FF00000080000080FF000080FF615B9458000080FF00000000820F03DD0A9FF5C149F96A1A0000807F000080FF0000807F0000807F000080FF000000009C6BFEAB50B1152A422B81ED000000000000807F6B3373F4000080FF0000807FEB625DB153FAE708000080FF000080FF0000807FE9DE12E2000080FFA0443EDB000080FF6446B04F770F6AE0826726DF0000807F00000080000080FF000080FF000080FFCEF981F5000080FF000080FF8982A6D20000807F000000803C4BCCD7FD1BBCE80000807F000000000000807F000080FFCE6BD2C000000000000080FFAF4B4CE8C569A5B02499CA43000000000000008000000000F95BEE73000080FF0000807F0000807F76DE9A586BBE7053AD518C71B29AE8CC0000807F76FB2C470000807F00000080A4618738000080FF000080FF0000807F000080FF0000807F0000807F000080FF0000807F0000807FF9FDBAD2B2C18D2A000000800000807F236503A7000080FF0000807FCECC4AF7000000008513E4BA0000807F14DCE135BAFFCBB812884DF50000807F000080FF0000807FEDC78513000080FF000080FF0000807F43540F30000000807CC0CB49000000000000807F000080FF639810B00000807F000080FF0000008030D01332000080FFC38E554C00000000000000800000807F000080FF0000807F959A7325000080FF000080FF4EEA6676AA96F7FD0000807F000080FFF80CABE40000807F32B7FFCF0000807F0000807F39F3BE6ADF8535CF1DDFA829000000000000807FBC151E2A0000807F000080FF0000807F000080FFA6C6C08000000080000080FFBB683CBA000080FF00000000000080FF000080FF5E56A8640000807F0000807F0000807F0000807F812B89C4000000000000807F0000807FBD9A0AC00000807F0000807FCC30934B00000080000080FF9AC1097CE5CD487F7C113061B8BE5170000080FF0000807F524E974F0000807FCF3C2A7F000000000319249A00000000000080FF000080FF000080FF00000080000080FFEE6DEB756BE52CBDC8EFDA200000807F000080FF4F916A47000000000000807F0000807F0000807FA90CA8F55119B35AB3062AC30E2C86F20000807F000080FF000000800000807F5354E4E853E6A76F4558AF070000807F00000080F19858940000807F38D8C2AC0000807FA814493A000080FF169C5EC8E0D18335FDAED4700000807F000080FF82729FEA0000807F0000807F000080FF00000080000000800000807F000080FF0000807F0000807F00000080000080FF0000807F00000000886C1AB60000807F000080FF0000807F2F2810DE000080FF0000807F0000807F000080FF0000807F000080FF0000807F16C4A9220000807F000080FF618073EB0000807F00000000ED50E1FA00000000000080FF5AFAF77A000080FF42334D6C000080FF000000007C3159BD000080FF000080FFE010B51F0000807F00000000292D8861E28FDB92E2FB42C8000000803F3F91A7F0763C0FBCF5EBB046FA85C3000080FFC46F9C46F7389F3062F1B4DF000000007061956BE64E65EB0000807F0000807F000080FF745A85EF774B7C5000000000000080FF0000807F49B45048000080FF0000807F00000080F81283E9D06E3045000080FF000080FF000080FF416714BCCBA12A58000080FF000080FFCC2E75FAAF563F46000080FF91B308B8000080FF000080FF5C382D56D769AF57F55A88F2AA88C54F000000800000008000000000F8F885A600000000000000000000807FACC88AE90000008029B233AF3DDB07AD0000807F0000807F000080FF5E775F5A000080FF0000807FBB778EF7000080FF642FBC8A6387DA710000807F0000807F000080FF000080FF0000807FCD81A25D0000807F418198F60000807F000000000000807F0000807F0000000024A488D6000080FF0000807F28C61AFB00000080469D17D9000080FFD537E7FA0000807F4E0DAD6E12DE2F9B000080FFE6A53874000080FFB8F685EC0000807F0000807FDAFAC53C38745853000080FF0000807F0000807F000080FF000080FFF7A1566F0790A8140000807F1E253F3D6AD3115A65B7923E0000807F04DA7EE20000807F0000807F2840FFC2C54736CD000080FF0000807F000080FF000080FF000080FF000080FF000080FF0000807F000080FFC6247A740000807F0000807F141E1C39000080FF0000807F0000807F0000807F4066716E620C373000000080A1BC0F9E0000807F00000080000080FF000080FF3A647360000080FF000080FF"> : tensor<20x30xf32>
    return %0 : tensor<20x30xf32>
  }
  func.func private @integer_pow(%arg0: tensor<20x30xf32>) -> tensor<20x30xf32> {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<20x30xf32>
    %1 = stablehlo.multiply %arg0, %0 : tensor<20x30xf32>
    %2 = stablehlo.multiply %0, %0 : tensor<20x30xf32>
    %3 = stablehlo.multiply %1, %2 : tensor<20x30xf32>
    %4 = stablehlo.multiply %2, %2 : tensor<20x30xf32>
    %5 = stablehlo.multiply %3, %4 : tensor<20x30xf32>
    %6 = stablehlo.multiply %4, %4 : tensor<20x30xf32>
    %7 = stablehlo.multiply %5, %6 : tensor<20x30xf32>
    %8 = stablehlo.multiply %6, %6 : tensor<20x30xf32>
    %9 = stablehlo.multiply %7, %8 : tensor<20x30xf32>
    %10 = stablehlo.multiply %8, %8 : tensor<20x30xf32>
    %11 = stablehlo.multiply %9, %10 : tensor<20x30xf32>
    return %11 : tensor<20x30xf32>
  }
}
