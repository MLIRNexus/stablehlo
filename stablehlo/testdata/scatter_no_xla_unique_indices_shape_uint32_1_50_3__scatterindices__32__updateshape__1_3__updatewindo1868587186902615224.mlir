// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<32> : tensor<1xi32>
    %1:2 = call @inputs() : () -> (tensor<1x50x3xui32>, tensor<1x3xui32>)
    %2 = call @expected() : () -> tensor<1x50x3xui32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui32>, %arg1: tensor<ui32>):
      stablehlo.return %arg1 : tensor<ui32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1]>, unique_indices = true} : (tensor<1x50x3xui32>, tensor<1xi32>, tensor<1x3xui32>) -> tensor<1x50x3xui32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<1x50x3xui32>, tensor<1x50x3xui32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x50x3xui32>, tensor<1x3xui32>) {
    %0 = stablehlo.constant dense<"0x050000000700000001000000030000000100000002000000000000000600000003000000010000000300000003000000010000000100000004000000000000000100000002000000040000000300000000000000020000000100000000000000030000000300000001000000000000000200000003000000000000000000000004000000010000000100000001000000020000000400000002000000000000000300000000000000010000000100000003000000030000000500000000000000010000000700000002000000020000000100000003000000000000000100000002000000000000000000000002000000010000000300000001000000020000000300000007000000030000000300000001000000000000000000000004000000010000000400000000000000030000000000000000000000000000000300000001000000000000000100000000000000050000000000000002000000020000000600000000000000000000000200000000000000010000000000000001000000010000000400000001000000020000000500000001000000030000000000000001000000060000000600000004000000020000000000000001000000030000000300000000000000000000000300000003000000020000000100000001000000000000000100000006000000000000000200000004000000020000000100000002000000000000000200000009000000030000000000000005000000010000000100000003000000000000000100000004000000020000000100000004000000030000000300000000000000020000000100000000000000"> : tensor<1x50x3xui32>
    %1 = stablehlo.constant dense<[[0, 5, 2]]> : tensor<1x3xui32>
    return %0, %1 : tensor<1x50x3xui32>, tensor<1x3xui32>
  }
  func.func private @expected() -> tensor<1x50x3xui32> {
    %0 = stablehlo.constant dense<"0x050000000700000001000000030000000100000002000000000000000600000003000000010000000300000003000000010000000100000004000000000000000100000002000000040000000300000000000000020000000100000000000000030000000300000001000000000000000200000003000000000000000000000004000000010000000100000001000000020000000400000002000000000000000300000000000000010000000100000003000000030000000500000000000000010000000700000002000000020000000100000003000000000000000100000002000000000000000000000002000000010000000300000001000000020000000300000007000000030000000300000001000000000000000000000004000000010000000400000000000000030000000000000000000000000000000300000001000000000000000100000000000000050000000000000002000000020000000600000000000000000000000200000000000000010000000000000001000000000000000500000002000000020000000500000001000000030000000000000001000000060000000600000004000000020000000000000001000000030000000300000000000000000000000300000003000000020000000100000001000000000000000100000006000000000000000200000004000000020000000100000002000000000000000200000009000000030000000000000005000000010000000100000003000000000000000100000004000000020000000100000004000000030000000300000000000000020000000100000000000000"> : tensor<1x50x3xui32>
    return %0 : tensor<1x50x3xui32>
  }
}

