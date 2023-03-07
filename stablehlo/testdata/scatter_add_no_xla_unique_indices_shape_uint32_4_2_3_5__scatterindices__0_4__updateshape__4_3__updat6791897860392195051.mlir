// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[0, 4]> : tensor<2xi32>
    %1:2 = call @inputs() : () -> (tensor<4x2x3x5xui32>, tensor<4x3xui32>)
    %2 = call @expected() : () -> tensor<4x2x3x5xui32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui32>, %arg1: tensor<ui32>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<ui32>
      stablehlo.return %5 : tensor<ui32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1, 3], scatter_dims_to_operand_dims = [1, 3]>, unique_indices = true} : (tensor<4x2x3x5xui32>, tensor<2xi32>, tensor<4x3xui32>) -> tensor<4x2x3x5xui32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<4x2x3x5xui32>, tensor<4x2x3x5xui32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<4x2x3x5xui32>, tensor<4x3xui32>) {
    %0 = stablehlo.constant dense<"0x010000000400000001000000000000000100000006000000030000000100000001000000030000000500000005000000030000000200000003000000010000000500000001000000030000000100000002000000000000000400000005000000010000000100000003000000030000000000000001000000030000000000000001000000010000000300000003000000010000000000000003000000000000000000000000000000030000000400000004000000050000000300000001000000010000000000000007000000000000000100000003000000010000000000000000000000010000000000000001000000020000000000000000000000040000000400000007000000000000000800000000000000010000000100000001000000040000000400000002000000000000000500000002000000020000000300000000000000020000000600000001000000000000000000000001000000020000000000000008000000000000000100000003000000000000000300000001000000060000000000000003000000000000000500000005000000000000000300000000000000010000000200000001000000020000000000000002000000010000000100000002000000030000000200000001000000040000000100000000000000"> : tensor<4x2x3x5xui32>
    %1 = stablehlo.constant dense<[[3, 4, 1], [0, 1, 1], [4, 0, 2], [2, 0, 2]]> : tensor<4x3xui32>
    return %0, %1 : tensor<4x2x3x5xui32>, tensor<4x3xui32>
  }
  func.func private @expected() -> tensor<4x2x3x5xui32> {
    %0 = stablehlo.constant dense<"0x010000000400000001000000000000000400000006000000030000000100000001000000070000000500000005000000030000000200000004000000010000000500000001000000030000000100000002000000000000000400000005000000010000000100000003000000030000000000000001000000030000000000000001000000010000000300000003000000010000000000000003000000010000000000000000000000030000000400000005000000050000000300000001000000010000000000000007000000000000000100000003000000010000000000000000000000010000000000000001000000020000000000000000000000040000000800000007000000000000000800000000000000010000000100000001000000040000000400000004000000000000000500000002000000020000000300000000000000020000000600000001000000000000000000000001000000020000000000000008000000000000000100000003000000000000000500000001000000060000000000000003000000000000000500000005000000000000000300000002000000010000000200000001000000020000000000000002000000010000000100000002000000030000000200000001000000040000000100000000000000"> : tensor<4x2x3x5xui32>
    return %0 : tensor<4x2x3x5xui32>
  }
}

