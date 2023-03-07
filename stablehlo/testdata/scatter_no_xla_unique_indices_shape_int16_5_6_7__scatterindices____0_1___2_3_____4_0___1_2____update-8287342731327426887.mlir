// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0, 1], [2, 3]], [[4, 0], [1, 2]]]> : tensor<2x2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xi16>, tensor<5x2x2xi16>)
    %2 = call @expected() : () -> tensor<5x6x7xi16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i16>, %arg1: tensor<i16>):
      stablehlo.return %arg1 : tensor<i16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0], inserted_window_dims = [1, 2], scatter_dims_to_operand_dims = [1, 2], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xi16>, tensor<2x2x2xi32>, tensor<5x2x2xi16>) -> tensor<5x6x7xi16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xi16>, tensor<5x6x7xi16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xi16>, tensor<5x2x2xi16>) {
    %0 = stablehlo.constant dense<"0x020000000700FFFFF9FF08000100FEFFFEFFFFFF0000FEFF000001000200FDFF01000500020000000200FDFFFEFFFCFFFFFF0400FEFF00000100FDFF0500FFFF0400020001000100000002000200FDFF00000000FFFF0000FFFF0000FFFFFCFF0600FEFFFEFF0000010000000200FCFFFEFFFEFF0000FFFF050000000000FFFF0000FEFF05000000FAFF0200060002000100FAFF0000FFFFFEFFFEFFFBFFFCFF020000000100FFFF01000000020001000000020002000100030004000200020000000000FFFF0100FFFFFFFFFFFF0400FDFF020000000000FAFF04000100FAFF0400FCFFFDFFFFFFFBFFF8FFFCFF0000FCFF0000FFFFFFFF010001000000FBFFFFFF04000000FEFF01000200FFFF020000000000FEFFFFFFFFFF0600FFFF02000300FCFF0000FEFF0200FEFF0000010001000400FFFF0000FDFFFFFFFFFF000001000100FFFF0300040001000200FBFF0000FDFFFFFFFEFF0200FCFF0400FFFF010000000000FDFFFBFF0100FEFF0000FDFFFCFFFEFFF9FFFCFFFFFF010003000600010005000400000002000000FEFF010001000000FFFF03000000FEFFFCFF00000300"> : tensor<5x6x7xi16>
    %1 = stablehlo.constant dense<[[[1, 0], [1, -4]], [[3, 0], [-1, 0]], [[3, 0], [-2, 0]], [[-2, -2], [0, 6]], [[-1, 3], [-1, 2]]]> : tensor<5x2x2xi16>
    return %0, %1 : tensor<5x6x7xi16>, tensor<5x2x2xi16>
  }
  func.func private @expected() -> tensor<5x6x7xi16> {
    %0 = stablehlo.constant dense<"0x020001000700FFFFF9FF08000100FEFFFEFFFCFF0000FEFF000001000200FDFF01000000020000000200FDFFFEFFFCFFFFFF0400FEFF00000100FDFF0500FFFF0400020001000100000002000200FDFF00000000FFFF0300FFFF0000FFFFFCFF0600FEFFFEFF0000010000000200FCFFFEFFFEFF00000000050000000000FFFF0000FEFF05000000FAFF0200FFFF02000100FAFF0000FFFFFEFFFEFFFBFFFCFF020000000100FFFF01000300020001000000020002000100030000000200020000000000FFFF0100FFFF0000FFFF0400FDFF020000000000FAFF04000100FAFFFEFFFCFFFDFFFFFFFBFFF8FFFCFF0000FCFF0000FFFFFFFF010001000000FEFFFFFF04000000FEFF01000200FFFF060000000000FEFFFFFFFFFF0600FFFFFEFF0300FCFF0000FEFF0200FEFF000001000100040000000000FDFFFFFFFFFF000001000100FFFF0300040001000200FBFF0000FFFFFFFFFEFF0200FCFF0400FFFF010002000000FDFFFBFF0100FEFF0000FDFF0300FEFFF9FFFCFFFFFF010003000600010005000400FFFF02000000FEFF010001000000FFFF03000000FEFFFCFF00000300"> : tensor<5x6x7xi16>
    return %0 : tensor<5x6x7xi16>
  }
}

