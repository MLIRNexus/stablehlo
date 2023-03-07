// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xi16>
    %1 = call @expected() : () -> tensor<20x30xi16>
    %2 = call @integer_pow(%0) : (tensor<20x30xi16>) -> tensor<20x30xi16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x30xi16>, tensor<20x30xi16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xi16> {
    %0 = stablehlo.constant dense<"0xFFFFFEFFFFFF0000FCFF0100FCFF000001000300000000000300FCFFFFFF0000000001000100010004000000FFFFFDFF0100020000000000FDFFFEFF0200FCFF00000000FFFFFBFF0100010002000100FAFF0200000001000200000007000000FDFF0100FAFF060000000400FFFF000001000300FCFF03000200FEFF000001000200FEFFFBFFFCFF000002000700000002000100FCFFFDFF02000000FEFF000003000200FFFF0000FDFF01000000010003000400000002000100FFFFFCFFFEFF0000FDFF0600FEFF0000FFFFFDFFFBFFFFFF0000FFFF02000300FEFFFDFF000003000100FFFF0000FEFFFEFF0000FDFF000000000000FFFF0100FBFF0000FFFF0300000000000000FBFFFEFF00000100FEFFFDFFFCFF00000400000003000400FDFF000000000000FFFFFDFFFDFF0200010002000000FFFF0200000003000000FBFF0400FFFF0100FFFFFDFF01000200020000000100FDFF0100FBFF0100FEFFFFFFFFFFF8FF0500FDFF000003000200FEFF0000F9FF0100FFFFFFFF0300030001000100FDFFFCFFFFFF00000000FFFFFBFF00000400010001000300FFFFFEFFFEFF0200000000000600FEFFFFFF0300FEFFFEFF0100FFFF0200FEFF04000400FFFF000001000400FFFF02000000FFFFFEFFFFFFFBFFF9FF00000100FBFF0100FCFF0000020001000000FCFF0000F7FFFFFFFFFF04000200FFFFFCFF000003000000FBFFFFFFFAFFFFFF0100FEFF0300FFFFFAFF02000000030003000200020001000200FFFFFEFF02000300FFFF02000100FDFFFFFF0200FCFF00000000010000000200FCFF02000000000003000100FEFF030000000300FFFFFFFFFCFFFBFF0000FEFFFEFFFEFF00000100030000000000000001000400FEFF040000000000FFFF0200FEFF00000200000001000000FFFF03000000FAFF0200FEFF0100000001000000FFFFFEFF0400FDFF0400020000000300FFFF0100FEFF020001000100FAFFFFFF0100F7FFFCFFFAFF000000000000030000000100FDFF0300FFFF00000000030000000900FDFF0000FFFFFDFFFCFFFEFFFEFF0000FFFF0000FDFF0200FEFF0000FEFF0000FEFF0000FFFF0000020000000100FAFF0200FFFFFEFFFBFF0200040000000300FEFF0300000001000100FFFF00000100FEFF0500FFFF000000000100FFFFFCFFFFFF0100FDFFFFFF0000000000000000030002000100FDFFFDFF0300FFFFFDFF0000FAFF0500FCFFFFFFFAFF0500010000000000FFFFFEFF0000FEFF0400FFFF0200FDFFFBFF00000400FFFF0200FCFF00000400FEFF0100FEFFFFFF00000200FEFFFEFF00000200FDFF0000FFFF05000000FFFF000000000500FFFF0600FCFF0200FCFFFFFF0100000000000100000000000000FDFF000001000000FEFF0000FFFF010003000000FFFFF9FF0300FDFFFEFFFFFF030000000000FCFF000000000600FFFF0500FCFFFEFFFFFFFEFF0200050003000600FFFF0000FDFFFEFF02000000FFFFFDFFFFFFFFFF0200FDFFFCFFFFFFFEFFFFFF020000000500FFFF000001000000FDFF06000000FEFF0300FBFFFCFF0400FFFF0100FDFF00000200FFFF0000FCFF0300060002000400FFFFFFFF05000200060001000100FEFF0500FCFF02000200030000000000FDFF0000000006000000FFFFFEFFFFFF0200FEFF040004000300FEFF0100"> : tensor<20x30xi16>
    return %0 : tensor<20x30xi16>
  }
  func.func private @expected() -> tensor<20x30xi16> {
    %0 = stablehlo.constant dense<"0xFFFF0000FFFF000000000100000000000100AB2800000000AB280000FFFF0000000001000100010000000000FFFF55D7010000000000000055D700000000000000000000FFFF338D0100010000000100000000000000010000000000B721000055D701000000000000000000FFFF00000100AB280000AB28000000000000010000000000338D000000000000B721000000000100000055D70000000000000000AB280000FFFF000055D7010000000100AB280000000000000100FFFF00000000000055D7000000000000FFFF55D7338DFFFF0000FFFF0000AB28000055D70000AB280100FFFF000000000000000055D7000000000000FFFF0100338D0000FFFFAB28000000000000338D000000000100000055D70000000000000000AB28000055D7000000000000FFFF55D755D70000010000000000FFFF00000000AB280000338D0000FFFF0100FFFF55D70100000000000000010055D70100338D01000000FFFFFFFF0000CD7255D70000AB2800000000000049DE0100FFFFFFFFAB28AB280100010055D70000FFFF00000000FFFF338D0000000001000100AB28FFFF0000000000000000000000000000FFFFAB28000000000100FFFF0000000000000000FFFF000001000000FFFF00000000FFFF0000FFFF338D49DE00000100338D01000000000000000100000000000000C71DFFFFFFFF00000000FFFF00000000AB280000338DFFFF0000FFFF01000000AB28FFFF000000000000AB28AB280000000001000000FFFF00000000AB28FFFF0000010055D7FFFF00000000000000000100000000000000000000000000AB2801000000AB280000AB28FFFFFFFF0000338D000000000000000000000100AB28000000000000010000000000000000000000FFFF0000000000000000000001000000FFFFAB2800000000000000000100000001000000FFFF0000000055D7000000000000AB28FFFF010000000000010001000000FFFF0100C71D00000000000000000000AB280000010055D7AB28FFFF00000000AB28000039E255D70000FFFF55D70000000000000000FFFF000055D70000000000000000000000000000FFFF000000000000010000000000FFFF0000338D000000000000AB280000AB28000001000100FFFF000001000000CD72FFFF000000000100FFFF0000FFFF010055D7FFFF0000000000000000AB280000010055D755D7AB28FFFF55D700000000CD720000FFFF0000CD72010000000000FFFF0000000000000000FFFF000055D7338D00000000FFFF0000000000000000000001000000FFFF00000000000000000000000055D70000FFFFCD720000FFFF00000000CD72FFFF0000000000000000FFFF010000000000010000000000000055D700000100000000000000FFFF0100AB280000FFFF49DEAB2855D70000FFFFAB28000000000000000000000000FFFFCD7200000000FFFF00000000CD72AB280000FFFF000055D7000000000000FFFF55D7FFFFFFFF000055D70000FFFF0000FFFF00000000CD72FFFF00000100000055D7000000000000AB28338D00000000FFFF010055D700000000FFFF00000000AB28000000000000FFFFFFFFCD7200000000010001000000CD72000000000000AB280000000055D70000000000000000FFFF0000FFFF0000000000000000AB2800000100"> : tensor<20x30xi16>
    return %0 : tensor<20x30xi16>
  }
  func.func private @integer_pow(%arg0: tensor<20x30xi16>) -> tensor<20x30xi16> {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<20x30xi16>
    %1 = stablehlo.multiply %arg0, %0 : tensor<20x30xi16>
    %2 = stablehlo.multiply %0, %0 : tensor<20x30xi16>
    %3 = stablehlo.multiply %1, %2 : tensor<20x30xi16>
    %4 = stablehlo.multiply %2, %2 : tensor<20x30xi16>
    %5 = stablehlo.multiply %3, %4 : tensor<20x30xi16>
    %6 = stablehlo.multiply %4, %4 : tensor<20x30xi16>
    %7 = stablehlo.multiply %5, %6 : tensor<20x30xi16>
    %8 = stablehlo.multiply %6, %6 : tensor<20x30xi16>
    %9 = stablehlo.multiply %7, %8 : tensor<20x30xi16>
    %10 = stablehlo.multiply %8, %8 : tensor<20x30xi16>
    %11 = stablehlo.multiply %9, %10 : tensor<20x30xi16>
    return %11 : tensor<20x30xi16>
  }
}
