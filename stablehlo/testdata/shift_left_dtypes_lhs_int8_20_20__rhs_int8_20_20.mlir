// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi8>, tensor<20x20xi8>)
    %1 = call @expected() : () -> tensor<20x20xi8>
    %2 = stablehlo.shift_left %0#0, %0#1 : tensor<20x20xi8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi8>, tensor<20x20xi8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi8>, tensor<20x20xi8>) {
    %0 = stablehlo.constant dense<"0x02FEFEFCFF050000000001FC00FE01FE0001020100FBFEFFFE00010000FE0000FEFA020000FD0100FFFF0004FFFD00FA02FB06000001FC00010000FBFF0002FE020401FC0000FE02FCFEFB0302FC00040103020301FCFD00FFFC00FD03FC00FD02FFFF00FBFE000601020300FB02FE0504030000000005FEFDFF0300FE00F902FF0401FB00FFFF02000205FD05010100FD0002FBFC0104FCFFFD040000FE0400FDFDFE00FE04FD0200F8FF0200010001000600020102020100FF0003FD0300020200FE0001FBFDFF02FF03FEFC05FFFF00FE010102FD020200FF0300FD00FD0001030400000005FD0005010100FF0200000202FF02010001FF01010002020600FEFF00030001FE0101FF02040302FE00FFFC0000FD03FCFD00FC010205000204FF00FF0300FFFF00FE0205FEFC010000040000FFFA05FC00FE00FC0000FFFE00FBFF0103FF0401FB00FEFF0000020300010000FB00FF00FD0100040003FE0103F7FD000201000004FDFDFD00FCFB01FF02FEFF04FFFC0002FF020400FF01FD0102FEFB00FD02FE000104FB02FC0401FC"> : tensor<20x20xi8>
    %1 = stablehlo.constant dense<"0x0001FC05FE0101FDFE02FCFD0400020001FD07FA01FF00FF00FE00FCFF02FE0001010204FDFD01FF0200FFFD0101FF0004FE03000103FFFB040500FCFD00FB00FFFE03F701FC000006FFFEFFFE0001FFFFFC02FEFFFCFA00FE020000010103FCFD01FDFE040000FEFF0001FBFC00FDFB0003FC00FDFCFE000000FEFF0AFF00FE04040100FBFE0200FE00FC030002000002FF02FF000102FE0202FF020100FF0205FB0000000202FD00F9FF00010000FFFC03FCF9FF00FD000601FF000001FFFBFCFD0201050000FDFC00FD010001FFFCFF0000060401FFFBFDFF000200FD0004FEFC0000FCFF0100FFFF05000306FD0000FF00FC0000FD04010200FEFA0700FFFE02FFFCFEFE04FEFC05FE0401FC0700000500FF0200FEF7010201FD06FFFE02FEFC0001010101FD010004FFFE02FF03FF000400010000FE00FF0006FF03000002030100FF0402F7010301010100FDFD00FFFDFE00FF0102FD0008010000FDFC04FD000300040202FEFF01FC00000100FD000400FD0001FE0200FFFBFDFF02FF0601FF00000300030103FF00F9010400"> : tensor<20x20xi8>
    return %0, %1 : tensor<20x20xi8>, tensor<20x20xi8>
  }
  func.func private @expected() -> tensor<20x20xi8> {
    %0 = stablehlo.constant dense<"0x02FC0080000A00000000000000FE04FE000000000000FE00FE00010000F80000FCF4080000000200FCFF0000FEFA00FA200030000008000010000000000000FE000008000000FE020000000000FC0000000008000000000000F000FD06F8000000FE0000B0FE0000000206000002000004180000000000FEFDFF00000000F900F04002FB0000FC02000200E805040100F4000800FC021000FCF4000000FE0000A000FE00FE10F4000000000200010000003000000002000100FE0003FD0600000000F80020FBFD0000FF00FCFC0A000000FE014020FA000000000300FD00FD000000040000000AFD0000200100C000000000020002010010FE0401000000060000FC00000000E00000E0004006000000FF800000F403000000F00200400000100000FF0600FEFE00FC02500000040000000000FFF405FC00FE00FC0000F8FE00ECF802030040040000F0FE000002000001000000000000F40000000003FE000070000010010000100000FA00FCFB02FF00FEF00400FC0000FC0200000000F40080FC0000FD10FE0002200002000810FC"> : tensor<20x20xi8>
    return %0 : tensor<20x20xi8>
  }
}
