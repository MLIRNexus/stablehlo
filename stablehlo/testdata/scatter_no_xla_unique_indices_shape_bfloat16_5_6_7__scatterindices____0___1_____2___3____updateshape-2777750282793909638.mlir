// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0], [1]], [[2], [3]]]> : tensor<2x2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xbf16>, tensor<5x2x2x7xbf16>)
    %2 = call @expected() : () -> tensor<5x6x7xbf16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<bf16>, %arg1: tensor<bf16>):
      stablehlo.return %arg1 : tensor<bf16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 3], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xbf16>, tensor<2x2x1xi32>, tensor<5x2x2x7xbf16>) -> tensor<5x6x7xbf16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xbf16>, tensor<5x6x7xbf16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xbf16>, tensor<5x2x2x7xbf16>) {
    %0 = stablehlo.constant dense<"0x27C06A405AC084408FC023C017C07B3E07C005BF193F2740E8BF5DBEDBBFF0C055BF25BE1C407F3E0DC114C0E6BFEABF81BF0940F8BF1940E3BF03BF7FC0F0BE1E40214084C0BA3EBDC0BAC05B409E3F883FCABF20BD8AC0B340B7BF66403A40D73F7BBF95C0293F12C0DDBF1E40EE3F8040734058C0A63F73C03B3F51BF66C007C08E405CC0994040C04DC03ABF93402EC03FC0153DCF40454079408FBE98BFBE40B9C009C096BFF3C0E2BF87409DBE3DC07C40B1BCDBBF41BFC2BE453F10BF7ABF9EBE10C0EBBF553E1FC02DC080C091C068BE7D403C40A6405AC065C063C05D40A13F65BFC53E5340D3BFB43FCC3FE240D73F063EA0BFBEBF9DC0D7BF79BFA3405540893E0AC00AC1793FD2C0384070C02640A2BF773F9ABDB4401B40593F4F40FD3FBFBE673FC23F90C080C00BBDB64053BE063FB9C020C04F40DAC00F40394048C08240843F07410440C2C00BC0D6BE9EC0C4BF99C0D0C0CE3FC14080C09B3F9BBF293CB5401C3C074013BFD83F153F04C0F8BF00C0F2BF7EC02D3F4E3EA43F9AC020BF64C061BD324099C047408B3F54C0624028C0B23FA7C0C0BF563F9F3FC23F"> : tensor<5x6x7xbf16>
    %1 = stablehlo.constant dense<"0xF63F873E8C406C40714087403CBFB53F45C0DEBF0ABFA5C0453FA540634007410CC079C0EFBF023F86BFE4BF4C4093BF27C00440D4BF7340DE3ED6BFF23F2E3F15C063BF9340AFC06A3F66C035C010409C400BBF9EBF3740BBBFB9BFD43F70C05ABE95C064C01BC0E1BF1641823FAD3E92C0A4BE8C3F05BF9A3E984028BF20C05F3FA0BE003F9DBEB4C07A3F9E404240A7C028C00BC00640EBBF6CBE603F0D4004401240A4C0B9C00EC01FC059BE1D40CC3FB4C08940563EAF4023C03C409ABF51C04AC092404F40A040A3BF314014C03D40DBBF4040AE3F3040FFBF0940B53C3BC028C0CD3E70C00FBF5140A540DE3DC6C087BFA8BF344036414DC008BF6FC001405DBF833FC53F8BC0503D2A40C5BFFDC0AF4073BE39BF"> : tensor<5x2x2x7xbf16>
    return %0, %1 : tensor<5x6x7xbf16>, tensor<5x2x2x7xbf16>
  }
  func.func private @expected() -> tensor<5x6x7xbf16> {
    %0 = stablehlo.constant dense<"0xF63F873E8C406C40714087403CBFB53F45C0DEBF0ABFA5C0453FA540634007410CC079C0EFBF023F86BFE4BF4C4093BF27C00440D4BF7340E3BF03BF7FC0F0BE1E40214084C0BA3EBDC0BAC05B409E3F883FCABFDE3ED6BFF23F2E3F15C063BF9340AFC06A3F66C035C010409C400BBF9EBF3740BBBFB9BFD43F70C05ABE95C064C01BC0E1BF1641823FAD3E3ABF93402EC03FC0153DCF40454079408FBE98BFBE40B9C009C096BF92C0A4BE8C3F05BF9A3E984028BF20C05F3FA0BE003F9DBEB4C07A3F9E404240A7C028C00BC00640EBBF6CBE603F0D4004401240A4C0B9C05D40A13F65BFC53E5340D3BFB43FCC3FE240D73F063EA0BFBEBF9DC00EC01FC059BE1D40CC3FB4C08940563EAF4023C03C409ABF51C04AC092404F40A040A3BF314014C03D40DBBF4040AE3F3040FFBF0940B53C063FB9C020C04F40DAC00F40394048C08240843F07410440C2C00BC03BC028C0CD3E70C00FBF5140A540DE3DC6C087BFA8BF344036414DC008BF6FC001405DBF833FC53F8BC0503D2A40C5BFFDC0AF4073BE39BF61BD324099C047408B3F54C0624028C0B23FA7C0C0BF563F9F3FC23F"> : tensor<5x6x7xbf16>
    return %0 : tensor<5x6x7xbf16>
  }
}

