// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.sign %0 : tensor<20x20xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0xBF1AD93F66417940A72CD7C03C8629BDB355ADBE2DD985C07A0516C0D05246C01E6B9BBF647E92BF1CA759BC7B1AA63E07C912C0130DD73F79B58EBF27CD33BFEE84ACC09ED83240CF793AC0E0FCB5BF8061AD3E3FB38A3E8BD40BC0B77CC03FC105DABEA84D663F6F8F983EFF21D93F2C2B2C40F1CC59402B5B6CBFB3D70FC07718C6C0276F2940ED2B28C011C6D63EA9011C40813F89402E17474066C393402B05B2C0CA6984BF88A5C9BF1B682640CDB97FBF289E353E3EC42440D6E9F83E30E149407B3B364066FD7A40EC5E26C0E93189406023F63E13C51EC0FFB06240F38107C03CAFD9BF7A410EC05F98783FD2F57C40E09FDB3F8227064009E46FC0915CFD3FB647BEBF116424C02FE2EEBFF1D59A3F56BF31BF8BF231C002FC8940D9A628BE30B48EC0110FC1BF84631140F4A7B9BF0C9B1F3F2C435EBFFFD5AB40D31F4CBFA18976408F525A3F1ECB97405F8994BFBCBE2E401E553C40B3E6DC3F702F4340B3CD10BED7F39FC097ADD1C04E877AC03688F640123F073F1DF0AEBFEF5F91407D5DCDBFFF1FA0BE8BE1E93FD4F6AFBF82187B407089FDBEF121154018F68540B4028CBFFD64DE3FEFE8E6BE108458406606883E34DA0040A79FB4BF63D74440618BB03F9C91A9BF09A583BF415CC23F323061BFC74A51409BBF2AC06ABEA240D91C83401671F73F08D620404268A2BFDA47914056E015C07B185F4063986B4073A488BF78B6A6BFA583113F0EDE923EF71C103FFE9B2F40BA23E33FFC4AA63D28212DBFF41DD83ED0A980C0D187A8BE3C709AC0C79A173F91E4FD3F39BD0B407B12993F39538FBF1245F4BEC108C1BF74FF9CBD02E65240CCB846C09AC7B040AB9B0FBF012311407378AA40D7D4B3C062DF5740C887364069691940287E25C00A0801C059C7853FD26E21C05E24214044F019BFA57876C02F726F401D8D0DC11089323FD2C3593F3D7D3B3FD94725BE1449A7C050A5923DA59A92403B230AC0C1B8F5BEC187AD403591A7BE8F82D03FFF26F5BFA33AD340DC700140E8A81FC05DDF6BC0291A98C0720066C079C354BFFDA26D40A1F8C5C029BE6CC06C84D5BE303322C01CE4203F70B59040B1841C3F6EF9A9BEE6BD08C03CDE243F71AE7FBB31383D40E984C7BE5DDB823E55772B4033D4B1C09CBB9640F56338C02F0F9DBFCB80D2BF23328F3FE45CAEC0150499BF3BCA7A3F18F72A40C274A3C0F8128A406EC4B7BF5FC3A43E5842D73F739CF73D233308BF2935D53F9F8A7FC0A178D7BF048E33C0C830A93FDCB27940254F3140AAFE43C091A4AC40DA3717BF2B38353FEA1AFA3F96A9904011F3573FB5E30A408F3D7340AD869DBFABFFC1BF44E4C03FA013EB3FFD410A3F81BF1F40E86C043F4A9F1D40BC3AB9BE178908C091C5E03FEA6884401AC30F3E0BAA724089AADA3F3510A94068854EC09DC7564011CE9E40B9B6EBBFAD336F40B214214072E838C057C72E40DAA06A4057EA39C05C17C0C00598FBBDD742A7409B71D23FD1C6EF3EAE788A3F8D59873FD8D610C07358143F21FEA4BF5C4EFE3EF2D4AD3E628E763F28E5B43FDBE8503EC04BA0BFBD399F3F16558040D12E253FAF4C0AC0FDC9BABF93A8AAC081C395BE849ED5BFB5A8B6BE666221BF1682A73E7528584038F633C01BB997C043FEDF3EBD74843FB9AE6D403B174DBF8AD92B4054D319410B2A40C0A9134CBF6103163F8B86D7BFC4B5053F1A8B86BF8ED86EBFBC8787400EB8913F0A30403F69531A41305E05403029E9BFEC108FC0F1B1C23FA397E33F5A708D40EDF284BEFD22CCC0DC4299BFF4BB08C0F08A2BC03BDB9EC08C230ABFB022CA3FDD5D92BF4544AB40E19FA8BFE2B5364047F147BD762DD23EAC64DB3E886C20C0FA2419C0B556CC3F3B9258BF3455F7C03A4FFABE2E51F23F99DC783E5D1BBFBFFE4992C0F29657C0456D0CC0F5BCAB3ED0453DBF855CA3408EA76DBD74225BC00D607C4018D5A33F510D82C0E686BB3E83C56CBF778AB8402FB7543F7FF93C40F2C0FE3F204D18C015790FC05DF7EFBF3AE0D4BFC7E0CFBF5BFD883FF74B00C0643CD840088BAE3D3F134E404D51B9C083D24040D813D1BFD80F114028CC3EBFA034804024E1A9BE111B98C0045A51C0612BDD3E5C7E15C0E39F9ABF986A494010A18E3FB6CF183FBAC40F3F0A189F3FC8BC213FAE5F96C0CE911CC04E041BC0BDBB7B404FA1B0C0FAC489BF0D071040464EE3BA406877C08268093E4B7F0BC080BBAC3FD10FA13FD858CF40"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x0000803F0000803F000080BF000080BF000080BF000080BF000080BF000080BF000080BF000080BF000080BF0000803F000080BF0000803F000080BF000080BF000080BF0000803F000080BF000080BF0000803F0000803F000080BF0000803F000080BF0000803F0000803F0000803F0000803F0000803F000080BF000080BF000080BF0000803F000080BF0000803F0000803F0000803F0000803F0000803F000080BF000080BF000080BF0000803F000080BF0000803F0000803F0000803F0000803F0000803F0000803F000080BF0000803F0000803F000080BF0000803F000080BF000080BF000080BF0000803F0000803F0000803F0000803F000080BF0000803F000080BF000080BF000080BF0000803F000080BF000080BF0000803F000080BF000080BF000080BF0000803F000080BF0000803F000080BF0000803F000080BF0000803F0000803F0000803F000080BF0000803F0000803F0000803F0000803F000080BF000080BF000080BF000080BF0000803F0000803F000080BF0000803F000080BF000080BF0000803F000080BF0000803F000080BF0000803F0000803F000080BF0000803F000080BF0000803F0000803F0000803F000080BF0000803F0000803F000080BF000080BF0000803F000080BF0000803F000080BF0000803F0000803F0000803F0000803F000080BF0000803F000080BF0000803F0000803F000080BF000080BF0000803F0000803F0000803F0000803F0000803F0000803F000080BF0000803F000080BF000080BF000080BF0000803F0000803F0000803F0000803F000080BF000080BF000080BF000080BF0000803F000080BF0000803F000080BF0000803F0000803F000080BF0000803F0000803F0000803F000080BF000080BF0000803F000080BF0000803F000080BF000080BF0000803F000080BF0000803F0000803F0000803F000080BF000080BF0000803F0000803F000080BF000080BF0000803F000080BF0000803F000080BF0000803F0000803F000080BF000080BF000080BF000080BF000080BF0000803F000080BF000080BF000080BF000080BF0000803F0000803F0000803F000080BF000080BF0000803F000080BF0000803F000080BF0000803F0000803F000080BF0000803F000080BF000080BF000080BF0000803F000080BF000080BF0000803F0000803F000080BF0000803F000080BF0000803F0000803F0000803F000080BF0000803F000080BF000080BF000080BF0000803F0000803F0000803F000080BF0000803F000080BF0000803F0000803F0000803F0000803F0000803F0000803F000080BF000080BF0000803F0000803F0000803F0000803F0000803F0000803F000080BF000080BF0000803F0000803F0000803F0000803F0000803F0000803F000080BF0000803F0000803F000080BF0000803F0000803F000080BF0000803F0000803F000080BF000080BF000080BF0000803F0000803F0000803F0000803F0000803F000080BF0000803F000080BF0000803F0000803F0000803F0000803F0000803F000080BF0000803F0000803F0000803F000080BF000080BF000080BF000080BF000080BF000080BF000080BF0000803F0000803F000080BF000080BF0000803F0000803F0000803F000080BF0000803F0000803F000080BF000080BF0000803F000080BF0000803F000080BF000080BF0000803F0000803F0000803F0000803F0000803F000080BF000080BF0000803F0000803F0000803F000080BF000080BF000080BF000080BF000080BF000080BF000080BF0000803F000080BF0000803F000080BF0000803F000080BF0000803F0000803F000080BF000080BF0000803F000080BF000080BF000080BF0000803F0000803F000080BF000080BF000080BF000080BF0000803F000080BF0000803F000080BF000080BF0000803F0000803F000080BF0000803F000080BF0000803F0000803F0000803F0000803F000080BF000080BF000080BF000080BF000080BF0000803F000080BF0000803F0000803F0000803F000080BF0000803F000080BF0000803F000080BF0000803F000080BF000080BF000080BF0000803F000080BF000080BF0000803F0000803F0000803F0000803F0000803F0000803F000080BF000080BF000080BF0000803F000080BF000080BF0000803F000080BF000080BF0000803F000080BF0000803F0000803F0000803F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}
