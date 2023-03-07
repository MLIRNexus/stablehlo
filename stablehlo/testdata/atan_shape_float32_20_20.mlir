// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.constant dense<1.000000e+00> : tensor<20x20xf32>
    %3 = stablehlo.atan2 %0, %2 : tensor<20x20xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x772AFC3EA87B253FE35A41C0E4788B3EF4A9AFC0279A883F1775B73F46D910C02CA3333EE2EB863F442D10400CB73CC080597CC056BEB540F7E3823E742E0ABF4B9E05C0AA00543F14D58FC01EFD7DBFA16D0740F7DEACC048F0084059913E40E8EDCFC0CD158B406A9ED63F6A946CC027539BBE17416CC0DCA72CC0F1342D405D172C40447D94391CF06F3D735D903F6B3A8CC05FFD4DC076FA334063D728C01A28C43E2EF7EEBFAEC2B8BE0EB4FBBFF4B2C03F5FD5E4BE90E10CBE89AA06C01429713FD9948ABFCE93CFC0917012403703D5BF519F04404FEF7CBFD3FBCFBF3C8719C074D180C04996C5BF58F60CC04C614E409893DC3F1E9A7340C18CEB40E275BDC0A2EA2140332C3140BCB716C1DF6551BFB0311BC0072D2740F2651DBE3429D8BFCB120E3EF23AB13F068D773F1651A4BFC81B333EEE01DA3EEBAA89404B3732C0346111C098FA1F400443B73F3B0FDCBFC92AA6BFB2C0433FD8AA47C0DBF4784093F4C6C002AF953F20F0A04047FC8CBF0FB8F03FEB34D23E63006E40257F543FEA11CD3F251E9A3F92D25040F46C1CBF69C22740139835BFFB10CAC06754BDC038210D3FF1BA03BD531246408269103FF19280C03CE96E3F2F14404085355940CBC86D40EB3A4FC00AB7763F6BD564BECEAC13C0B6BC24C04587D2C014547A3F1EAAAB3FB4BC94C0694735BFB6CEA5BFDAB80F40C8D29140478A6440FE060AC1BBEB4DBFB82111C0C21AC5BDA58AE13F50B558406FA0F4BF9A61963F283F80C073DED93F0886A83FB4A39B3FC0440EC00A2A12C08E03AF405CA0CCC0217AB4BF137F22BFF6847840F7070EC078A4183F9325DBBFEBAD8CBE32DDAD3F02C14F401519A5404728D3BF959B9240BE343340F47C78C0CB859DBFE62C4B40D933F8BF97CD833F65917BC077DAF3BF7F0710C07C0FBABF5DA8E33E85027B3EEBEFBEC0F0F19E40685058C096199E3DC6052D3F807296BFE907403F580E143FD330834004A0D9BE76A34BC0E0EEBC3FDBBB48BD69BD94BE1DCE9ABDC3AD4540F7F650406321D03F7E9101BFA26924408EFA5BBF0A9B184070DEEABFE571AD3F4BF0DEBFD49807C01172CDBD55C749BF7105A13C217F47BF550757C0796387406FF020BF60188AC057615CBE687A6FBF63CDF53F56198B4054A55240C673A0C005695D40A568913F354F14C0C313E3BF5BB629404C4A3ABF9901DE3FDEDF6DC02F052CBC8E72CC3EF62023BFEC9E643F2BF7893F8724A1BF5AB49140D3D2F43FC56DAE40CB3B1E4091A74740DD4E09C0088F2940C151EFBFDCF97E3F26618DC017E007C07CB151401E716940C684BCC067773FBC3A3F12405FAE743F6CC2B73FB437AE40D3F008C0786A06C06234EE3FFDE1CA40FB75BCC0C9B4F6BF7093D4BE12E0F53F491F65405D295D403FF80B40CC7C963F6F8B0DC0E268243F8C8502C074B8A73F63BAF9BDFDAA634060B83F40A1BB52C0816AC33F06809AC0E7AB9B40B9309440B84FF43F042C29C07E20D3BF25D714C0F2B29DBF06DC64BE2BF27E3FDA63423F1941A0405B363EBEEDA682BF366783403D4903BF89822A40805D9D3F283E6EC051A640C0FA57FC3F5BFA78C087DFCCBEECB1A2BEB6846340A320EEBFF84CF83DCAC09F3FF7A40AC0D3B811BF6199D13F4F2603C02F3F9A40014476BEF055854010739BC0AC5F4440B3528C3F4E43B8C0E81B54C0EF8E4D40D4CFF4BFAA2C00C050FECEBE8EEAC8407092D93FD5C1B2BE3FFE4BC07B193B4041CACDC0914A0F3E3F50E4BF10704FC041340D3F813AC3BF7F2E3EC05B60F540AAE9A040E99C273F1B66F3C064ADAAC08AFDED3E91B80F3ED6C065BC7CBEB93F7253F7BF032B3E403D02C3BFE0619EBF1C55A23F20BC7BC0EBFAC83F9675C33DD5BA91C02326933FDDE3DE3EE38A9BBF95001FC05A3DABC061AA03407027043F7BC21B3F7203B83FB86BC63F45F630404E496EBE6D8774C02B8D573E1950A3BD160913C079345340E449A13F067BEC3FC8C720C070294DC03990B1BF0C56BC3F95CF92C0202E724031BD713F01882AC080FB96C06EFB10C0BAC9B2BFBED6294087AB47BFAA3F0FC04A330E406F4108C0431892BFBB9263C02E1D68401F8231BF99EB3D4038AB2D40C5583C400ABEC5409EE4543EA75EFFBF734CF73F970AA4405ACB92C00DE47D40E48C6B3FB9EA6140A4346D40F912634037200E3E6535E4BFC092BDC00A30C6C0AEC3843F3B5167C01FD0ADBF0D9CE4BF5212B13FE7A405C0D0230040"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0xA44FEA3E09E8123FAC25A0BF132B883E61FFB1BFAA61513F042C763FCECE93BFF3D3313EB2CC4F3F6696933FEA359FBFF544A9BFDAC0B23F5A25803EE66AFDBECCE28FBFCD10313F6C0AADBF660D48BFD58D903F16A2B1BFBB19913FE8969F3F2B84B5BFB71DAC3F1D3A843F9C3EA7BF8BCE96BE3A33A7BFF19F9BBFEFC19B3FEE7C9B3F447D9439FFA96F3DDA6C583F1A58ACBFD580A2BF8E549D3F59AF9ABF3453BB3E171E8ABF7550B1BE12D88CBF38067C3F6F32D7BE90000CBE464690BF476C413FD13753BFD07BB5BFA552943FA0CD83BF0E838F3F268547BF147282BFE78196BF62E5A9BF1DF77EBF568292BF6592A23F3BC2853F2E2DA83F55C7B73F10A5B3BF62E1983F09B19C3F3A86BBBF4A832FBF04FF96BF4A439A3F092D1CBE26A184BF132C0D3ED5FF713F53C4443F62B468BF9750313E551ACE3E07D4AB3F60EE9CBF13FB93BFEE59983F340B763FD4A085BFAD176ABF051F273FAA5BA1BFA0DAA83F33A6B4BF09035D3F55F0AF3F326955BF99818A3F9376C73EF86FA73FC25B313F11A3813FC4B1603FEFFEA23F386A0CBF5C699A3F0FF21DBF54F5B4BF59A1B3BF1CFB003F52AF03BDFC0EA13F0D7C033FD2D6A9BFD739403FC4E49F3F8F62A43F7768A73F70B8A2BF8F55443F782261BE5DB794BFA0A199BF00C1B5BFCB31463F751A6E3FD8EFADBF5DBC1DBF02D369BFF86F933F5469AD3FBE1CA63F4C4ABABF686A2DBF6FE693BFD37FC4BD1EFD863F084EA43F585B8BBF80995D3F3AC3A9BF0112853F02D56B3FF6ED613FC5F392BFFD3B94BFEDE9B13FAE34B5BFE63274BFE9C910BFBACCA83F48DF92BF64A4093F946585BF954A89BE90A96F3FBCCFA23F688EB03FD24E83BF0A8EAD3FFE279D3FBBCBA8BF307063BF6200A23FDE1D8CBF20CF4C3FB32CA9BFB0308BBFF48993BF42DC77BF5437D63EFB27763EB0CEB3BFC8A1AF3FD03DA4BF79C99D3D1A27183FB2A75DBF8DC1243F633B063F2E70AA3F6CC7CDBEBE15A2BFD2AF793FC69248BD68C190BEE5829ABDF0FBA03F2E05A33F647C823F08E4EFBECC8B993FA3B935BF9B3B963F203189BF035E6F3F5A5986BF979D90BFB4C2CCBD79E12ABF2200A13C917729BF8C08A4BF7D5AAB3FFAAC0FBF68EAABBFBC1159BE598740BFCA9B8B3F6D1EAC3F744EA33F5CDDAFBF600BA53F1B57593F89EA94BF655C87BF1EE79A3FF10A21BFFD1D863F956BA7BF91032CBCEA83C23E2D3D11BF419D3A3F49A6523F364766BFBB63AD3F2B668B3F7BD6B13F7ADD973F0E5BA13F913B91BF52DD9A3F42328ABF858C483F0192ACBF83B790BF1225A33FAECFA63F2F8AB3BF2C753FBCCD42943F8A46433F995E763F6ECFB13FED1991BFA12E90BF8EF2893FB309B53F8788B3BF02CD8BBFC37CC9BEC69F8B3F5C32A63F8D01A53FFA2A923F57B05D3F20B592BFDE25123F42B58EBF223E6B3F5480F8BD26FCA53F64D29F3F3952A3BFF7AB7D3F96EBAEBF921CAF3FFCD6AD3FFB498B3F93C49ABFBA4C83BF171595BF149463BFC22861BEA988483F5242263F99D5AF3F9D113CBECCAF4BBF617CAA3F479EF2BEC1199B3F1E50633F4B78A7BFE501A0BFAFF98C3F4EDBA8BFE0E1C2BE52879DBE8AF6A53F21EE89BF3C18F73D8132653FB7B491BFDD7904BF0CE3823F56F38EBFE6E0AE3F15AD71BEA6E9AA3F5713AFBF2ABCA03F8ECF543F660DB3BF5E8DA3BF5A6DA23F87658BBFE5C88DBF14B5C4BE5AD8B43F7AFE843F9EFBABBE0A26A2BFEFDF9E3FF850B5BFE95D0E3E65A887BFAEC1A2BFB509013F208F7DBFD5829FBF8076B83F59EFAF3F2467143F5D54B8BFBE56B1BF3BC7DE3ECBC90E3EFBBC65BC28A8773F98EE8BBF1F829F3F446D7DBFAA1E64BFCF31673FE431A9BF4279803F7CDEC23DEC64ADBF7CD95A3FC838D23EEDD961BF941498BF3C6AB1BFFA258F3FA7FDF33EF3ED0B3F0B89763FED747F3F92A49C3FAD1E6ABEB84BA8BF2673543ED1F7A2BD668394BF9766A33F1A64663F1B8F893F4E9298BF615BA2BF393A72BF754F793F7D97ADBFECFDA73FAABA413F1A1B9BBF1C54AEBFF4D993BFAA0F73BF2EEF9A3F2F9329BFC04793BFE4ED923FC8DA90BF0BF059BF98F8A5BFE69FA63FFA341BBF34759F3F48DE9B3F6E229F3FB186B43F22E7513EB7968DBF1EED8B3FFD66B03FB896ADBF6074A93FF96A3E3F05BAA53F6854A73FD4E5A53F3E390D3EF8A187BF44A8B3BF4D92B4BF1EBD4D3FFC82A6BF5EA06FBF81BA87BFF6E3713F43E58FBF5DC58D3F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}

