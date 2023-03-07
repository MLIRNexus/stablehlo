// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0], [1]], [[2], [3]]]> : tensor<2x2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xui16>, tensor<5x2x2x7xui16>)
    %2 = call @expected() : () -> tensor<5x6x7xui16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui16>, %arg1: tensor<ui16>):
      %5 = stablehlo.multiply %arg0, %arg1 : tensor<ui16>
      stablehlo.return %5 : tensor<ui16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 3], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xui16>, tensor<2x2x1xi32>, tensor<5x2x2x7xui16>) -> tensor<5x6x7xui16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xui16>, tensor<5x6x7xui16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xui16>, tensor<5x2x2x7xui16>) {
    %0 = stablehlo.constant dense<"0x050002000200020000000000030000000100020001000000020003000000000001000300020003000100030004000100010000000000040000000100080006000000000002000100010002000200040000000200040003000200000000000200040001000300030002000200030005000400010000000000030001000200050000000200010001000000020001000000030000000200000000000500000001000500010003000100000005000100000001000000030000000100030000000100000001000300020000000100010002000200080001000200010005000300030008000600080000000300000002000400000004000000030004000200050006000000010003000100010004000000010002000400020002000100000003000100010005000100020000000400020002000300020003000300030005000000040006000200020002000100020001000300010006000000020000000300020001000000020003000300010007000300000000000100040000000200030004000000000000000100030000000500020000000700020000000200040005000000010001000000"> : tensor<5x6x7xui16>
    %1 = stablehlo.constant dense<"0x03000100000004000000020002000100060001000000000001000000000002000400030003000700010005000000020003000000000005000800000000000000010002000000010003000000000001000200010001000000050000000100000003000100010001000000020000000100030001000100000000000100060007000000020002000400000007000400010005000000010003000800010004000100010000000500010002000100010003000400040001000100020001000100030000000000000000000000030000000200040006000300030002000400000002000000010003000300040000000100050006000000000002000200040003000200010000000000020004000100020006000400010000000000"> : tensor<5x2x2x7xui16>
    return %0, %1 : tensor<5x6x7xui16>, tensor<5x2x2x7xui16>
  }
  func.func private @expected() -> tensor<5x6x7xui16> {
    %0 = stablehlo.constant dense<"0x0F00020000000800000000000600000006000200000000000200000000000000040009000600150001000F0000000200030000000000140000000100080006000000000002000100010002000200040000000200200000000000000000000400000001000900000000000200060005000400000000000000030000000600050000000200000002000000020001000000030000000200000000000500000001000500010003000100000005000100000000000000120000000000060000000400000007000C00020000000000010006001000080004000200010000000F000300080006000800000003000000020004000000040000000300040002000A000600000003000C000400010004000000010002000C0000000000000000000000030000000A0004000C0000000C0004000800000004000300030003000500000004000600020002000200010002000100030000000600000006000000000002000500000000000000060002001C000900000000000000000000000800030008000000000000000000000000000500020000000700020000000200040005000000010001000000"> : tensor<5x6x7xui16>
    return %0 : tensor<5x6x7xui16>
  }
}

