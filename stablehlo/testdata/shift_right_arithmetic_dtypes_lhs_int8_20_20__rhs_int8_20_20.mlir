// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi8>, tensor<20x20xi8>)
    %1 = call @expected() : () -> tensor<20x20xi8>
    %2 = stablehlo.shift_right_arithmetic %0#0, %0#1 : tensor<20x20xi8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi8>, tensor<20x20xi8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi8>, tensor<20x20xi8>) {
    %0 = stablehlo.constant dense<"0xFF02030100040403FF0105FF00FFFD000102030100FEFBFE0102FDFD000200030501000100FF0006F702FDFF02000001FE02FDFD020002FC000202010103FF0200010300FA03FD03FD03FEFE0000FEFF020101050000FE03030003FD01000206FD010002FEFF030103FFFEFBFEFFFF020603FFFF0106F90500FFFD01FE02FCFDFEFDFF030000FE00FE00FF0203FEFEFF000000FE03FCFF02FAFFFE03FE00FF00030200FFFFFCFBFF01FB0102FBFCFDFE010100FEFE0103FFFB01FF0004FF02FD00FEFB0000FFFD0002020400FB0000FD02FEFD00030000FE00F800FBFE02000502FCFF04010406040200FB00000602FFFB000001FD02FF00FFFEFFFE00020300FFFAFCFFFF04FEFD0300010100FE02000200050300FD03FE00FF01FB000400FE0402000400FF00FF0400FF020501FF03FB02FAFFFFFDFB01FFFFFEFC00FFFDFFFE0101FEFEFD01FF0000FF01030000FD0402F900000000FE000000FE03040000FE0000FB0401FE00FE00FC010301FC00FD0405FEFF05060000020002FDFF0000FFFDFD00010301FDFEFD0302000203FA"> : tensor<20x20xi8>
    %1 = stablehlo.constant dense<"0xFEFFFF02020304FE01FDFEFFFF0001FEFF0100000007FE04FDFE020104FFFCFC01FD0002FBFFFA0000FF00FF0000FC030100FD04FEFB02010203FE03FFFEFA0302FA0103FE0400FEFF0000FD0001FFFE01FE00FFFDFF00000000FE02FE04FF00FFFF010102FFFF0600FD03FFFEFFFFFEFEFCFEFF0500000103FD010203040100FF0105FEFD000401010501000300FFFB00020000FC02FE00FDFF0000FDFAFD0304FC00010204000004000606FC03FFFDFF01070004FAFBFAFD010200FEFF0AFDFF00F8FE0000000505FFFFFF01030000FF02FFFFFFFAFD0300FE00FC010100000000FE01FD00FFFE0100FD0304020002FE01F903FDF9FDFEFD03F905FB00FD01FD02F80500000700FDFE00FF01FDFE0205FEFEFE0100FE0101010002FF06FC000101FAFE0100010001070300000300FD00FFF7FF0205010201010300040002000200FFFE04000001FF030000000300020000010401000000FC040500FF0002FFFEFDFB00FA00FD0304FE00FE01FEFD01FDFF01FC00FE000201FCFBFF01FE020102000000FF050003FD01FC010100FFFA"> : tensor<20x20xi8>
    return %0, %1 : tensor<20x20xi8>, tensor<20x20xi8>
  }
  func.func private @expected() -> tensor<20x20xi8> {
    %0 = stablehlo.constant dense<"0xFF00000000000000FF0000FF00FFFE000001030100FFFFFF0000FFFE000000000200000000FF0006F700FDFF02000000FF02FFFF000000FE000000000000FF0000000100FF00FD00FF03FEFF0000FFFF010001000000FE03030000FF00000006FF000001FFFF000003FFFFFFFFFFFF000000FFFF0006F90200FFFE00FF00FEFDFFFEFF000000FF00FF00FF0200FEFFFF000000FE00FFFF02FFFFFE03FF00FF00000000FFFFFFFBFF00FB0000FFFFFFFF000000FEFF0000FFFF00FF0000FF00FF00FEFF0000FFFD0000000000FD0000FD00FFFF00000000FF00FF00FFFF01000502FCFF02000400000100FF00000102FFFF000000FF00FF00FFFFFFFF00020000FFFEFFFFFF04FFFD0000010000FF00000000000000FD00FF00FF01FE000000FE0201000000FF00FF0200FF020500FF00FB00FFFFFFFFFD00FFFFFFFC00FFFFFFFF0100FFFFFD01FF0000FF01030000FF0402FC00000000FE000000FE00040000FF0000FB0001FF00FF00FC000100FF00FF0002FFFF00060000000000FEFF0000FFFDFD00000001FFFFFE0001000200FF"> : tensor<20x20xi8>
    return %0 : tensor<20x20xi8>
  }
}
