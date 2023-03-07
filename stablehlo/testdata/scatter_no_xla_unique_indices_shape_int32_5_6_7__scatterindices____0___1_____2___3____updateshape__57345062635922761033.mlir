// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0], [1]], [[2], [3]]]> : tensor<2x2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xi32>, tensor<5x2x2x7xi32>)
    %2 = call @expected() : () -> tensor<5x6x7xi32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<i32>, %arg1: tensor<i32>):
      stablehlo.return %arg1 : tensor<i32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 3], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xi32>, tensor<2x2x1xi32>, tensor<5x2x2x7xi32>) -> tensor<5x6x7xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xi32>, tensor<5x6x7xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xi32>, tensor<5x2x2x7xi32>) {
    %0 = stablehlo.constant dense<"0x0200000000000000090000000400000003000000FEFFFFFFFFFFFFFF040000000000000000000000000000000600000000000000FEFFFFFFFFFFFFFF02000000FEFFFFFF000000000000000000000000FDFFFFFF02000000020000000200000000000000FEFFFFFF0000000002000000FFFFFFFF02000000FFFFFFFF01000000FFFFFFFF02000000010000000700000000000000FDFFFFFF0000000000000000FFFFFFFF0200000003000000FCFFFFFF0100000002000000FDFFFFFF00000000020000000000000001000000000000000400000001000000FFFFFFFFFFFFFFFF0200000001000000FDFFFFFFFFFFFFFF00000000000000000000000004000000FDFFFFFFFCFFFFFFFEFFFFFFFAFFFFFF02000000FFFFFFFF01000000FEFFFFFF01000000010000000000000002000000030000000000000000000000FCFFFFFFFDFFFFFF02000000FFFFFFFF0200000004000000FFFFFFFF03000000FEFFFFFF0000000000000000FDFFFFFF06000000020000000300000002000000FDFFFFFFFEFFFFFF01000000FEFFFFFF02000000FEFFFFFFFFFFFFFF00000000FFFFFFFF00000000FEFFFFFF0000000000000000000000000100000001000000020000000100000000000000FEFFFFFF01000000FEFFFFFFFBFFFFFF04000000FDFFFFFFFDFFFFFF05000000FDFFFFFFFFFFFFFF03000000FEFFFFFFFFFFFFFFFEFFFFFF0300000001000000F9FFFFFFFCFFFFFFFFFFFFFF03000000FFFFFFFFFCFFFFFFFDFFFFFF03000000FFFFFFFF00000000FBFFFFFFFCFFFFFFFEFFFFFF010000000000000001000000FFFFFFFFFFFFFFFFFAFFFFFF020000000000000000000000000000000000000007000000FEFFFFFFFFFFFFFFFEFFFFFFFBFFFFFFFCFFFFFF0300000001000000000000000300000000000000FFFFFFFFFDFFFFFF01000000FBFFFFFFFEFFFFFF0400000003000000FFFFFFFFFDFFFFFFFDFFFFFFFFFFFFFFFEFFFFFF04000000000000000000000000000000010000000100000000000000010000000000000002000000030000000000000001000000FDFFFFFF020000000200000000000000FFFFFFFFFAFFFFFF00000000FDFFFFFF00000000020000000000000000000000FDFFFFFF01000000FBFFFFFF02000000000000000100000004000000FEFFFFFF"> : tensor<5x6x7xi32>
    %1 = stablehlo.constant dense<"0x0000000001000000FDFFFFFF02000000FCFFFFFF000000000100000006000000FFFFFFFF0700000000000000000000000000000000000000010000000A000000000000000400000001000000FFFFFFFF010000000100000000000000FCFFFFFF06000000FFFFFFFFFEFFFFFFFEFFFFFFFAFFFFFF02000000FFFFFFFFF8FFFFFF00000000FFFFFFFFFEFFFFFF00000000FAFFFFFF00000000FEFFFFFF00000000000000000000000004000000FDFFFFFFFFFFFFFFFBFFFFFFFCFFFFFF000000000000000001000000000000000100000000000000F9FFFFFF000000000100000002000000FDFFFFFFFFFFFFFFFFFFFFFF0300000000000000FBFFFFFFFAFFFFFF010000000000000002000000010000000100000004000000FDFFFFFFFEFFFFFF00000000FBFFFFFF01000000000000000100000004000000000000000000000001000000FEFFFFFF0300000003000000000000000100000001000000FEFFFFFFFEFFFFFF0000000005000000010000000000000002000000FDFFFFFF0300000000000000040000000400000004000000000000000200000001000000FEFFFFFF01000000040000000300000000000000FAFFFFFFF9FFFFFFFEFFFFFF0000000002000000FFFFFFFFFEFFFFFF01000000FEFFFFFF0400000003000000FFFFFFFF020000000600000003000000FDFFFFFF02000000FEFFFFFF00000000FBFFFFFFFDFFFFFF01000000FBFFFFFF02000000040000000000000000000000FDFFFFFFFCFFFFFFFDFFFFFFFAFFFFFFFFFFFFFF"> : tensor<5x2x2x7xi32>
    return %0, %1 : tensor<5x6x7xi32>, tensor<5x2x2x7xi32>
  }
  func.func private @expected() -> tensor<5x6x7xi32> {
    %0 = stablehlo.constant dense<"0x0000000001000000FDFFFFFF02000000FCFFFFFF000000000100000006000000FFFFFFFF0700000000000000000000000000000000000000010000000A000000000000000400000001000000FFFFFFFF010000000100000000000000FCFFFFFF06000000FFFFFFFFFEFFFFFFFEFFFFFFFFFFFFFF02000000FFFFFFFF01000000FFFFFFFF02000000010000000700000000000000FDFFFFFF0000000000000000FFFFFFFF02000000FAFFFFFF02000000FFFFFFFFF8FFFFFF00000000FFFFFFFFFEFFFFFF00000000FAFFFFFF00000000FEFFFFFF00000000000000000000000004000000FDFFFFFFFFFFFFFFFBFFFFFFFCFFFFFF000000000000000001000000000000000100000000000000F9FFFFFF000000000100000001000000FEFFFFFF01000000010000000000000002000000030000000000000000000000FCFFFFFFFDFFFFFF02000000FFFFFFFF0200000002000000FDFFFFFFFFFFFFFFFFFFFFFF0300000000000000FBFFFFFFFAFFFFFF010000000000000002000000010000000100000004000000FDFFFFFFFEFFFFFF00000000FBFFFFFF01000000000000000100000004000000000000000000000001000000FEFFFFFF03000000030000000100000000000000FEFFFFFF01000000FEFFFFFFFBFFFFFF04000000FDFFFFFFFDFFFFFF05000000FDFFFFFFFFFFFFFF03000000FEFFFFFF000000000100000001000000FEFFFFFFFEFFFFFF0000000005000000010000000000000002000000FDFFFFFF0300000000000000040000000400000004000000000000000200000001000000FEFFFFFF01000000040000000300000000000000FAFFFFFFF9FFFFFFFEFFFFFF0000000007000000FEFFFFFFFFFFFFFFFEFFFFFFFBFFFFFFFCFFFFFF0300000001000000000000000300000000000000FFFFFFFFFDFFFFFF0100000002000000FFFFFFFFFEFFFFFF01000000FEFFFFFF0400000003000000FFFFFFFF020000000600000003000000FDFFFFFF02000000FEFFFFFF00000000FBFFFFFFFDFFFFFF01000000FBFFFFFF02000000040000000000000000000000FDFFFFFFFCFFFFFFFDFFFFFFFAFFFFFFFFFFFFFF00000000FDFFFFFF00000000020000000000000000000000FDFFFFFF01000000FBFFFFFF02000000000000000100000004000000FEFFFFFF"> : tensor<5x6x7xi32>
    return %0 : tensor<5x6x7xi32>
  }
}

