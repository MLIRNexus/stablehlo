// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<2x3x9x10xf32>, tensor<3x3x4x5xf32>)
    %1 = call @expected() : () -> tensor<2x3x3x0xf32>
    %2 = stablehlo.convolution(%0#0, %0#1) dim_numbers = [b, f, 0, 1]x[o, i, 0, 1]->[b, f, 0, 1], window = {rhs_dilate = [2, 3]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64} : (tensor<2x3x9x10xf32>, tensor<3x3x4x5xf32>) -> tensor<2x3x3x0xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<2x3x3x0xf32>, tensor<2x3x3x0xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<2x3x9x10xf32>, tensor<3x3x4x5xf32>) {
    %0 = stablehlo.constant dense<"0x4B9632C0F3571AC053E609C0D799ABBE8ECC8FBF62A73DBF152394BF148A14C06B8276408D91CCBE41C9C9BF3E50AE40A17E85C0E43694C031D0A140EC23EA3FFA67893F00194EC0377FFA3E09E6ABC0641B653FF2631EC1AB788B3F0271E83EA5E394C033EC553F495298BFC64F2FC0B756A3C0A73D43403181CEBF027DEA3F9EDF1E3E31BC30C0C1ADD4BF8CED123F05C452C0608578C0E7DB383FAA5351C0DF8A6CC0589A13C069B5583FE7C5533FC7753BC013A424C0E99B0640D7BA80C057CDEABFB7BED1BF2E7AD83F480DB8BF0B44623F161FAAC0B691064044F606C0C231124166FA93407348873DD06ECE3FC1DEAFC0C2279BBF8EDE2B3E15699FC01CF9024017C70CC018441C407E21D1BF52CD29407F8F80C035EC8F3D2F468B3D6F1055BFC56E913F53E08540AA1691BEAC2E893E14E35940FB00CEBF8A0659C0B56162C0F3558240F9609B40BAA35140D79261C079146ABF877183C036EB73404E41AEC05EA44E3F5ADC91C0CAC9CD3F9E3A0340C43B18BFD36AC8BF08CDB63F1078D23FF747063FB65729BF624218C0E76DBE40CB4A46C0BB49873E8C4C7F4020282FBFBA2E8D3F0A3EFD3E2B3484C01B280D3FBD3F1EC0224A3CC00C3596BE1D7F26BE3D4EB0BF27A0753FAE6C3B40229B13C0AC0D0340AA5F80BF8FEFB2BF2FEE71C01C26C4BF5BA43F3FA840D0BF9438013FF2148E40E358803F274406C06F6713407B97894005E394C0008F983EE3ED5CC0985426C014B76FC0548303409D136F4049E202BE8928FEC03E4793BEF3FD0440EC0C1940E937FCBFEE77913FBE9AB73F0AFC823F32E09E40A37C07BF80DF3C40F81F703F27CFCD3E214E5EBEFC8C9D3F913F8DBF2CE47B403C073CC03E59B3BF88AB03BE5C49523F6B5BFE3FF52E933FE621744055F7AEC04A83A83F6F5B95BF4214354046324F408D0AF03DCF6918BF539E9440745E0EC083A878C0EE564BC087DE32C0C3954D3F437ACA4020C31D408D5DC9C0A511A240F1E800C007A29DBF47B64640A57236C089A201C0D036C9BE81B8EF3F716A25BEECC31CC13A12D03FFFB4A9BE5729AABFDE0D803F342D7C3F689E9840A81929BF5BA873BF1E9918C0833522C0A4AC91406FC22DBF644D5DC0B8D40A40796666C0D08187C05DAE303F6195E23FDDF7DE3FB620D140DF3F343FF3C97E40E63E4740B0DAC0408C5CCC407A2C8D3F7A6C29402812A7C0A41F7FBF83197B4043F7543E07C4EABF59C7823FBC233A4041F6CABF9B4F23C063EF044128515640444184BD0EA40E403BC6B1C0DA8FEFBF823A00C0C5DC2F408D713C4010E0D0C0CB107040E86DDF4066C057BEE810923E471BAD3D8476EE40C26970C0339A0D40344A4D40528FA3BE8714DBBFB9DA40C0A03DDB3FFCED4FC0DE441940331471BF2A8EFA3F98FFD53FB1DF4E3FCE8A03C1E5538B3EEE7610BFB8EE903F108AE740CA704BC0FE8A50C0D3110C408EEABEBF7B39B14025AB91C020FD17BF76F02FC08BEB1AC08528E43F0C76BD3FA82EAE3E7B0E8040002E60BF980FACBED76DD53EB0B417C06E473440F98CA83FDF92EC409C9A50BE7E7A8ABE1AF6C1BF945D143F0C5F76402D677240A3BF314081B2833FAD48A43F7444D540D05BD0BE55D3A8C008ECAEBF1DACAD3F83D989C0FED61CBFD29569BE5ED0B2BE26598BBF478B1FBD3CCB3040DE3AB8BFE14D79C0BF5223BFD0CE2BC0B7AFCABF99DC1C40B2E70DC03952C740FF797DC0D07DAFC03EA962BD09AF8040AE00A7C0A85188BE15D6454025263ABFDDF083C0294406BF61D89D3F19F5D73E943DAFBFBAE12DBDC3928EC0AC7F65BD853914BF1CD4C3BFF88DDDBF1FBF1D3DB3F88F40A21016C05A2315C04C0FF8BF887A8AC0D86C43C00F4C05C0230A043F53300B40F0411AC07D6C8DBFD44E9ABFAB7B28BF637F3340DE8E0D3F4EF42D4057C32A40FC64F63E85DF464053E4A13F4544B840B803C8BFA2B3533F114BB63FE7DA8C4061DC88BF97D36FC0FBBE5FBFEB6D82404EB70540399F08BEFF69993F4CE81040B87F4AC0FC3EB83F81730A4089129D40365CAD3FAE0634BD091D55BE0ED674C0BC778140E578DE3FD2B5E2BFC29B8340B6F71BBFE4B22E3E040BBD3FC22088C0D86EB140E86AC8C02AEF6BC0F340A4C0E991B13F451A0EBF87C80F40F8AF9640818A85400A7644C0F143BB40ED40AFC021A469C0408D873F554652BF8ADA953E7D5B393F873E7F40BCB207C0254AB83D1DFD6BBFFFF60D3F54800AC0799CF1BED39A87BEED893BBFE18FE5BFA4F0AC3F8A49883F426072C0722F4640BD49813F04EDC1C0F7D3D23E5C309CC0B30E723F924702C020ED6C408A2B513F04453C40CB69A8C0F6FDFF3F2214D14007DCF4BFCD5AA23F90EE9BC0F05238C03B76D5C0928968401D0584C0E4FA73BF14883AC051D4EFBFFB7EFABF5445B03ED7FBA9BE2BBE69409C219640806ECA3D48DB1DC0BBD29C3F0DE1853FAB07E13FCD912C3E6DA3A1BFC7073ABE110BE8C0D60F84BF44751640A78B1B40784F7840DB1A5F3F917BA340BA18A13FE95296C070CA89BF4B8C86C09D495F3F5C5BB8BFDE6CC03FF7673EC0E7BA9F40C006EABF64792FBF39780640688131BF985D5C405EA3FC3F76FBDA40D1BCC3BF289ADCBFE88526C0DB7BB8BF2EE73D40E96C5640DA3213C0C584CD403B00C03EB04C00C07A6F043F7520C0C067DF22BE06EBD840FCF681C04CF82DC0A8166CBF1B455D3E283AE240A134203ED82930C047778E406AF5B2BF73102E40556907C06BE30DBD00F40D407F8F42C0C1B0A83F36CF6E3FC3A65CC05CF3343ED3E1AB401189403F10C10DC01DFBD5406866AE4081740E4075BF9240AB514940BF7F08BF98602740A457D7BFDA8F1EC0EEB6F63F6B7E384003EECCBEE27E51BFDDDBB9C044FE2C40C1D7CBBF77DFEEBE92550CBE68361CBF001BA840F2EAC63EACD523C03EA188BFB3951CC007F25CBF6994B33FD9C78DBF73B55EC0892A07C0AE1C18C06A424B3FD13104C1C5B6AAC0C691BD3EACA3983D133294C09784B6BF25AB6DC0B4552FBF6342A93E"> : tensor<2x3x9x10xf32>
    %1 = stablehlo.constant dense<"0x821CFC3EE8B303C005FA09C07E6EC4BF16DD76C0A880C23F6FE55B3E1B0EADBF7EDBB43F1010D3BFE7AEB8BFCC72ABC00D2C5040AACE75C017094140DB3C613E63FDFABF95821EC029FE43C038FB06C0C6F97F408D2E4C400544E8BF27D3893FDE90213FC81425C095536A3F861D693FF5A6363EA6BE38C0D7DABFBFC144E8BF331D3940791FBA40298D77C09FE2F8BF44A5073F2453B4BFE8ADA63D2B369A3E4B69F6405AF31E40C7F88A3FEC7F1640BC298040E86E25C06A5C9C40F6A09DBF166167C0177FD13F0EC40D3FCEA2993F92207B4068E7ECBF659BEBBFABE889C01152AABFBD4AF5C04F6E28409D2A8CC08689B9BFED724EBF244B1840BA6C9F40B34D5640916BD9BF166B934088495BC0F2E185C0A2451BBF2ED407C02851F4BF55791E4060B5D0BFA7D0134083B80B3FB8CA873F5E687BC04A5B5BC0C3E82E40B75AF940F44F3BC01F0D9AC0644D0641829A403F7C3A523F0A0835C06DE381403EAA40C029F92FBF0B2B3BC022AA6FBF9CE0F63FE5812EC0B68533C0F3F5354081A48640CE1627404A048FC0BEA9A7C0CAA406C095900E3DA5AC004078A42E404F7E2A4015CE12C0CE471CBE453D253F15D3B94096D34B401D83DCBFA62E133F57E98940A5B40B3F189C653FCE818740D98E25C07A12613E88792740E550A6BE65BE89BDE252DB3FDDC009BF481135C0838F1C3F82CB9E402FE3E1C07B3C60BFC7FB0640F4CA6D3FDDB3CE3F8D4A0F3FE30757C00796A7BF944F8A3E372FFFBFA8FDC4BFCE0BEC3E085D96C0EC0F043E5F4E89C0312E1FC09C4B22C0AB2B60C0CC389DBF2745113F8B8170C0234FA1C03E882DC03A5E0E405CCD633E37F3963E1532563F325BF1BEFDA67CC0D570803FF441FB3E69B7A33F2B66F9BD9B69B33F875985C039F68A40655D303F86991EC076EFD33FC2AEAAC0BF196740B13F2B40D751A2BFD16A524015DD9DC0172827BF0B78A9BEC0116D40EE1B223F39F0DDBED617E440327ABC3D57418AC0F9A3C5BD"> : tensor<3x3x4x5xf32>
    return %0, %1 : tensor<2x3x9x10xf32>, tensor<3x3x4x5xf32>
  }
  func.func private @expected() -> tensor<2x3x3x0xf32> {
    %0 = stablehlo.constant dense<> : tensor<2x3x3x0xf32>
    return %0 : tensor<2x3x3x0xf32>
  }
}

