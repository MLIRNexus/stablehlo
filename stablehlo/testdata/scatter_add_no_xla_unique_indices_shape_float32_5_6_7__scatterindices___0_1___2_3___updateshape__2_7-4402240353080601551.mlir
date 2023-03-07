// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[0, 1], [2, 3]]> : tensor<2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xf32>, tensor<2x7xf32>)
    %2 = call @expected() : () -> tensor<5x6x7xf32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<f32>
      stablehlo.return %5 : tensor<f32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [1], inserted_window_dims = [0, 1], scatter_dims_to_operand_dims = [0, 1], index_vector_dim = 1>, unique_indices = true} : (tensor<5x6x7xf32>, tensor<2x2xi32>, tensor<2x7xf32>) -> tensor<5x6x7xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xf32>, tensor<5x6x7xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xf32>, tensor<2x7xf32>) {
    %0 = stablehlo.constant dense<"0xDCB11B40B7EC283FABA483400FD7D5BF7F6E12404CBB8DC0FDC0F4BFEB53EC3F590DB0C09980623FCEFB7740669D88BFDC839EBF6CBE6D3F4B7D2AC0CF6594C010CC83C0A79CA43E8DC29540A9C0C840990BB6BF3F2D0340020B153EEA08A9C0078F823FA8DB3040BB48EC3E0695933F51D3A33F4B9D813F8723D7BF589CDCBF7E777EC0F7495D40C4CFD5BF63BF80C072D615BFFF17ADBFD6476F409985A53DC0789740FF4ACB3F8CA02340C062AABF1F4CC1BFF7CBA6BF268C11C068620440016721C0533CF33FBA6322C0A9DC303F5E7E4740964D6FC0586ABDBFABC050BFBE997DC0C486693E2C8F78C0A1F9993F2E5FC340F739BE3F626F62403D2971C0CFEE244045E687BFAAB3943F526E23BF1E4CA2404AA31E3FFFA16A3FFF2B83BF23F906C04AC8C9BFFA7562C0E4282140E18AED3E4A9A8CBFA4D040C0DAA7C73F0BEC99C0115E3D403536B3BD23A6C63F8F30DDC039210B3F27FD7B405C7B88BFEDC36CBF67F1DD3FC15B0AC06B72A5C0ADDC903FCD6E0C3FD11D5940F70527C0D8958940902484C0356601C0F23C9740203FE1BEA30AA3BFE7D4ACBE50F0AC401031E6C08CF508C050258D3E848E364048C8B9BFFF4E9C40A00863BF9D76EA3F7BDC38C053EE78C048D6283E20500B3FCCF5433F190D25BF2FD6C9BF7E043F401A2FA4BF0BCF4F3FAA32B2BDB40CC7C08984FBBB310466C0126E1141AC23FBBEB2169B4013DE8CC084748FBFD358793F863AB23FD75516C05DE8C8C0EC9C74C0353D6D3E418A104173498B40167008BEFD2D25C05EC08ABFBA3C41C0206F4140AD673ABEACEB96BEEB5FF3BFE7A80AC03514D6BEF691EDBFFB34B0BFAA562F402D38C4C0851397C08FEBA5C0177B4DC0EF6A7D3FE9ACC7BF69B51040070EBEBF01960D41F97C284099F97D3FBFA70F3F025D83BFD4E3C83F81204B40552B33BFD783153FCF037A3D1B5BADBF22E5A0404867E83FCBE5A63E1D406440A7EC1140741D1EC045A22BC080F4ECBF1A3E5EBFC3BC3BC016736E3FA596033EE8259640AB7C3DC0038545C04D3864C04A588FC07EAE48C05CAAA9BF14A515C011C810C0AF7ECE3F2127F93EBA6D944004C983BC1E50703F2733F1BF4C5AD8BF51C8FFC00A81D83FB675ABBEB0C6BCBF337E82BF19C2E0BD88607AC09F3AC4407B37B0BFA2CA5C3F47F406BF"> : tensor<5x6x7xf32>
    %1 = stablehlo.constant dense<[[-4.43930864, 2.32264829, 0.434550285, -2.63902378, 1.37580132, 1.35811663, 0.444332272], [1.62119913, -1.9871912, -4.523190e+00, -4.48590851, -6.41206121, -2.71144676, -5.35461044]]> : tensor<2x7xf32>
    return %0, %1 : tensor<5x6x7xf32>, tensor<2x7xf32>
  }
  func.func private @expected() -> tensor<5x6x7xf32> {
    %0 = stablehlo.constant dense<"0xDCB11B40B7EC283FABA483400FD7D5BF7F6E12404CBB8DC0FDC0F4BFACF325C06D744BC0A4DFA83F142C9E3F70F39D3E802EF53D17BFAF3F4B7D2AC0CF6594C010CC83C0A79CA43E8DC29540A9C0C840990BB6BF3F2D0340020B153EEA08A9C0078F823FA8DB3040BB48EC3E0695933F51D3A33F4B9D813F8723D7BF589CDCBF7E777EC0F7495D40C4CFD5BF63BF80C072D615BFFF17ADBFD6476F409985A53DC0789740FF4ACB3F8CA02340C062AABF1F4CC1BFF7CBA6BF268C11C068620440016721C0533CF33FBA6322C0A9DC303F5E7E4740964D6FC0586ABDBFABC050BFBE997DC0C486693E2C8F78C0A1F9993F2E5FC340F739BE3F626F62403D2971C0CFEE244045E687BFAAB3943F526E23BF1E4CA2404AA31E3FFFA16A3FFF2B83BF23F906C04AC8C9BFFA7562C0E4282140E18AED3E4A9A8CBFA4D040C0DAA7C73F0BEC99C0115E3D403536B3BD23A6C63F8F30DDC039210B3F27FD7B405C7B88BFEDC36CBF67F1DD3FC15B0AC06B72A5C0ADDC903FCD6E0C3FD11D5940F70527C0D8958940902484C0356601C0F23C9740203FE1BEA30AA3BFE7D4ACBE50F0AC401031E6C048CF04BFF412DBBFDCDAD5BFA2FEBDC07082C3BF804A66C0A27661C07BDC38C053EE78C048D6283E20500B3FCCF5433F190D25BF2FD6C9BF7E043F401A2FA4BF0BCF4F3FAA32B2BDB40CC7C08984FBBB310466C0126E1141AC23FBBEB2169B4013DE8CC084748FBFD358793F863AB23FD75516C05DE8C8C0EC9C74C0353D6D3E418A104173498B40167008BEFD2D25C05EC08ABFBA3C41C0206F4140AD673ABEACEB96BEEB5FF3BFE7A80AC03514D6BEF691EDBFFB34B0BFAA562F402D38C4C0851397C08FEBA5C0177B4DC0EF6A7D3FE9ACC7BF69B51040070EBEBF01960D41F97C284099F97D3FBFA70F3F025D83BFD4E3C83F81204B40552B33BFD783153FCF037A3D1B5BADBF22E5A0404867E83FCBE5A63E1D406440A7EC1140741D1EC045A22BC080F4ECBF1A3E5EBFC3BC3BC016736E3FA596033EE8259640AB7C3DC0038545C04D3864C04A588FC07EAE48C05CAAA9BF14A515C011C810C0AF7ECE3F2127F93EBA6D944004C983BC1E50703F2733F1BF4C5AD8BF51C8FFC00A81D83FB675ABBEB0C6BCBF337E82BF19C2E0BD88607AC09F3AC4407B37B0BFA2CA5C3F47F406BF"> : tensor<5x6x7xf32>
    return %0 : tensor<5x6x7xf32>
  }
}

