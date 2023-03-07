// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi8>, tensor<20x20xi8>)
    %1 = call @expected() : () -> tensor<20x20xi8>
    %2 = stablehlo.maximum %0#0, %0#1 : tensor<20x20xi8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi8>, tensor<20x20xi8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi8>, tensor<20x20xi8>) {
    %0 = stablehlo.constant dense<"0xFFFD02FC020003FFFF0002010003FE0004FF0002FEFE02000201FB0300FE02000304000105FC0000FFFE05FC00FF000102FFFFFEFBFEFF04FFFF02FFFFFA0200FF0303FF00040002020102FCFD00FD0003FCFE03000505F90000000304FDFDFFFF03FFFE020502FDFFFF0000FE000001FE070600020200010200FCFF02FF030007FFFDFDFEFE01000200FF00FC0002FE0101000303FCFE0401030203FD01FD020302FFFD02FE02010100FF0401FE010102FF00FE02FF02FD01030002FE00050001FC0000020200F90000000001FE0101FE00FF00FF0001FE01FD00FFFD000000FE0000FC03FCFF0001FD000200FC00FF030000FFFA02FD00FEFF01050100000001FEFEFB000102FEFE0001000101FB0002020500FCFF000301FFFE0000050103FA0303000001FF0100000100FE0002FAFE01FDFEFE00030002FFFD08000300FDFE00000400FE03030200FE0100FF010000FF0001FFFF0400FC08FD0004030000000001FFFB00FD0200FC0000FFFEFCFD04FF000200FFFBFCFF0103FC00010301FFFFFCFDFC0001000001FBFE04FA0000"> : tensor<20x20xi8>
    %1 = stablehlo.constant dense<"0xFE0300FFFFFC000200FE0000000000FFFA0003FDFDFA00FD0500FF0101000300FA00FFFF03FC02000300FE0000FBFD0100FBFF010200FD06FEFE00FEFEFC0100000204FD03FEFD05FF05FF0200010004FF00FCFE0201FE000003FFFF02FFFD030407FFFDFFFF00FDFFFEFEFF0002FAFF01FEFFFD00FFFF0300000103000100020004FE0000FF030000FDFA01000000FF030106FE02020200FDFCFC00FDFFFBFD000305FC00FF0301FF030004FF0007000100FC000000FF0100FE010003000201000000000201FE0000FA00FF0201000001000100FE00040002FAFCFFFC030104FDFEFE02050003FD00000100FF00FC00040200FF0002FEF8050000FE010301FA02FE0206FD00010000FFFC04FDFD00FCFD00020001FC02000002000102000504020000FF00FD020202FC03FB00FD0200FEFC00040000010301FE000101FD00FDFF00000102010003FF00FD0003FFFDFC04FF0104FFFDF9FCFFFC04FCFF02FFFE0102020100FDFF010000010300FC06FD00000600FE00FAFF020000000002FD00020100FB020204FF080004FF01FEFD02"> : tensor<20x20xi8>
    return %0, %1 : tensor<20x20xi8>, tensor<20x20xi8>
  }
  func.func private @expected() -> tensor<20x20xi8> {
    %0 = stablehlo.constant dense<"0xFF0302FF02000302000002010003000004000302FEFE02000501FF03010003000304000105FC02000300050000FF000102FFFF010200FF06FFFF02FFFFFC0200000304FF0304000502050202000100040300FE03020505000003000304FFFD030407FFFE020502FDFFFF000000020001010706000202000302000103020103020704FE0000FF03000200FF01000002FF030106030302020401030203FD01FD02030305FD02FF03010103000401000701020000000200020101030102030005010100000002020000000000000201010101000100FF00040002FD00FFFD030104FE000002050003000100010200000000040200FF0002FE00050001050103010002FE02060001020000000104010100000202050001FF0203010200010205050402030300000102020200030000000200FE0100040000030302FF0008010300FDFF000004020103030200FE0103FF010004FF0104FFFF0400FF08040004030000010202010000FF020000010300FE06FD040006020000FBFF0201030000020301020100FD02020400080104FF04FE0002"> : tensor<20x20xi8>
    return %0 : tensor<20x20xi8>
  }
}
