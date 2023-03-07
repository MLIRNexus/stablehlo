// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[0, 1], [2, 3]]> : tensor<2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xi32>, tensor<2x7xi32>)
    %2 = call @expected() : () -> tensor<5x6x7xi32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i32>, %arg1: tensor<i32>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<i32>
      stablehlo.return %5 : tensor<i32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [1], inserted_window_dims = [0, 1], scatter_dims_to_operand_dims = [0, 1], index_vector_dim = 1>, unique_indices = true} : (tensor<5x6x7xi32>, tensor<2x2xi32>, tensor<2x7xi32>) -> tensor<5x6x7xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xi32>, tensor<5x6x7xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xi32>, tensor<2x7xi32>) {
    %0 = stablehlo.constant dense<"0x030000000300000000000000FDFFFFFF0000000000000000FBFFFFFF02000000FEFFFFFFFDFFFFFF02000000FDFFFFFF02000000FFFFFFFFFFFFFFFF0200000002000000020000000100000000000000FEFFFFFF00000000040000000200000003000000FFFFFFFFFEFFFFFF03000000FFFFFFFFFDFFFFFF0300000002000000020000000100000001000000FEFFFFFF00000000FFFFFFFF0100000000000000FCFFFFFFFDFFFFFFFCFFFFFF020000000400000002000000FDFFFFFF01000000FDFFFFFF04000000F9FFFFFF000000000700000000000000FEFFFFFFFCFFFFFF000000000000000005000000FDFFFFFF00000000FEFFFFFF02000000010000000200000000000000FAFFFFFF0600000001000000050000000100000000000000010000000000000000000000000000000600000000000000FEFFFFFFFFFFFFFF00000000FCFFFFFF0000000000000000FEFFFFFF02000000010000000200000000000000FEFFFFFF01000000030000000100000000000000FFFFFFFF03000000FCFFFFFF0600000000000000FDFFFFFFFEFFFFFFFDFFFFFFFFFFFFFF00000000FFFFFFFF0000000000000000FFFFFFFF00000000FEFFFFFF0000000002000000FFFFFFFFFDFFFFFFFEFFFFFF01000000FEFFFFFF0300000000000000FCFFFFFFFDFFFFFFFFFFFFFF0200000000000000010000000000000001000000000000000000000000000000020000000000000005000000FFFFFFFFFDFFFFFF00000000FEFFFFFFFEFFFFFFFFFFFFFF0000000004000000FFFFFFFFFBFFFFFF03000000FCFFFFFFFDFFFFFF010000000300000002000000040000000200000000000000FCFFFFFF0500000000000000FEFFFFFFFFFFFFFF000000000300000003000000FDFFFFFFFCFFFFFF01000000000000000100000000000000FDFFFFFF04000000FCFFFFFF01000000FEFFFFFF0300000000000000FCFFFFFF000000000300000003000000FEFFFFFF000000000200000000000000FEFFFFFFF9FFFFFF0300000000000000000000000300000002000000FFFFFFFF0000000000000000FFFFFFFF0100000000000000FEFFFFFFFDFFFFFF00000000FEFFFFFFFAFFFFFFFEFFFFFFFEFFFFFF0000000000000000000000000000000005000000FEFFFFFF00000000FDFFFFFFFCFFFFFF"> : tensor<5x6x7xi32>
    %1 = stablehlo.constant dense<[[1, -2, 3, 0, -6, -2, 2], [0, 1, 0, 5, 0, -4, -3]]> : tensor<2x7xi32>
    return %0, %1 : tensor<5x6x7xi32>, tensor<2x7xi32>
  }
  func.func private @expected() -> tensor<5x6x7xi32> {
    %0 = stablehlo.constant dense<"0x030000000300000000000000FDFFFFFF0000000000000000FBFFFFFF03000000FCFFFFFF0000000002000000F7FFFFFF0000000001000000FFFFFFFF0200000002000000020000000100000000000000FEFFFFFF00000000040000000200000003000000FFFFFFFFFEFFFFFF03000000FFFFFFFFFDFFFFFF0300000002000000020000000100000001000000FEFFFFFF00000000FFFFFFFF0100000000000000FCFFFFFFFDFFFFFFFCFFFFFF020000000400000002000000FDFFFFFF01000000FDFFFFFF04000000F9FFFFFF000000000700000000000000FEFFFFFFFCFFFFFF000000000000000005000000FDFFFFFF00000000FEFFFFFF02000000010000000200000000000000FAFFFFFF0600000001000000050000000100000000000000010000000000000000000000000000000600000000000000FEFFFFFFFFFFFFFF00000000FCFFFFFF0000000000000000FEFFFFFF02000000010000000200000000000000FEFFFFFF01000000030000000100000000000000FFFFFFFF03000000FCFFFFFF0600000000000000FDFFFFFFFEFFFFFFFDFFFFFFFFFFFFFF00000000FFFFFFFF0000000001000000FFFFFFFF05000000FEFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFEFFFFFF01000000FEFFFFFF0300000000000000FCFFFFFFFDFFFFFFFFFFFFFF0200000000000000010000000000000001000000000000000000000000000000020000000000000005000000FFFFFFFFFDFFFFFF00000000FEFFFFFFFEFFFFFFFFFFFFFF0000000004000000FFFFFFFFFBFFFFFF03000000FCFFFFFFFDFFFFFF010000000300000002000000040000000200000000000000FCFFFFFF0500000000000000FEFFFFFFFFFFFFFF000000000300000003000000FDFFFFFFFCFFFFFF01000000000000000100000000000000FDFFFFFF04000000FCFFFFFF01000000FEFFFFFF0300000000000000FCFFFFFF000000000300000003000000FEFFFFFF000000000200000000000000FEFFFFFFF9FFFFFF0300000000000000000000000300000002000000FFFFFFFF0000000000000000FFFFFFFF0100000000000000FEFFFFFFFDFFFFFF00000000FEFFFFFFFAFFFFFFFEFFFFFFFEFFFFFF0000000000000000000000000000000005000000FEFFFFFF00000000FDFFFFFFFCFFFFFF"> : tensor<5x6x7xi32>
    return %0 : tensor<5x6x7xi32>
  }
}

