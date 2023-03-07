// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<1x20xf32>, tensor<20x20xf32>)
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.broadcast_in_dim %0#0, dims = [0, 1] : (tensor<1x20xf32>) -> tensor<20x20xf32>
    %3 = stablehlo.bitcast_convert %2 : (tensor<20x20xf32>) -> tensor<20x20xi32>
    %4 = stablehlo.bitcast_convert %0#1 : (tensor<20x20xf32>) -> tensor<20x20xi32>
    %5 = stablehlo.compare  NE, %2, %2 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %6 = stablehlo.compare  NE, %0#1, %0#1 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %7 = stablehlo.or %5, %6 : tensor<20x20xi1>
    %8 = stablehlo.constant dense<0x7FC00000> : tensor<20x20xf32>
    %9 = stablehlo.bitcast_convert %8 : (tensor<20x20xf32>) -> tensor<20x20xi32>
    %10 = stablehlo.constant dense<-2147483648> : tensor<20x20xi32>
    %11 = stablehlo.constant dense<2147483647> : tensor<20x20xi32>
    %12 = stablehlo.and %3, %11 : tensor<20x20xi32>
    %13 = stablehlo.and %4, %11 : tensor<20x20xi32>
    %14 = stablehlo.compare  EQ, %2, %0#1 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %15 = stablehlo.constant dense<0> : tensor<20x20xi32>
    %16 = stablehlo.compare  EQ, %12, %15 : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<20x20xi1>
    %17 = stablehlo.compare  EQ, %13, %15 : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<20x20xi1>
    %18 = stablehlo.and %3, %10 : tensor<20x20xi32>
    %19 = stablehlo.and %4, %10 : tensor<20x20xi32>
    %20 = stablehlo.constant dense<1> : tensor<20x20xi32>
    %21 = stablehlo.or %19, %20 : tensor<20x20xi32>
    %22 = stablehlo.compare  NE, %18, %19 : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<20x20xi1>
    %23 = stablehlo.compare  GT, %12, %13 : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<20x20xi1>
    %24 = stablehlo.or %23, %22 : tensor<20x20xi1>
    %25 = stablehlo.constant dense<-1> : tensor<20x20xi32>
    %26 = stablehlo.select %24, %25, %20 : tensor<20x20xi1>, tensor<20x20xi32>
    %27 = stablehlo.add %3, %26 : tensor<20x20xi32>
    %28 = stablehlo.select %17, %4, %21 : tensor<20x20xi1>, tensor<20x20xi32>
    %29 = stablehlo.select %16, %28, %27 : tensor<20x20xi1>, tensor<20x20xi32>
    %30 = stablehlo.select %14, %4, %29 : tensor<20x20xi1>, tensor<20x20xi32>
    %31 = stablehlo.select %7, %9, %30 : tensor<20x20xi1>, tensor<20x20xi32>
    %32 = stablehlo.bitcast_convert %31 : (tensor<20x20xi32>) -> tensor<20x20xf32>
    %33 = stablehlo.custom_call @check.eq(%32, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %33 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x20xf32>, tensor<20x20xf32>) {
    %0 = stablehlo.constant dense<[[-1.5332396, 1.77375591, 2.70250678, 5.52205133, 0.246267959, 5.61551762, 4.62039471, 4.81690025, 2.152565, 2.10331678, -3.81048226, -0.941428244, -3.96803498, 4.55166721, -2.6990633, -2.44857621, -1.11659122, 1.7927171, -2.31964517, -6.29476881]]> : tensor<1x20xf32>
    %1 = stablehlo.constant dense<"0x8CEBDE3F3E480AC062A326BEC867E73FAEC5733FBABD6440F539553FA3B3953FFF0453C0836FE73F8A550FC0E058E33F36C0CF3F7C7DA33F1EC5B03FCE7AE33F79E06AC085FD11C08EF14E3ECD959A3F6B93CC3FA91201413D1CCAC085338CBF08B2AFBF5282604038FB4BC0F6C31D4043E118C0298141C0095B5440D8CC223F9A6602BF5EC71A3FC35A99C0454064C0A5C58BC004A4074094561C404F3A1840987B02C06A9592C024AD0B4075E397C010B43B3FA6CA74BE90DFB23F6BAE43C0F0B83A40121749C02A4B40BE2E9986405852B13C1DBEFD3FD1274CC0C0C229C062A99DC0C95450BFB4E1294074256DBEA3A9FEBFABD7D6BFA97E4840754310BE87F10D4021844EBF91B5CD400605AE3F57E2B1BE7073EEBECD4A9E3F38491B3FBC118E40721F3DC02693313FF9628D3E3DB146C054D10140274CB9BF64A66BC067750D407F4CD43F69320FBE51A418C0F2C83DC0DCED88C064DE93404687D1404ED2FBBF7F767B401F5F0F4024E18DBFE826AA3EF1C524C0CE3B3E4008E9384077F547400C8A45BF6E957C3E8E1FF6BF1D6809BF807896BFCEB543405BB3833F436667C041F881BE08FFEF3FD76B3B40130212BFBFC57AC0A4C01FBF813073406D0AC2BE2CB6A63E387583BE009D1BC0B36DAD40BB422DC0D3FBB240844446C06D8771404FC232C0900B60C0A19936BF51BCB14035906F3FB2B02B4019F082C00D2227C090D2B7BF476C773FE4CF9F3F11163EC0230D67BEE056F63C10F290BFD8B077C0A5B56EC0F190063FFFBFDF40C56A77BE9610F3BF9CD200C01285364027D72BC0F1BA0B407C4FD8C0EA168BC0D8DE92BF2F53B340830958C0B3E2E13F3803273FCB175BBFC5C39BBFC828BA3CA319B140AD4891C068F60A40A0E0033FE57AE2BFE1EEC1C0FC26A4C061BFEABE63177840759FB8C0CF6618400E2688BEAEECC9BFD3DCE4BF38001640DE6B353E658B193FBB2A0AC0DC6EEE3F8971FD3EBEC088BF641646BE91D622C03E1DA03E3D3862BFC9A25CC0A25FF63FC7938DC038B198401359EC3FA6C968C038962DC0939304403CA645C09816CABEC61A993FCDAC4940B0DB98C0D5FE43C0DAA060C0277EB13E3FDB2CC0780E3A3F7BDE0EBFAE800940B9811E3ED664C3C0030E4DC0795E114030BA1BC00CDFC5BF5C8FF03E04D2A8C0ECA2DCBF3F679EC01A3B39BF4E88B240E6A682BF6E40A4C063B4A5BDADDF3B400DC66F40711AA440762C3B3FCCCFDEBFF20C32405AF7EBBF5BB7A03FBC7710408F9FD43FF6575CC05F7C43C0E499C1BE6381EEBF1C2279C071F363C0467A65C068858F3FAD3438BD095F4D40AA4BC04002DB4640FA68104081CC62C081019C4090EA16C05BD25240958CAF3F57404140E8B190C0FF79AA4084346040FBCE59BE1553AE3FB9DCBCBED6E1D43FF9E8E1BF0B09633FA827683F0FCA683FAA1082C0FAF0A73EC8C289BF2808BC3EE14E874062B3014048C2804039CC8B3FF5357FBFDB00BD40C0A3204007A11BC0E7D43ABF055EA4BE556D86BFC74AA83E46E341BF43AA80C08594013F7150AE406D03013F1DF75EC0EBBEB7BE54CE2340F1B166C0EBC0284035639440E90A9AC00AB226C09D54834035D8633F211491C01D1A12BE964745C0CBCC81C0C09D6840656F8BC036A4B33FE49D09BEDAB19BC0ABD696C0C0CD99C00D0E2940190BAFC0B0352DC0906749401A39E7C000782540838E53408A6722401B77C94002CADD3E095E6C3E5F5FAFC082B5ACBFFC101DBF061BD8407E1A39406C2E0040D2F4273FBA082A40AE38433F2FE125C06D9B83BF67BFFF3F9C7D4BBF9C032D3F1DCE46BE9628C03F72C512C1D20B3EBF88ABDF3E122A90BF3040F83FB355DDC072627A3FB0DFFA3E5C90C6C078F3E340A5D48840766952C0738D98BFF713FE3F9B6178C0918E04C1ED18BCC082509840DB9EC43F63E08DBFE1210AC06D23DBC0564A0CC096464A3EEAC4503ED0E557C04C8B6C3E41E0B6C0A9B09DC0B0CF09C01C54973F20640CC011689D4056F353405BA74EC0EA08C4C0FCD05D40440DAFBF7E302C4043B8CABF6DDF40C0501A7AC034F97E3F115ED5BFF31531C046CA2E40EE3B3EBEE10C0C3F50E3BCBE69FECFBF2BE6D83F21EA26C0133A953F96869FC047D09E40CFF41AC0C6037A3F4D4F09C03CC9FBBF762A72C0E0AF9CBFAAC7A53EB8702FBF3AA87E4023AE3BC050F65440E1B1D1C05B16A33FE2F814BF3CCE37BEC0DF54BFF6CCD5BF60CC80BFF520F43F5F0035C0"> : tensor<20x20xf32>
    return %0, %1 : tensor<1x20xf32>, tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x3141C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC077E53F107514C0BE6EC9C03141C4BF700AE33FDEF52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914075BD2CC07AB51CC077EC8EBFC277E53F107514C0BE6EC9C03341C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A40A1C30940BD9C0640F0DE73C0700171BF48F47DC041A7914075BD2CC07AB51CC077EC8EBFC077E53F107514C0BE6EC9C03341C4BF6E0AE33FE0F52C40A4B4B040AC2D7C3E51B2B34047DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC277E53F107514C0BE6EC9C03141C4BF6E0AE33FDEF52C40A4B4B040AA2D7C3E51B2B34047DA93400D249A409FC30940BF9C0640F0DE73C0720171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC077E53F107514C0BE6EC9C03141C4BF6E0AE33FE0F52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC077E53F107514C0BE6EC9C03141C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC077E53F107514C0BE6EC9C03141C4BF6E0AE33FDEF52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A409FC30940BF9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC077E53F107514C0BE6EC9C03341C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC077E53F127514C0BE6EC9C03141C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914075BD2CC07AB51CC075EC8EBFC077E53F107514C0BE6EC9C03141C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F2DE73C0700171BF48F47DC041A7914075BD2CC078B51CC075EC8EBFC277E53F107514C0BE6EC9C03341C4BF700AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F2DE73C0720171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC277E53F107514C0BE6EC9C03141C4BF6E0AE33FE0F52C40A4B4B040AC2D7C3E51B2B34047DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC077E53F107514C0BE6EC9C03141C4BF700AE33FE0F52C40A4B4B040AA2D7C3E53B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC077E53F107514C0BE6EC9C03341C4BF700AE33FE0F52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F2DE73C0700171BF4AF47DC041A7914073BD2CC07AB51CC077EC8EBFC077E53F107514C0BE6EC9C03341C4BF700AE33FDEF52C40A4B4B040AC2D7C3E51B2B34047DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC075EC8EBFC077E53F127514C0BE6EC9C03141C4BF6E0AE33FDEF52C40A4B4B040AC2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F2DE73C0700171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC077E53F107514C0BE6EC9C03341C4BF6E0AE33FE0F52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF4AF47DC041A7914073BD2CC078B51CC077EC8EBFC277E53F107514C0BE6EC9C03341C4BF700AE33FDEF52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A409FC30940BD9C0640F0DE73C0700171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC077E53F127514C0BE6EC9C03341C4BF6E0AE33FDEF52C40A4B4B040AA2D7C3E51B2B34045DA93400B249A40A1C30940BD9C0640F0DE73C0720171BF48F47DC041A7914073BD2CC078B51CC077EC8EBFC077E53F107514C0BE6EC9C0"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}

