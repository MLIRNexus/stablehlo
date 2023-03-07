// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[0, 4]> : tensor<2xi32>
    %1:2 = call @inputs() : () -> (tensor<4x2x3x5xf32>, tensor<4x3xf32>)
    %2 = call @expected() : () -> tensor<4x2x3x5xf32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<f32>
      stablehlo.return %5 : tensor<f32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1, 3], scatter_dims_to_operand_dims = [1, 3]>, unique_indices = true} : (tensor<4x2x3x5xf32>, tensor<2xi32>, tensor<4x3xf32>) -> tensor<4x2x3x5xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<4x2x3x5xf32>, tensor<4x2x3x5xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<4x2x3x5xf32>, tensor<4x3xf32>) {
    %0 = stablehlo.constant dense<"0x497293BF80AB3DC05A3BA4C00CFFC0BF30D72F40E6A8C9BF393611C0D5A5BF3F3395D0BD8A6A90BF0516983F35449A40D20472BF4AE2E140FE29694026D776BF272CDB3E2C3C16C08B262D407101693F4DF8EABFC96157C0E63B9A3FD46763C0134195C06D2958BFC01EBFBFA5B66ABE3B44EBBF85E64740BA9C12C0D56D0BC1ED4A8FC094958BBFD8E84BC0598F7A3D9D9582BF6242714095E3A4C0895D3C3FF5B5B03FD9108840DA5CBEBF9A535940FF8E4EC0DACDC63F3FFB7EBF536222402A1692C0B8F405401E8C284081AFBDBFFB61DC3F86FBC53F6D51A33FB1D069C07A24CDBF021F0B41147693408628DA3F0214A0BE5EBEC63EF8E128C0AA6499C066AB364020C6D93FD45E974088C92EC01DBDB13EA59C30C01354A5401F9DAABF68DF653F766B4E4080B50FC0BEED8BC09258CABEA3D803C06D10CBBF6B97B0BFEE0308C0505446BF6064E1BF046FB83F1D1808405A76843FF40FBAC0473D054080E75A3F007B833F943FC03FA95A48C0F9F8D93EF6F9EE3FBD6A263F8BF777407D3128C0D9B8783FCB225A4052F827C046AA6E40172989C000029BC02AC44F40D1399DC05B6FEB4069FB3740420163BE04FE313EAA6CDDBE9B26ACBF937BC5C0993FF1C0CA7F033F9FFCAF3FDBD2C73F943C1A40841185BCAD4E8DBFA8F79440"> : tensor<4x2x3x5xf32>
    %1 = stablehlo.constant dense<[[-0.373634964, -2.38253856, 1.77959788], [-1.46572983, 3.13541055, 0.21541281], [-1.22938967, 5.03360939, -0.311956882], [-0.124284245, -1.98595726, -3.51295066]]> : tensor<4x3xf32>
    return %0, %1 : tensor<4x2x3x5xf32>, tensor<4x3xf32>
  }
  func.func private @expected() -> tensor<4x2x3x5xf32> {
    %0 = stablehlo.constant dense<"0x497293BF80AB3DC05A3BA4C00CFFC0BF8DED1740E6A8C9BF393611C0D5A5BF3F3395D0BDC8B060C00516983F35449A40D20472BF4AE2E1407687AD4026D776BF272CDB3E2C3C16C08B262D407101693F4DF8EABFC96157C0E63B9A3FD46763C0134195C06D2958BFC01EBFBFA5B66ABE3B44EBBF85E64740BA9C12C0D56D0BC1ED4A8FC094958BBFAEDB94C0598F7A3D9D9582BF6242714095E3A4C0F3C17740F5B5B03FD9108840DA5CBEBF9A535940ACC540C0DACDC63F3FFB7EBF536222402A1692C0B8F405401E8C284081AFBDBFFB61DC3F86FBC53F6D51A33FB1D069C07A24CDBF021F0B41147693408628DA3F0214A0BE5EBEC63EF8E128C0AA6499C028FACF3F20C6D93FD45E974088C92EC01DBDB13E038A11401354A5401F9DAABF68DF653F766B4E409AAC23C0BEED8BC09258CABEA3D803C06D10CBBF6B97B0BFEE0308C0505446BF6064E1BF046FB83F1D1808405A76843FF40FBAC0473D054080E75A3F007B833F943FC03FA95A48C0F9F8D93EF6F9EE3FA599063F8BF777407D3128C0D9B8783FCB225A401F8993C046AA6E40172989C000029BC02AC44F40F4D106C15B6FEB4069FB3740420163BE04FE313EAA6CDDBE9B26ACBF937BC5C0993FF1C0CA7F033F9FFCAF3FDBD2C73F943C1A40841185BCAD4E8DBFA8F79440"> : tensor<4x2x3x5xf32>
    return %0 : tensor<4x2x3x5xf32>
  }
}

