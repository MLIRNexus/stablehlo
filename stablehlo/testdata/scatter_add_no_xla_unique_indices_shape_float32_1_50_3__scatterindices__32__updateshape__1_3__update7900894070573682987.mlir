// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<32> : tensor<1xi32>
    %1:2 = call @inputs() : () -> (tensor<1x50x3xf32>, tensor<1x3xf32>)
    %2 = call @expected() : () -> tensor<1x50x3xf32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<f32>
      stablehlo.return %5 : tensor<f32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1]>, unique_indices = true} : (tensor<1x50x3xf32>, tensor<1xi32>, tensor<1x3xf32>) -> tensor<1x50x3xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<1x50x3xf32>, tensor<1x50x3xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x50x3xf32>, tensor<1x3xf32>) {
    %0 = stablehlo.constant dense<"0xE21ED03FEC4919C029FFA53FEDCAD23E9EE44ABF9F736F40C69A853EBA74F3BF7362B8C0911F8E3F9B5721BFB0FDADBF7DF6984083D6104091C0414016E5F1BFCE962AC0825BF6BF3BFF97BE13F75FBEEC9C8EBFCFC0A0C083703FC0B1D112401FB6A53E9AE420C06D2B393FCB4FE23F47B819C0C1682040262EFB401F0000C0FE923F40E912B4BF27E500C02C97204063750EC069FDB8BF8074B33F16404F40E152104042DE1BC0B43912C1ED84DEBF5EBC96BF1B6CA54055350E40542D893FF03661401DB08FBF21EC093F1099D4C068F56BBE15DCBBC06596FABF926ED2BF689C9EBF21FAF6403FA11040C1192AC0647DE8BF9DDB06C0B62031BF45740DC0004CBFC09308E43FCEC23E40C9F47FC0D62F963F650246BF9626C03FAD9790BF27E288C020D012BE42CD013FE4208FC022EB56C0562E8CBEB06F533FDD80B540422A35C0C48076BEECBF6FC06F3A364073EA98BF79D5BC3F92ED324056947CBFC3F184C05C7787400218BF3D5D38D0C0CBB756BF86E07340EC38CBBFA2B7B53F6397CC40F5453FC0C153DEBFE3A405C07A526BBF9580A4400D7F06BE30FF36BE9434CBBEC45D073F0F9C26BFF7C37B3F2A0A64BFEABBACC02DD04D40D6F83BC0B6A23FBED8D682C0003283BE72FE4BC0B6C44F407F4984C04783B6BFBAA21640613E06C0C772B6BFD78D87BF26740BC00ECCBF3D5A119D3FF5E7D23F71C9883E3667823E3192713E9EE3C7BF27E99F408FFD91C03FCBA73E9D2F29C0ABAA31BC268712C0515581BF751061C0FCE742C0BA73A7BF8B6E873F914B60BDDDD5F93FC626BC400B0A06C0BCD61040A76553C05FA6D140CC1D7ABF"> : tensor<1x50x3xf32>
    %1 = stablehlo.constant dense<[[0.107733563, -1.25646389, 4.33431339]]> : tensor<1x3xf32>
    return %0, %1 : tensor<1x50x3xf32>, tensor<1x3xf32>
  }
  func.func private @expected() -> tensor<1x50x3xf32> {
    %0 = stablehlo.constant dense<"0xE21ED03FEC4919C029FFA53FEDCAD23E9EE44ABF9F736F40C69A853EBA74F3BF7362B8C0911F8E3F9B5721BFB0FDADBF7DF6984083D6104091C0414016E5F1BFCE962AC0825BF6BF3BFF97BE13F75FBEEC9C8EBFCFC0A0C083703FC0B1D112401FB6A53E9AE420C06D2B393FCB4FE23F47B819C0C1682040262EFB401F0000C0FE923F40E912B4BF27E500C02C97204063750EC069FDB8BF8074B33F16404F40E152104042DE1BC0B43912C1ED84DEBF5EBC96BF1B6CA54055350E40542D893FF03661401DB08FBF21EC093F1099D4C068F56BBE15DCBBC06596FABF926ED2BF689C9EBF21FAF6403FA11040C1192AC0647DE8BF9DDB06C0B62031BF45740DC0004CBFC09308E43FCEC23E40C9F47FC0D62F963F650246BF9626C03FAD9790BF27E288C020D012BE42CD013FE4208FC022EB56C0562E8CBEB06F533FDD80B540422A35C0C48076BEECBF6FC06F3A364073EA98BF79D5BC3F92ED324056947CBFC3F184C05C7787400218BF3D5D38D0C0CBB756BF86E07340EC38CBBFA2B7B53FF109D040EED787C0843B2640E3A405C07A526BBF9580A4400D7F06BE30FF36BE9434CBBEC45D073F0F9C26BFF7C37B3F2A0A64BFEABBACC02DD04D40D6F83BC0B6A23FBED8D682C0003283BE72FE4BC0B6C44F407F4984C04783B6BFBAA21640613E06C0C772B6BFD78D87BF26740BC00ECCBF3D5A119D3FF5E7D23F71C9883E3667823E3192713E9EE3C7BF27E99F408FFD91C03FCBA73E9D2F29C0ABAA31BC268712C0515581BF751061C0FCE742C0BA73A7BF8B6E873F914B60BDDDD5F93FC626BC400B0A06C0BCD61040A76553C05FA6D140CC1D7ABF"> : tensor<1x50x3xf32>
    return %0 : tensor<1x50x3xf32>
  }
}

