// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[0, 1], [2, 3]]> : tensor<2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xi32>, tensor<2x7xi32>)
    %2 = call @expected() : () -> tensor<5x6x7xi32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i32>, %arg1: tensor<i32>):
      stablehlo.return %arg1 : tensor<i32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [1], inserted_window_dims = [0, 1], scatter_dims_to_operand_dims = [0, 1], index_vector_dim = 1>, unique_indices = true} : (tensor<5x6x7xi32>, tensor<2x2xi32>, tensor<2x7xi32>) -> tensor<5x6x7xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xi32>, tensor<5x6x7xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xi32>, tensor<2x7xi32>) {
    %0 = stablehlo.constant dense<"0x03000000FDFFFFFF0200000006000000FDFFFFFF0000000000000000FDFFFFFFFFFFFFFFFDFFFFFF000000000000000000000000010000000000000004000000000000000000000001000000FEFFFFFF02000000FBFFFFFF01000000020000000100000001000000FBFFFFFFFDFFFFFF02000000FEFFFFFF03000000FBFFFFFF00000000FBFFFFFF010000000200000001000000FFFFFFFF00000000FEFFFFFF00000000FEFFFFFFFEFFFFFF0000000006000000000000000100000000000000FDFFFFFFFEFFFFFF0000000002000000F9FFFFFFFCFFFFFF030000000000000000000000FCFFFFFFFFFFFFFF030000000000000003000000000000000000000002000000FFFFFFFFFCFFFFFF0300000001000000010000000000000004000000FFFFFFFFFCFFFFFF0500000000000000FFFFFFFFFEFFFFFF01000000000000000300000000000000020000000000000002000000000000000000000000000000040000000700000000000000000000000000000001000000FEFFFFFFFCFFFFFF020000000000000002000000000000000600000000000000000000000000000004000000020000000100000001000000FFFFFFFF05000000050000000600000000000000FFFFFFFF040000000000000001000000000000000100000002000000FCFFFFFF0500000003000000FEFFFFFF020000000000000003000000FDFFFFFFFDFFFFFF010000000200000000000000000000000200000003000000FEFFFFFF000000000100000004000000FEFFFFFF00000000FFFFFFFFFFFFFFFFFDFFFFFFFBFFFFFF00000000FFFFFFFF00000000040000000000000000000000FFFFFFFF04000000000000000300000006000000050000000200000001000000FEFFFFFF00000000FFFFFFFF03000000FBFFFFFFF9FFFFFFFCFFFFFF030000000000000000000000FDFFFFFF0000000000000000F8FFFFFF0000000004000000FDFFFFFF0000000000000000FEFFFFFF000000000500000001000000FFFFFFFFFFFFFFFFFDFFFFFFFDFFFFFF000000000000000003000000FFFFFFFFFEFFFFFF0000000000000000FFFFFFFFF9FFFFFF00000000FAFFFFFFFEFFFFFF00000000FDFFFFFF00000000000000000200000000000000010000000000000000000000030000000400000000000000"> : tensor<5x6x7xi32>
    %1 = stablehlo.constant dense<[[1, 0, 0, 3, 0, -3, 0], [4, -1, 0, 0, 3, 1, 0]]> : tensor<2x7xi32>
    return %0, %1 : tensor<5x6x7xi32>, tensor<2x7xi32>
  }
  func.func private @expected() -> tensor<5x6x7xi32> {
    %0 = stablehlo.constant dense<"0x03000000FDFFFFFF0200000006000000FDFFFFFF00000000000000000100000000000000000000000300000000000000FDFFFFFF000000000000000004000000000000000000000001000000FEFFFFFF02000000FBFFFFFF01000000020000000100000001000000FBFFFFFFFDFFFFFF02000000FEFFFFFF03000000FBFFFFFF00000000FBFFFFFF010000000200000001000000FFFFFFFF00000000FEFFFFFF00000000FEFFFFFFFEFFFFFF0000000006000000000000000100000000000000FDFFFFFFFEFFFFFF0000000002000000F9FFFFFFFCFFFFFF030000000000000000000000FCFFFFFFFFFFFFFF030000000000000003000000000000000000000002000000FFFFFFFFFCFFFFFF0300000001000000010000000000000004000000FFFFFFFFFCFFFFFF0500000000000000FFFFFFFFFEFFFFFF01000000000000000300000000000000020000000000000002000000000000000000000000000000040000000700000000000000000000000000000001000000FEFFFFFFFCFFFFFF02000000000000000200000000000000060000000000000000000000000000000400000004000000FFFFFFFF000000000000000003000000010000000000000000000000FFFFFFFF040000000000000001000000000000000100000002000000FCFFFFFF0500000003000000FEFFFFFF020000000000000003000000FDFFFFFFFDFFFFFF010000000200000000000000000000000200000003000000FEFFFFFF000000000100000004000000FEFFFFFF00000000FFFFFFFFFFFFFFFFFDFFFFFFFBFFFFFF00000000FFFFFFFF00000000040000000000000000000000FFFFFFFF04000000000000000300000006000000050000000200000001000000FEFFFFFF00000000FFFFFFFF03000000FBFFFFFFF9FFFFFFFCFFFFFF030000000000000000000000FDFFFFFF0000000000000000F8FFFFFF0000000004000000FDFFFFFF0000000000000000FEFFFFFF000000000500000001000000FFFFFFFFFFFFFFFFFDFFFFFFFDFFFFFF000000000000000003000000FFFFFFFFFEFFFFFF0000000000000000FFFFFFFFF9FFFFFF00000000FAFFFFFFFEFFFFFF00000000FDFFFFFF00000000000000000200000000000000010000000000000000000000030000000400000000000000"> : tensor<5x6x7xi32>
    return %0 : tensor<5x6x7xi32>
  }
}

