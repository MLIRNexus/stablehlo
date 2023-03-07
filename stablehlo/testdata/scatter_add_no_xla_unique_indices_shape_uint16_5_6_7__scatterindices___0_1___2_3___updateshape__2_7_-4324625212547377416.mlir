// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[0, 1], [2, 3]]> : tensor<2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xui16>, tensor<2x7xui16>)
    %2 = call @expected() : () -> tensor<5x6x7xui16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui16>, %arg1: tensor<ui16>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<ui16>
      stablehlo.return %5 : tensor<ui16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [1], inserted_window_dims = [0, 1], scatter_dims_to_operand_dims = [0, 1], index_vector_dim = 1>, unique_indices = true} : (tensor<5x6x7xui16>, tensor<2x2xi32>, tensor<2x7xui16>) -> tensor<5x6x7xui16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xui16>, tensor<5x6x7xui16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xui16>, tensor<2x7xui16>) {
    %0 = stablehlo.constant dense<"0x020000000000040001000200040000000100020001000000010004000000040002000400020001000100030005000400000002000000040001000300010002000100020000000700000003000200000002000100020000000400020001000200010001000600020003000000030003000400000001000100000001000200000001000300010001000100000000000000000004000000040001000100000000000100000006000000010001000200020002000000010002000100030003000100010000000100000001000400000002000400010006000400010001000400000000000000000000000300040000000200060002000300040001000200020000000200040004000000050000000100000000000000060002000100090006000000000001000000000003000200020000000600000002000400010000000300000000000400000000000000020000000000010002000100020004000300010000000000000005000100030000000400010004000300020000000200000002000000010001000000030000000200040000000200000000000700030000000100010001000400"> : tensor<5x6x7xui16>
    %1 = stablehlo.constant dense<[[5, 1, 2, 3, 4, 3, 2], [1, 3, 2, 1, 4, 1, 3]]> : tensor<2x7xui16>
    return %0, %1 : tensor<5x6x7xui16>, tensor<2x7xui16>
  }
  func.func private @expected() -> tensor<5x6x7xui16> {
    %0 = stablehlo.constant dense<"0x020000000000040001000200040005000200040004000400040006000000040002000400020001000100030005000400000002000000040001000300010002000100020000000700000003000200000002000100020000000400020001000200010001000600020003000000030003000400000001000100000001000200000001000300010001000100000000000000000004000000040001000100000000000100000006000000010001000200020002000000010002000100030003000100010000000100000001000400000002000400020009000600020005000500030000000000000000000300040000000200060002000300040001000200020000000200040004000000050000000100000000000000060002000100090006000000000001000000000003000200020000000600000002000400010000000300000000000400000000000000020000000000010002000100020004000300010000000000000005000100030000000400010004000300020000000200000002000000010001000000030000000200040000000200000000000700030000000100010001000400"> : tensor<5x6x7xui16>
    return %0 : tensor<5x6x7xui16>
  }
}

