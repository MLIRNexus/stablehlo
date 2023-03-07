// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<2x3x9x10xbf16>, tensor<3x3x4x5xbf16>)
    %1 = call @expected() : () -> tensor<2x3x6x6xf32>
    %2 = stablehlo.convolution(%0#0, %0#1) dim_numbers = [b, f, 0, 1]x[o, i, 0, 1]->[b, f, 0, 1], window = {} {batch_group_count = 1 : i64, feature_group_count = 1 : i64} : (tensor<2x3x9x10xbf16>, tensor<3x3x4x5xbf16>) -> tensor<2x3x6x6xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<2x3x6x6xf32>, tensor<2x3x6x6xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<2x3x9x10xbf16>, tensor<3x3x4x5xbf16>) {
    %0 = stablehlo.constant dense<"0x77C0B54027C0A1C09A406FBF8F3FDA3E8ABF4A404340733F68C02640C6BFD93F4A3FBCBF673F5AC053BF9A40F43EEF3FBE3F39BF853EA3BEA33F744063407EBFE83F63C0013D25BEDCBFB040D940BB3F01400EC07EBFB6C029C02DC0173FDC3FE93F723DAC3E1BC0B4C0F93EFE407340B9C0DD3E4E3E67405C40E0BF884070C0EDBD54400D3E623F95C04E3FE2BF7A405FBE4A40C83F1FC0433F78407AC073BD15C0EEBFCC3E4C4052C079C0FF3E0CBFB5BF8040903FC33F06C0A740DC40593F9A40BAC01E3FAA3F014057BFEABFDE3FAE40ACBFE13D8C3F5D3F623F69C05340B040C03FD63FC43F86C0293F99C0C240863F234062C045C08F40983F1C3FB9BFBEBF53BFE13FB940F73F86409DC086C0783EA2BF893F8A3F38408E3B85409640B8BF20C09640CB3FE1BEE3BF43407840C7C092C008C0523F99BF4CBFD73FF73D46C03BC0E6BF3BBD204055BEA5BF993F6C40C73F073F9A4027406CBFAC3F1DC06FC0E13E50401DC026C06BC08EBE294029BFC9BE0F4120BFABC0303F8B40864031BE2A4080BE7540AEC098C00F3E304006C002C016BE8C40A3BFEE3FB8BFE7409E3E753F07C05DC0B3BEF33F3340FDBF5E3F06C07ABF01BF03C1754029C0E53F923E45BFCD3E90C0C0BF8E3F61409F409D3E49C033C0CDBFD63F8E3E0440454095408F3F4CC09B3F71BF38400040574033BFB7408C40454029C09C3D65400D405540BD3D10C0E6BF46C0E8C0113F75404A4074C08CC0CABF16C0ECBE10BF523F75C01ABE023FB73E8640BC3FAD3F6EBD4640513FB7BF493E3ABF36401B4089BFB7BC913F93C08B40044037BFCBBE17C00F3D6EC007BF3FC0C9BFA0C0EB3FB3C03EBF19BFB33F69BFFD3FCE40A7BF8ABF00C1B5BF6C40A0BF27403AC0FD3F71408BC090409F4006BFC5BF8DC0823F323F123F30BF4EBD8940014044BF6B3F87BF78C0CB3F6AC0D8BEB73FC04027C0BDBF4C40B7BF18C048C0A4C035C0F4C0A3404C407FBF71408DBF96BF6AC00040863F4D40ABBF233F2640CB3FE640A9BEE03F70BFA5C098C035403ABF6A3E884086C0BF40E63FE7BE913E6FBE1EC0D63F3FC00FBD10C0FC3E0EC033BFA23F1FC0583E6C3F63C0FA408D407640E3407B4020BE2FBF0AC0BE3BC33F794061BF83BFDB3F90401540B440393F3D3ED4BF343F71BE80C00B404F400F40D83FE53FE4BF34C0B54075C010C0353DBCBEB3BF833E2940E2BDFC3F08BF0C405BC0D44039402340794041407340A03F80402BBF143F50C020C0A3BFAEC00E400A405BC02CC0B7BD40BF94BFCA3F63BE8C404DC0F03DAB40D740ECBF2740F1BF6BC097C0DFBF0140EABF6D40473F86C0CF3F3240563F7FC0024001C0A7C0563F8ABFF0BE813F8CC093C078C0A4C076C01140D5BF2640914000C0934043C09EBFB1C0A4BF473F1B407C402C3D9640B53F34402340E53FD8BF9640814083C0EFBE903F85BF49BD39BF82BF8E40DBC0173FB8BFB8C0294004C14C40174001C0394015C0C6C083BD1A40304046402AC0A1BD"> : tensor<2x3x9x10xbf16>
    %1 = stablehlo.constant dense<"0x9A40B6BF1F4066BE6EC0EE3F033FB0C0AA3E7ABEC03E8ABF89C03640753F004067401C40CA3E5F40EE3F31BEFEBE06BFD03F28BF27C0B13FE53E3ABEFABEA1BF2FC06B408140754089C052C0FD3F22C08340843F84BE474035C08F3F2FBE95C05AC02E4081BFC03F6E405AC0E14002407A3F83BF813E2A3FD7BF403FEE3F99BF753F0BC0EE3F58C083C0B240C740D33FD7BC57403D3F56400DC076BF61400DC030C099C08ABF1A3FD63F834062C0BDBF5E40BA3E244012C038409540D8BFB33F17C0A73E4EC0EB40C8C011C01240DEBE76C00A3F0A409CBFA3C0E5BFE1C0E83F3B3E22C08BBFB8BB3AC028BFD2BFAE3F8E4001C02AC0A6409E40FF3F13C0C9403740593E05C04440E1BF87C05040ECBF1C3FD8BD8D3ED4BFACBE7840F64097C0B03F7C407040D7BFBC3E113D073E223FD4BF7640BB402FBFCEBF03408CBFC6BC23C00D40274010C01F40AD404FBFB43FACBFEEBF9EBEA3BF8140E2BF9B3F7BC0F4BF19BFEEBE5FC0"> : tensor<3x3x4x5xbf16>
    return %0, %1 : tensor<2x3x9x10xbf16>, tensor<3x3x4x5xbf16>
  }
  func.func private @expected() -> tensor<2x3x6x6xf32> {
    %0 = stablehlo.constant dense<"0x92F380C211FC6C429C2BEEC2E0CF30C0D9E2B342703EB942C8081041545380C17A43D2C1467F70428C0E30C240EBC1C12A171DC243D064C21EEEB641765D40426BE73F42ACB243C218889F4292593D426CF4FDC1110B62C2A09F8C41A70C7642583287C0F048A7427AF2B9C10CC960C182AEA541D6F0F341848391C2D4265A41C8355F426B46BCC1F8A4BBC000848E40BC75EE42A74C8D42803958C0A4F62BC30A9BD042F41197C291603AC3CA6099C1F4048342D056C8C2B0B971C000220ABE76149A4108B8CAC114BB15C2CE58C8C23F56F6412A06E4C155B9004276E36742B8A36AC145E39242343A9C42603C243FFC80454246DE9CC2DB6E89C2BAE8B1419836A542B6F592C2F27848C25E1737C245B0C8C2BA7F4542D033A8BF27934FC2624032C294C711433BC6244221D0EB4109D93D42156F8742F8951D412073B042199C1B42DDCF7E4240D4BFBE901E80C2E607DD40986CF1C084F857C1905A7A4238D1A941E3959842A8506FC2905D04C3B2B5F34115F4A3420C61954247A571C2BF866EC23432F842E53F5B426431D2C2BE8191C20906D641F67C3A43EDFC9A42C44933C25EAFF0C233FC75423D172443B8D9E0C2DA459EC208EF2EC2ECBB08C3CFC21AC299A80342C8DE69C2F49535414D9A874164887F421F4B7F42B29417C253CCBC423AF6F6424AB47DC1C41EAF41123E17C27C109A425CC5814208D42F4107855AC20C099FC1B2ED5742084C47BFD3DEE5C2F0C41441FEC578C2DADA93C265874642A4E4A1C2AEBCD7C21E343B424C6852428445DDC2A9B71A434AE8E3C14094B93F3CDB7EC160D95F4234E618C282BBA5C13ECA4DC29562DEC2C05CFDBF1E8A8F42C9E8E5C220234142DCC88442EE53BF41FA2FAD42640695C28F5B55C244A9E142C8AAE542051FBA42E4CC29C14FF93442AC76C3C2E6486141C2991541B58366C22EDD0443375CDAC138F9C7C20E9D9942D817BB40362E8E41A6B2AA426CF8D34185E3FBC2CDF9A141FABD4642ECA78041923F33428097EDC088DF17439C4CAB42633D8C41003E38BE58D0DE421F3D00430A4B18C2C0414D40FC9C18415C02904260D7DEC244442EC25A86EDC14026AB40A8099042311EBEC23059E5C24459BA4252EE4EC1CA17E94297E4F642989A9E42B0873142AAD8B3C2B01AB7426098703F40697EBFAAA81042F70A92C23D98CB419A819042A83F9F41E1468FC2"> : tensor<2x3x6x6xf32>
    return %0 : tensor<2x3x6x6xf32>
  }
}

