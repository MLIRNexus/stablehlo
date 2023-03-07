// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xi16>
    %1 = call @expected() : () -> tensor<20x30xi16>
    %2 = stablehlo.custom_call @check.eq(%0, %1) : (tensor<20x30xi16>, tensor<20x30xi16>) -> tensor<i1>
    return %2 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xi16> {
    %0 = stablehlo.constant dense<"0xFEFFFEFF00000200FEFF0100010000000000FCFF00000000FFFFFEFF000007000000010000000000FDFF0400FFFF02000700FFFFFFFFFFFFFFFF01000100FFFFFEFFFFFF03000400010000000000000000000200020000000100FDFFF6FF000000000000000004000400FEFFFEFFFBFF0600FBFFFFFFFDFF0000FFFFFDFF03000600FFFF0300010001000100FFFF02000000FFFF02000000FEFFFFFFFFFF0300FFFF02000000000000000000FFFF0100FDFF010002000200FFFFFCFFFCFF05000000FAFF01000200FBFF040000000200FBFF01000000FDFF01000000000001000000FFFF0000FEFFFEFFFCFF0000060000000200FFFF06000200FFFF0800FBFFFFFF00000000FAFFFEFFFCFF0400FFFF04000000FEFF0000FEFF0400020000000100010001000200000000000200FFFF00000500FAFF0100000000000300FFFF0000FEFF000002000100FDFF0300FCFF0000FDFF07000100000000000000030000000100FEFFFCFFFDFF00000200FEFF00000000060003000A000100FEFFF9FF0000010003000000FEFF0100000004000000FFFFFFFF030001000000FFFFFEFF02000200FBFF000000000000FFFFFFFF02000000FFFFFFFFFCFF0500FDFFFFFF00000000FFFF0300FCFF000005000200FEFF0200FCFFFFFF00000000FCFFFFFF05000100050000000000FEFF03000600010002000000FFFFFEFF0000FEFFFCFFFEFFFBFF0000FDFF0000FBFF0100040002000000020004000500FDFF0000FEFF01000000F8FF0000FBFF0000FFFF0000000000000000FFFFFCFF00000200000001000100FCFF0500FDFFFFFF0000010001000500050000000100FFFFF9FFFDFFFEFF0000030001000000FCFF0000FEFF04000200050001000000FBFF0000020000000A00FFFFFFFF0600000000000000FAFF05000000FBFF0500FEFF00000000040000000500FEFF0500FDFF0400010003000500FDFFF9FF00000600FCFF0400000003000000FDFFFEFFFFFF01000200030003000500FFFFFFFF00000400040003000000FEFFFCFFFFFF040000000500FEFF000003000000FEFF00000000FDFFFFFF01000200020008000800000003000400FFFF00000300FEFFFEFFFDFF0500000002000100FFFF020000000500FFFFFFFF0000FAFFFDFFF9FF01000100FEFFFDFF0300FDFFFBFF0200FDFF0000FCFFFAFF01000200FBFF000002000200FFFF0000FDFF0000FDFF0000FBFF0000FFFF0500FEFFFCFFFEFF00000300FDFF02000300050001000100FDFFFFFFFFFFFFFF00000100FBFFFFFF020000000000FCFFFFFF01000000FFFFFCFF00000000FCFF05000000FBFF0400030000000100FEFF01000000FEFF0000FFFF030000000000FFFF0000FFFF0300050000000000020002000000FFFF0000FCFF0200000000000000FEFFFEFF010000000200FDFFFFFF0000FDFF00000200FFFFFFFFFFFF04000300FDFF00000100000001000100FFFF0100FFFF00000400FFFFFCFF0300FEFF0000FDFF00000200020000000000010000000500FEFFFBFF0000FEFFFFFF0600FFFF0200FEFF0000FDFFFAFFFEFF01000700FDFF04000000FCFF030000000300F9FFFDFFFEFF000001000000FDFFFFFF04000100FCFF01000000FFFF0000FEFFFEFFF8FF0200FEFF03000000FFFF02000300FFFFFEFF0100000002000100FDFF"> : tensor<20x30xi16>
    return %0 : tensor<20x30xi16>
  }
  func.func private @expected() -> tensor<20x30xi16> {
    %0 = stablehlo.constant dense<"0xFEFFFEFF00000200FEFF0100010000000000FCFF00000000FFFFFEFF000007000000010000000000FDFF0400FFFF02000700FFFFFFFFFFFFFFFF01000100FFFFFEFFFFFF03000400010000000000000000000200020000000100FDFFF6FF000000000000000004000400FEFFFEFFFBFF0600FBFFFFFFFDFF0000FFFFFDFF03000600FFFF0300010001000100FFFF02000000FFFF02000000FEFFFFFFFFFF0300FFFF02000000000000000000FFFF0100FDFF010002000200FFFFFCFFFCFF05000000FAFF01000200FBFF040000000200FBFF01000000FDFF01000000000001000000FFFF0000FEFFFEFFFCFF0000060000000200FFFF06000200FFFF0800FBFFFFFF00000000FAFFFEFFFCFF0400FFFF04000000FEFF0000FEFF0400020000000100010001000200000000000200FFFF00000500FAFF0100000000000300FFFF0000FEFF000002000100FDFF0300FCFF0000FDFF07000100000000000000030000000100FEFFFCFFFDFF00000200FEFF00000000060003000A000100FEFFF9FF0000010003000000FEFF0100000004000000FFFFFFFF030001000000FFFFFEFF02000200FBFF000000000000FFFFFFFF02000000FFFFFFFFFCFF0500FDFFFFFF00000000FFFF0300FCFF000005000200FEFF0200FCFFFFFF00000000FCFFFFFF05000100050000000000FEFF03000600010002000000FFFFFEFF0000FEFFFCFFFEFFFBFF0000FDFF0000FBFF0100040002000000020004000500FDFF0000FEFF01000000F8FF0000FBFF0000FFFF0000000000000000FFFFFCFF00000200000001000100FCFF0500FDFFFFFF0000010001000500050000000100FFFFF9FFFDFFFEFF0000030001000000FCFF0000FEFF04000200050001000000FBFF0000020000000A00FFFFFFFF0600000000000000FAFF05000000FBFF0500FEFF00000000040000000500FEFF0500FDFF0400010003000500FDFFF9FF00000600FCFF0400000003000000FDFFFEFFFFFF01000200030003000500FFFFFFFF00000400040003000000FEFFFCFFFFFF040000000500FEFF000003000000FEFF00000000FDFFFFFF01000200020008000800000003000400FFFF00000300FEFFFEFFFDFF0500000002000100FFFF020000000500FFFFFFFF0000FAFFFDFFF9FF01000100FEFFFDFF0300FDFFFBFF0200FDFF0000FCFFFAFF01000200FBFF000002000200FFFF0000FDFF0000FDFF0000FBFF0000FFFF0500FEFFFCFFFEFF00000300FDFF02000300050001000100FDFFFFFFFFFFFFFF00000100FBFFFFFF020000000000FCFFFFFF01000000FFFFFCFF00000000FCFF05000000FBFF0400030000000100FEFF01000000FEFF0000FFFF030000000000FFFF0000FFFF0300050000000000020002000000FFFF0000FCFF0200000000000000FEFFFEFF010000000200FDFFFFFF0000FDFF00000200FFFFFFFFFFFF04000300FDFF00000100000001000100FFFF0100FFFF00000400FFFFFCFF0300FEFF0000FDFF00000200020000000000010000000500FEFFFBFF0000FEFFFFFF0600FFFF0200FEFF0000FDFFFAFFFEFF01000700FDFF04000000FCFF030000000300F9FFFDFFFEFF000001000000FDFFFFFF04000100FCFF01000000FFFF0000FEFFFEFFF8FF0200FEFF03000000FFFF02000300FFFFFEFF0100000002000100FDFF"> : tensor<20x30xi16>
    return %0 : tensor<20x30xi16>
  }
}
