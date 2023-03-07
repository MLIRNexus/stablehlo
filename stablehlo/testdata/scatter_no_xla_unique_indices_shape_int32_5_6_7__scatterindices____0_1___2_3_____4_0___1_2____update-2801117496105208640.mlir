// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0, 1], [2, 3]], [[4, 0], [1, 2]]]> : tensor<2x2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xi32>, tensor<5x2x2xi32>)
    %2 = call @expected() : () -> tensor<5x6x7xi32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i32>, %arg1: tensor<i32>):
      stablehlo.return %arg1 : tensor<i32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0], inserted_window_dims = [1, 2], scatter_dims_to_operand_dims = [1, 2], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xi32>, tensor<2x2x2xi32>, tensor<5x2x2xi32>) -> tensor<5x6x7xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xi32>, tensor<5x6x7xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xi32>, tensor<5x2x2xi32>) {
    %0 = stablehlo.constant dense<"0x01000000FEFFFFFF0000000001000000000000000A00000000000000FFFFFFFFFEFFFFFF0000000005000000FFFFFFFFFCFFFFFF000000000000000004000000030000000100000001000000FBFFFFFF010000000100000002000000FEFFFFFF0100000004000000FEFFFFFF00000000FBFFFFFFFDFFFFFFFBFFFFFFFEFFFFFF01000000FEFFFFFF030000000000000000000000FEFFFFFFFFFFFFFF040000000000000000000000FBFFFFFFFEFFFFFFFFFFFFFF00000000040000000200000002000000FFFFFFFFFAFFFFFFFFFFFFFF0600000000000000020000000200000002000000010000000000000001000000FFFFFFFFFEFFFFFFFDFFFFFF03000000FBFFFFFFFFFFFFFFFAFFFFFF020000000000000001000000FDFFFFFF000000000100000002000000FEFFFFFFFCFFFFFF00000000FFFFFFFF0000000000000000FFFFFFFF00000000FDFFFFFFFEFFFFFF02000000010000000100000002000000040000000400000001000000FEFFFFFFFDFFFFFF06000000FCFFFFFF01000000FFFFFFFF01000000FEFFFFFF000000000100000003000000FEFFFFFF0000000000000000FBFFFFFFFFFFFFFF05000000010000000100000002000000FBFFFFFF000000000100000003000000000000000000000000000000030000000200000000000000FEFFFFFFF9FFFFFF010000000100000001000000FEFFFFFFFFFFFFFFFFFFFFFF01000000FEFFFFFF02000000FBFFFFFF0000000001000000030000000200000000000000F9FFFFFFFFFFFFFF02000000FEFFFFFFFAFFFFFF040000000900000000000000FFFFFFFFFEFFFFFF00000000020000000300000005000000FDFFFFFF0000000002000000FBFFFFFF0400000001000000FEFFFFFFFCFFFFFF05000000FFFFFFFFFFFFFFFF050000000400000000000000FAFFFFFF0300000000000000000000000000000004000000040000000100000000000000020000000200000002000000FDFFFFFF0000000002000000000000000400000003000000FFFFFFFF02000000010000000000000002000000FDFFFFFFFFFFFFFF0100000003000000020000000000000000000000FDFFFFFF0400000004000000000000000200000000000000FEFFFFFF030000000000000000000000030000000000000002000000FBFFFFFF"> : tensor<5x6x7xi32>
    %1 = stablehlo.constant dense<[[[-2, 2], [-5, -3]], [[3, 0], [2, 3]], [[0, 1], [-1, 3]], [[-1, 0], [-3, 0]], [[-5, 0], [2, -2]]]> : tensor<5x2x2xi32>
    return %0, %1 : tensor<5x6x7xi32>, tensor<5x2x2xi32>
  }
  func.func private @expected() -> tensor<5x6x7xi32> {
    %0 = stablehlo.constant dense<"0x01000000FEFFFFFF0000000001000000000000000A00000000000000FFFFFFFFFEFFFFFFFDFFFFFF05000000FFFFFFFFFCFFFFFF000000000000000004000000030000000200000001000000FBFFFFFF010000000100000002000000FEFFFFFF0100000004000000FEFFFFFF00000000FBFFFFFFFDFFFFFFFBFFFFFFFEFFFFFF01000000FEFFFFFF030000000000000000000000FEFFFFFFFFFFFFFF040000000000000000000000FBFFFFFF03000000FFFFFFFF00000000040000000200000002000000FFFFFFFFFAFFFFFF030000000600000000000000020000000200000002000000010000000000000000000000FFFFFFFFFEFFFFFFFDFFFFFF03000000FBFFFFFFFFFFFFFFFAFFFFFF02000000000000000100000002000000000000000100000002000000FEFFFFFFFCFFFFFF00000000FFFFFFFF0000000000000000FFFFFFFF00000000FDFFFFFFFEFFFFFF02000000000000000100000002000000040000000400000001000000FEFFFFFFFDFFFFFF03000000FCFFFFFF01000000FFFFFFFF01000000FEFFFFFF000000000100000001000000FEFFFFFF0000000000000000FBFFFFFFFFFFFFFF05000000010000000100000002000000FBFFFFFFFFFFFFFF0100000003000000000000000000000000000000030000000200000000000000FEFFFFFFF9FFFFFF010000000100000001000000FEFFFFFFFFFFFFFFFFFFFFFF01000000FEFFFFFF02000000FBFFFFFF0000000001000000000000000200000000000000F9FFFFFFFFFFFFFF02000000FEFFFFFFFAFFFFFF000000000900000000000000FFFFFFFFFEFFFFFF00000000020000000300000005000000FDFFFFFF00000000FDFFFFFFFBFFFFFF0400000001000000FEFFFFFFFCFFFFFF05000000FFFFFFFFFFFFFFFF050000000400000000000000FAFFFFFF0300000000000000FBFFFFFF00000000040000000400000001000000000000000200000002000000FEFFFFFFFDFFFFFF0000000002000000000000000400000003000000FFFFFFFF00000000010000000000000002000000FDFFFFFFFFFFFFFF0100000003000000020000000000000000000000020000000400000004000000000000000200000000000000FEFFFFFF030000000000000000000000030000000000000002000000FBFFFFFF"> : tensor<5x6x7xi32>
    return %0 : tensor<5x6x7xi32>
  }
}

