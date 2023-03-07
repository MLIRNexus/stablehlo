// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.multiply %0, %0 : tensor<20x20xf32>
    %3 = stablehlo.negate %2 : tensor<20x20xf32>
    %4 = stablehlo.abs %0 : tensor<20x20xf32>
    %5 = stablehlo.constant dense<1.000000e+00> : tensor<20x20xf32>
    %6 = stablehlo.divide %5, %2 : tensor<20x20xf32>
    %7 = stablehlo.exponential %3 : tensor<20x20xf32>
    %8 = stablehlo.divide %5, %4 : tensor<20x20xf32>
    %9 = stablehlo.multiply %7, %8 : tensor<20x20xf32>
    %10 = stablehlo.constant dense<2.000000e+00> : tensor<20x20xf32>
    %11 = stablehlo.compare  LT, %4, %10 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %12 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %13 = stablehlo.multiply %12, %6 : tensor<20x20xf32>
    %14 = stablehlo.constant dense<2.326820e-02> : tensor<20x20xf32>
    %15 = stablehlo.add %13, %14 : tensor<20x20xf32>
    %16 = stablehlo.multiply %15, %6 : tensor<20x20xf32>
    %17 = stablehlo.constant dense<-0.138703942> : tensor<20x20xf32>
    %18 = stablehlo.add %16, %17 : tensor<20x20xf32>
    %19 = stablehlo.multiply %18, %6 : tensor<20x20xf32>
    %20 = stablehlo.constant dense<0.368742466> : tensor<20x20xf32>
    %21 = stablehlo.add %19, %20 : tensor<20x20xf32>
    %22 = stablehlo.multiply %21, %6 : tensor<20x20xf32>
    %23 = stablehlo.constant dense<-0.582473278> : tensor<20x20xf32>
    %24 = stablehlo.add %22, %23 : tensor<20x20xf32>
    %25 = stablehlo.multiply %24, %6 : tensor<20x20xf32>
    %26 = stablehlo.constant dense<0.621000468> : tensor<20x20xf32>
    %27 = stablehlo.add %25, %26 : tensor<20x20xf32>
    %28 = stablehlo.multiply %27, %6 : tensor<20x20xf32>
    %29 = stablehlo.constant dense<-0.494451523> : tensor<20x20xf32>
    %30 = stablehlo.add %28, %29 : tensor<20x20xf32>
    %31 = stablehlo.multiply %30, %6 : tensor<20x20xf32>
    %32 = stablehlo.constant dense<3.404880e-01> : tensor<20x20xf32>
    %33 = stablehlo.add %31, %32 : tensor<20x20xf32>
    %34 = stablehlo.multiply %33, %6 : tensor<20x20xf32>
    %35 = stablehlo.constant dense<-0.274112701> : tensor<20x20xf32>
    %36 = stablehlo.add %34, %35 : tensor<20x20xf32>
    %37 = stablehlo.multiply %36, %6 : tensor<20x20xf32>
    %38 = stablehlo.constant dense<0.563825965> : tensor<20x20xf32>
    %39 = stablehlo.add %37, %38 : tensor<20x20xf32>
    %40 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %41 = stablehlo.multiply %40, %6 : tensor<20x20xf32>
    %42 = stablehlo.constant dense<-10.477664> : tensor<20x20xf32>
    %43 = stablehlo.add %41, %42 : tensor<20x20xf32>
    %44 = stablehlo.multiply %43, %6 : tensor<20x20xf32>
    %45 = stablehlo.constant dense<1.297720e+01> : tensor<20x20xf32>
    %46 = stablehlo.add %44, %45 : tensor<20x20xf32>
    %47 = stablehlo.multiply %46, %6 : tensor<20x20xf32>
    %48 = stablehlo.constant dense<-7.49551868> : tensor<20x20xf32>
    %49 = stablehlo.add %47, %48 : tensor<20x20xf32>
    %50 = stablehlo.multiply %49, %6 : tensor<20x20xf32>
    %51 = stablehlo.constant dense<2.92101908> : tensor<20x20xf32>
    %52 = stablehlo.add %50, %51 : tensor<20x20xf32>
    %53 = stablehlo.multiply %52, %6 : tensor<20x20xf32>
    %54 = stablehlo.constant dense<-1.01526523> : tensor<20x20xf32>
    %55 = stablehlo.add %53, %54 : tensor<20x20xf32>
    %56 = stablehlo.multiply %55, %6 : tensor<20x20xf32>
    %57 = stablehlo.constant dense<0.42184633> : tensor<20x20xf32>
    %58 = stablehlo.add %56, %57 : tensor<20x20xf32>
    %59 = stablehlo.multiply %58, %6 : tensor<20x20xf32>
    %60 = stablehlo.constant dense<-0.282076746> : tensor<20x20xf32>
    %61 = stablehlo.add %59, %60 : tensor<20x20xf32>
    %62 = stablehlo.multiply %61, %6 : tensor<20x20xf32>
    %63 = stablehlo.constant dense<0.564189494> : tensor<20x20xf32>
    %64 = stablehlo.add %62, %63 : tensor<20x20xf32>
    %65 = stablehlo.select %11, %39, %64 : tensor<20x20xi1>, tensor<20x20xf32>
    %66 = stablehlo.multiply %9, %65 : tensor<20x20xf32>
    %67 = stablehlo.constant dense<-88.7228394> : tensor<20x20xf32>
    %68 = stablehlo.compare  LT, %3, %67 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %69 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %70 = stablehlo.select %68, %69, %66 : tensor<20x20xi1>, tensor<20x20xf32>
    %71 = stablehlo.compare  LT, %0, %69 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %72 = stablehlo.subtract %10, %70 : tensor<20x20xf32>
    %73 = stablehlo.select %71, %72, %70 : tensor<20x20xi1>, tensor<20x20xf32>
    %74 = stablehlo.constant dense<1.000000e+00> : tensor<20x20xf32>
    %75 = stablehlo.multiply %0, %0 : tensor<20x20xf32>
    %76 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %77 = stablehlo.multiply %76, %75 : tensor<20x20xf32>
    %78 = stablehlo.constant dense<7.85386146E-5> : tensor<20x20xf32>
    %79 = stablehlo.add %77, %78 : tensor<20x20xf32>
    %80 = stablehlo.multiply %79, %75 : tensor<20x20xf32>
    %81 = stablehlo.constant dense<-8.0101937E-4> : tensor<20x20xf32>
    %82 = stablehlo.add %80, %81 : tensor<20x20xf32>
    %83 = stablehlo.multiply %82, %75 : tensor<20x20xf32>
    %84 = stablehlo.constant dense<0.00518832775> : tensor<20x20xf32>
    %85 = stablehlo.add %83, %84 : tensor<20x20xf32>
    %86 = stablehlo.multiply %85, %75 : tensor<20x20xf32>
    %87 = stablehlo.constant dense<-0.0268538129> : tensor<20x20xf32>
    %88 = stablehlo.add %86, %87 : tensor<20x20xf32>
    %89 = stablehlo.multiply %88, %75 : tensor<20x20xf32>
    %90 = stablehlo.constant dense<0.112835854> : tensor<20x20xf32>
    %91 = stablehlo.add %89, %90 : tensor<20x20xf32>
    %92 = stablehlo.multiply %91, %75 : tensor<20x20xf32>
    %93 = stablehlo.constant dense<-0.37612626> : tensor<20x20xf32>
    %94 = stablehlo.add %92, %93 : tensor<20x20xf32>
    %95 = stablehlo.multiply %94, %75 : tensor<20x20xf32>
    %96 = stablehlo.constant dense<1.12837911> : tensor<20x20xf32>
    %97 = stablehlo.add %95, %96 : tensor<20x20xf32>
    %98 = stablehlo.multiply %0, %97 : tensor<20x20xf32>
    %99 = stablehlo.subtract %74, %98 : tensor<20x20xf32>
    %100 = stablehlo.abs %0 : tensor<20x20xf32>
    %101 = stablehlo.compare  LT, %100, %74 : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<20x20xi1>
    %102 = stablehlo.select %101, %99, %73 : tensor<20x20xi1>, tensor<20x20xf32>
    %103 = stablehlo.custom_call @check.eq(%102, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %103 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0xE1BC8A3D652201C0485BB83E6D50D73F6C542140E9D515C0F48DE2BBA97BFA40533D8840218422400129EABF7355313F13B11AC0169A36C00B3C31C03F43C23F85DF69C086BC49BF7C1EA2406CB428C0548C8E404B5351C0D5E066C046B0A9BE689C9BBF6CD8A5BE6B3DB4BF0B352840B47705409E41B6BFD2BF87C05FF932BFEF2459C0A1EEBFBF2C911640AF235F40204B23BECA0496BF10FAA3407439473FD8C818C0BAAAC93F7A607A40BDE52040B41774BDB74D89BFA20782402AF16D400F373D3FC20F70BEBB02A440C09F2BC02473C43EE774C8BF1D380E3FBD6569BE42F1A64052C1BB3F28E0A3BF4235B040891B52BF9D0C523F0ACC803F6FB088BEA400D9BFA1A41DC01D289A3C20B1343FFA1B6740AF779FBFE6D42B40AFDCC23E0B9C1240C26948C088FA03BF8EA7523F645CBEBE63D4843E604A12BFC22A59C07648883F94268AC04D1D42C03095A7BF88583A3FFDB504BEFB8CE2BFAC2C734087D7BA3EC5D77DC07595103F465B6EC01BDAFE3F21325FBF37EE3940BFD10EC07765C2BD67FF433FD9109C3F4A786FBF878EDBBF60D049C0A37EECBF31FF23C0E70DA2BED2F17F400D9CA0C0ECA8AAC0BE619C3F7399783F3D53ADC0F815DABF3864BB3FF3B899BF20A39840C051D9BFD8D7914035E6863F7EAB263EB0398BC0C28BF9C06318524011CCB2BF956435C0A59E2E408585763FD04DFCBF9E187D40E8A4704097C89CC0F0B29CBFD3A347C0884AAB403D4B703E7DAD233FA6EF09C0523E803F1DA100C0598975BF845D97406F753A400350D13F41D9B6C030B543BE1BE71141807AD5C03CA736C0DD851B3F1FE51FBD632BE1BF67B51AC05636E3402396F33FD43D69BF77EB1BC01A74E83EAD782AC09E6E9A40B6A2BD3FBFF48C40E9EBB13FB220E7BF58F72540A0B8DF3F0A7C084051A4A0BF5B75C93FC046B73F4B45513F9795BB3D9CC9C540780B92C06B3D9540BF1331BEFBD7B43F93B408C08E8B0F41945FD7BEEC25CF40C3CFF23EAE2E0041E8CBA44080E99ABF090262BC5BD8C03E884A95C03029B73E3BE3B640D7A424C1419C9240DEC8DF3F69D3AA405C0CF93F597034C0239A28C02108873E2509ABC0A240DEBFCBD99FBF5470BE3CA55DD9BE8041C03FA54FA840BE8DBD3EFA5286400A592E3EAA386C404B772C404E6F44BF15482FC0D92A64BFE858EF3C9B31B53EC4D2084025BE16401E6968C0BC8C8840CFA910C0FED7DAC04CEA21C0C298313EF1FDD2BF31F7B73FA8DA0FC092215E3FF21D66C0D7A5DEBE345AA3BFAC006E3FFF0183C086F0C5C0BCD52CBFA3CADF3FFB4F4CBF1248A23F0B9E32C0D135B5BFA339C03F381D5E409F7839409BFC3EBF897F8B407767ACC0038AE8BE67E4263FD4BC5AC0623405C077F194BF8B5D23BEECCA27BF6A7471BF4A1162BFD0BB693F943A3E40825B213F4D9D0CC051E8D73F8F78A73F8C02853FF2650040B2D47ABE9A6421406F8931C0FF08F4BF16447AC057411140B3935EC0D54A923ED1BC8F3F38CC1340FD989440D77601C0B8A097C0351B88C07C227D3E180B7840550832C0877B4040CD2A97BF74153FC0F3008FBD6DC690BECAF5E3C06E004840A4F1E03F27A1253E9D0B64BF0FDC8C3DFB7AB33F603C49BF418031C0440671BF89EA9DBF7F31243F2EF119400B2EB440B2A40E3E1F8F183EC0FB214097B623403753D8BF3070474043A89A40743034400F6C233F5226D2BF14DA71C0D64FC63E42FCA03F90CE4BC0F999C9BE64FB6B3F85F74940EAC4BABF664446BF28426DBDC58CD33FC398CCC0C1F687BFA1A3FB3F027FA4C0F5C99BC059AAD6C0953530C072152BBFAECD7EC0F5A7A0BE54CDFBBFCF8E82C0C8B3C340AD62CDBFE4D054C09F0694BEB1DE17C0CDC9163FB5D0E93E06900D3EC453F63FF83BD2BCC52BD5BF5E03E63F73999240F84175C0989D753F92C12EC06F2B62C0103B4640C8D93D40F3E8A2C08C2708C026ECA13FE2CF65BE67389540344A10BFF068DB40AA1215C0B7A38ABEFD95373F7C6AB0BF58323DC0D1E707C073F79D3F0492203FC50A93C0B403AABF748632C01044393F002D74C075CCFABF7BC002C090985A40C220A73FC6D4603E354DB4BE3E15A93F411F31408DDB8A3F4F3B19C0CE0531C0CA9D8B40CCA325406C1288BD24A48E3F2413E53E09A765C0BE559BC00E6AB63E92281F400CF9AC404927B1BD9E6BE53F4AA8A2BE94C7C93F3C4E8D40DB386F4078FC34C062456FC0B0EA84BFBF41154061EAE0BE"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x17766C3F4E72FF3F40501C3FFC3E8E3C3BD3BE3988E1FF3FA3FF803FC59D5E11B23FEE30509EAC39E0C2FE3F228FA73E59EBFF3F36FEFF3F0EFDFF3F8372023DFEFFFF3F9C11DE3F4F665B2BACF9FF3F8AD8A32FE1FFFF3FFDFFFF3F012CAE3F3A0CF53FB932AD3F500EFA3FFE7C53390FC4503BC05CFA3F0000004030AED63FF3FFFF3F44A7FB3F9B0C663AD8E85B359FD6963FB787F33FF031F02A84CB8A3EE8E7FF3FD3F1D33CC083073345E5C539D498883F3A74EF3F20781C3279841C34A47F973EF53FA13F8C8EED2A1CFBFF3F3F5F163F9392FC3F0D38DD3EDA5BA03F5213352A11D01B3D8703F73F6E81F627B08AE03FD4CC7B3EAC711E3E98A9A53F2DE3FD3FC8EFFF3F96907A3F5FE9A23E4DDFAF342E01F63FDA9519396925173FA5DD9C3AB0FFFF3FC75BC43FD2687A3E2353B33FF1B4363F0B5ECA3FF3FFFF3FDA4E073E000000406AFFFF3FDDCBF73F86479B3E409D923F8A6CFE3FEFE1A5337D151B3F00000040DC51D93EFFFFFF3FCC769F3B6826E43F2304273891CBFF3F22AB8D3FDCCE8E3EEE5EAD3D6B35E83F740BFE3FBBFFFF3FD6D9FE3F7DF6FF3FA03BAC3F686185320000004000000040A815AC3D9FB82D3E0000004098F4FD3FAA581D3D8A8DF43FB9FA852D53E8FD3F9382FD2E0B600B3E2C65513F00000040000000403D02673604D4F93FFFFDFF3F372BEF380C67313EFF51FF3FF90DC032ACE0E133000000402E53F53FAAFFFF3F84FE272934703D3FDB55BB3E82B4FF3F7D44203E406DFF3FA09AE93FDC05C52DC4C61E38D0F0A93C0000004089459B3FDFE180010000004038FEFF3FD0CFC73EA5A2853FCF5AFE3F60EBFF3F0BC84119933DE93BD7B5E63F50EDFF3F0C55053F96FAFF3F4DAE1A2DAD15143DE1AC0030C2084A3DABA2FE3F3B7B80390E435C3CBBE8273B3648F63FB134D53C7C9C2F3DD6987D3E939D653F4C672A2200000040425B3A2EC2BA983FAA3A3B3D63ADFF3FF8616B03CB5AB93F5BA8801FF39E003F376B3D0F75BAB72ADFDDF43F03FE813FCF21183F0000004013E81C3FACC9362600000040159BCA2E9AD45B3C8DC444296951C23BCFFDFF3F9EF9FF3FEC8B353F000000401333FE3F8B18F63F3649793F26D3B93FCDDC093D6289E52952BF193F23484831DE494F3F355240349F2111395F6FDC3F7BFCFF3F8270E53F0590773F67E21D3F68CF233B77DD623AFEFFFF3FF9E0DA3071D2FF3F00000040A6F4FF3F12664E3FFD78FD3FC36E2C3D89CFFF3F130E613EFDFFFF3F4810BB3F07E6F63F271B413E00000040000000403085D43F93C85B3CF9D7DE3FF974953D68FDFF3F7E34FA3F8FFA093D6FE476359E822E3883B3DA3FDEBB413000000040825ABD3FCD8DB63EF5FFFF3FA395FF3F4838F33F27D9963F62B1D23F0EACE83F76E6E43FC859493E4A77DC37B1D5BE3E1BC2FF3F70BC8B3C699F833D6014113E481E953B1AAFA23FC1CFBD3923FDFF3F341AFF3F000000404326AE3AF9FFFF3FD2A72F3F9FEBE53D9E058F3AF890612E8675FF3F000000400000004032053A3F3E9C353343FDFF3F9EB2B037D5DAF33F35FFFF3F9C118A3F07C7A73F00000040D9022637A613543C5AAE513F8B68E53FD5296C3FB604423DB2EADD3F20FDFF3F7C92E83FD3A0F53F2A90BA3E1F922F3ADA30F2261305583FBA47553F4C95B43980E79B3907D8FD3FA9D72F379850102D67858F3808B8BB3EBD68FD3FFFFFFF3F7177153F10359A3DC8FFFF3F3C10B63F18FA443E7BAB07370000FB3F7301DD3F595B883F421C9F3C0000004064F8EE3FFAFCB13B000000400000004000000040C4FCFF3F1DE4D33F0000004033E0AB3FFF4EFF3F00000040D6D6BF22F605FD3FEAFFFF3F5B9FA83F14E6FF3F2748CF3E32B5043FA251583F26E9D43BB0B4833F6CA1FD3FFEF0343CCB41CB2EFFFFFF3F9406333E4FFCFF3FFBFFFF3F49D146378DC0E4370000004001AAFF3FC1C2963DD9E09F3F82723B2EA78CC93F6658BC1BA5DFFF3F9E2CA63F8EF99E3EB26FF93F0CFFFF3F6FA8FF3FF5BFA53DEC07C03E000000404747F83F62FDFF3FF3B79C3EFFFFFF3FDB48FF3F7581FF3FDEF1B63599BE843DB694413FEBD5B03F9CE87C3DC478BE380DF9FF3DC2E8FF3FFFFCFF3F07713B30EA2684390B95893F6895EB3D55E3063FFDFFFF3F0000004001471D3F58E1E439C717BD2862768C3F045C383C0363AC3FFB43D33CB328E92F4A280634EBFDFF3FFFFFFF3F4DD4ED3F3C237F3A9297BB3F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}

