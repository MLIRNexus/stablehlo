// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xi8>
    %1 = call @expected() : () -> tensor<20x30xi8>
    %2 = call @integer_pow(%0) : (tensor<20x30xi8>) -> tensor<20x30xi8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x30xi8>, tensor<20x30xi8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xi8> {
    %0 = stablehlo.constant dense<"0x01FDFB0304FF03FBFEFE02FE0000000401FE00FEFCFF0200030300FEFDFFFFFF00000403000201010000FE02FF0000FCFB03FF0200FEFAFD03FE06FE010000FEFE0005FFFC02FFFFFC00FA04FE010000FE0101000101000200FFFE000200FF040401FFFE00FFFF0100010100020001FF02010100FF0502060000FF0005FEFFFF0600000402FD0500000000FF00FB0200FE0300FD0203FFF80100020004F9FEFFFBFD00FC00FD02FA01FF030300FF03FE0306FE00FFFFFAFEFCFE0000FE0000FE000100FD01FC03FFFE01000500000004FB02FE00FB03FC030000FFFFFEFD0207FE0100FFFFFD0203FC0202FE03FFFDFD0001FEFF03000102FF02000101FF010000020000030203FFFD020105FC010002FF0400FE000102FDFC01FDFF0100FFFFFEFDFF00000204FFFE0000FB030000FE060206040604FD020202FFFDFEFDFA010002000000FF020000FEFD020005FE03FF0104FD00FF0003040100080000FFFE0004000101000003020501FC000000FE0003010002020304FF00FEFE00FF0100FF020300020004000104FDFF020104010001FCFEFD0000FC040000FE0000FF040003050002FFFDFFFE0100FE01FEFA0500000100FE00000001FF00FB02FAFE0001FC0200FCFF00FE00FB030004FFFEFE03FEFF0005FC00FFFC03FC020002FFFE03000001FF0002000000000402FFFEFF040002F900FFFDFF02FC0900FDFE03FF0301FC00FFFDFAFC00FFFE00FE030301FB0603FD020100FCFD01040000FF00FDFE00FF020000FEFDFE00FC0201FF00FF000301FA00FF00FE00FBFF0300010902FDFF0003FE05FFFBFA0100FBFF03FE03FF0000FF000100FF"> : tensor<20x30xi8>
    return %0 : tensor<20x30xi8>
  }
  func.func private @expected() -> tensor<20x30xi8> {
    %0 = stablehlo.constant dense<"0x015533AB00FFAB3300000000000000000100000000FF0000ABAB000055FFFFFF000000AB0000010100000000FF00000033ABFF0000000055AB000000010000000000CDFF0000FFFF0000000000010000000101000101000000FF00000000FF000001FF0000FFFF0100010100000001FF00010100FFCD00000000FF00CD00FFFF000000000055CD00000000FF0033000000AB005500ABFF0001000000004900FF335500000055000001FFABAB00FFAB00AB000000FFFF00000000000000000000000100550100ABFF000100CD000000003300000033AB00AB0000FFFF005500B7000100FFFF5500AB00000000ABFF5555000100FFAB000100FF00000101FF010000000000AB00ABFF550001CD00010000FF00000000010055000155FF0100FFFF0055FF00000000FF00000033AB00000000000000000055000000FF55005500010000000000FF00000000550000CD00ABFF01005500FF00AB000100000000FF0000000001010000AB00CD01000000000000AB01000000AB00FF00000000FF0100FF00AB0000000000010055FF000100010001000055000000000000000000FF0000ABCD0000FF55FF00010000010000CD000001000000000001FF0033000000000100000000FF00000033AB0000FF0000AB00FF00CD0000FF00AB00000000FF00AB000001FF0000000000000000FF00FF0000004900FF55FF000039005500ABFFAB010000FF55000000FF000000ABAB013300AB55000100005501000000FF00550000FF00000000550000000001FF00FF00AB010000FF00000033FFAB0001390055FF00AB00CDFF3300010033FFAB00ABFF0000FF000100FF"> : tensor<20x30xi8>
    return %0 : tensor<20x30xi8>
  }
  func.func private @integer_pow(%arg0: tensor<20x30xi8>) -> tensor<20x30xi8> {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<20x30xi8>
    %1 = stablehlo.multiply %arg0, %0 : tensor<20x30xi8>
    %2 = stablehlo.multiply %0, %0 : tensor<20x30xi8>
    %3 = stablehlo.multiply %1, %2 : tensor<20x30xi8>
    %4 = stablehlo.multiply %2, %2 : tensor<20x30xi8>
    %5 = stablehlo.multiply %3, %4 : tensor<20x30xi8>
    %6 = stablehlo.multiply %4, %4 : tensor<20x30xi8>
    %7 = stablehlo.multiply %5, %6 : tensor<20x30xi8>
    %8 = stablehlo.multiply %6, %6 : tensor<20x30xi8>
    %9 = stablehlo.multiply %7, %8 : tensor<20x30xi8>
    %10 = stablehlo.multiply %8, %8 : tensor<20x30xi8>
    %11 = stablehlo.multiply %9, %10 : tensor<20x30xi8>
    return %11 : tensor<20x30xi8>
  }
}
