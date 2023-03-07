// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xi32>
    %1 = call @expected() : () -> tensor<20x30xi32>
    %2 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<20x30xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<20x30xi32>, tensor<20x30xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xi32> {
    %0 = stablehlo.constant dense<"0xFFFFFFFF0000000007000000FDFFFFFF020000000000000000000000020000000200000001000000FCFFFFFF03000000FEFFFFFFFCFFFFFF0200000001000000FFFFFFFF0500000003000000FEFFFFFF00000000FBFFFFFF00000000000000000100000004000000FEFFFFFFFEFFFFFFFDFFFFFF060000000000000003000000FCFFFFFF0000000003000000040000000400000000000000000000000100000001000000FFFFFFFF01000000FCFFFFFF00000000FEFFFFFFFDFFFFFF00000000FCFFFFFF00000000FFFFFFFFFFFFFFFF0200000003000000FFFFFFFF050000000300000000000000FFFFFFFF000000000800000000000000FEFFFFFF02000000FDFFFFFF00000000FFFFFFFF03000000FAFFFFFF00000000FEFFFFFFFCFFFFFF00000000010000000700000000000000FCFFFFFF02000000FFFFFFFFFFFFFFFF00000000FFFFFFFF01000000FCFFFFFF04000000FCFFFFFFFDFFFFFF0100000001000000FEFFFFFF0000000006000000030000000200000002000000FEFFFFFF01000000FCFFFFFF0000000000000000FEFFFFFF01000000FDFFFFFFFCFFFFFFFFFFFFFF050000000000000000000000FCFFFFFF0100000002000000FBFFFFFF0200000004000000FEFFFFFFFEFFFFFF04000000FEFFFFFF02000000FEFFFFFF03000000FEFFFFFF030000000200000000000000070000000000000004000000010000000200000000000000FEFFFFFF0200000000000000030000000400000000000000FDFFFFFF0200000005000000FFFFFFFF01000000FDFFFFFF030000000400000000000000FFFFFFFFFCFFFFFFFCFFFFFF010000000300000000000000000000000000000000000000FFFFFFFFFEFFFFFF0000000000000000FEFFFFFF00000000FBFFFFFF02000000FEFFFFFF000000000000000005000000FEFFFFFF04000000FFFFFFFFFEFFFFFFFDFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF0600000001000000000000000000000002000000FEFFFFFF0000000003000000FFFFFFFFFFFFFFFF06000000FDFFFFFFFBFFFFFFFFFFFFFF01000000020000000300000000000000FFFFFFFF00000000000000000200000000000000FFFFFFFFFEFFFFFF03000000FCFFFFFF0100000004000000FCFFFFFFFCFFFFFF0000000004000000020000000200000000000000FFFFFFFFF9FFFFFFFDFFFFFF01000000FAFFFFFF00000000FEFFFFFFFEFFFFFF0400000002000000030000000800000000000000000000000000000001000000FFFFFFFF00000000000000000000000001000000FDFFFFFF0200000002000000FFFFFFFFFDFFFFFFFCFFFFFF0000000000000000000000000700000000000000FEFFFFFF00000000FDFFFFFFFEFFFFFFFEFFFFFFFDFFFFFF00000000FFFFFFFFFDFFFFFFFFFFFFFFFEFFFFFF01000000FFFFFFFF0100000000000000000000000000000003000000FFFFFFFF0000000002000000FEFFFFFF01000000FFFFFFFF020000000300000001000000FEFFFFFF0100000000000000FBFFFFFFFFFFFFFF00000000FDFFFFFF030000000300000000000000FEFFFFFF00000000FDFFFFFF04000000FEFFFFFF00000000010000000000000002000000FDFFFFFFFAFFFFFFFEFFFFFF0000000004000000FDFFFFFFFFFFFFFFFBFFFFFFFFFFFFFF0300000001000000FDFFFFFF0000000000000000000000000000000000000000FFFFFFFF0000000005000000FEFFFFFFFEFFFFFFFDFFFFFF0100000000000000FEFFFFFF050000000000000001000000FEFFFFFFFFFFFFFF0000000000000000FCFFFFFF0300000002000000000000000600000003000000FDFFFFFF0200000003000000FEFFFFFF000000000000000002000000FDFFFFFF00000000FEFFFFFFFAFFFFFFFEFFFFFF040000000300000002000000FAFFFFFF00000000F6FFFFFF000000000000000003000000FCFFFFFF0700000002000000FFFFFFFF00000000FFFFFFFF010000000000000000000000FCFFFFFF00000000FDFFFFFFFFFFFFFF00000000FEFFFFFF00000000FDFFFFFF020000000000000000000000FCFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFEFFFFFF00000000FDFFFFFFFFFFFFFF000000000000000002000000FDFFFFFFFFFFFFFFFFFFFFFF00000000030000000000000001000000FEFFFFFFFEFFFFFFFEFFFFFF0400000000000000030000000000000002000000FDFFFFFFFEFFFFFF0000000001000000FDFFFFFF0100000000000000030000000200000000000000F9FFFFFFFFFFFFFFFFFFFFFF04000000FEFFFFFF03000000FAFFFFFFFDFFFFFFFEFFFFFF00000000FDFFFFFFFFFFFFFFFFFFFFFF0000000000000000FEFFFFFFFFFFFFFF0100000001000000FDFFFFFFFCFFFFFF0000000000000000FBFFFFFFFFFFFFFFFCFFFFFF0100000007000000FEFFFFFFFEFFFFFF0000000000000000FEFFFFFF00000000020000000500000006000000000000000000000003000000FFFFFFFF040000000000000000000000FEFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FDFFFFFF00000000030000000000000000000000FFFFFFFF0300000000000000FFFFFFFFF8FFFFFF0000000000000000000000000400000002000000FCFFFFFFFFFFFFFF0200000001000000040000000000000002000000FFFFFFFF020000000100000000000000FCFFFFFF0000000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000400000005000000FCFFFFFFFEFFFFFF02000000FFFFFFFF00000000000000000200000002000000010000000300000003000000000000000700000000000000FFFFFFFFFDFFFFFF010000000200000002000000FFFFFFFF050000000000000003000000FFFFFFFF00000000FDFFFFFFF9FFFFFF00000000FFFFFFFF010000000000000000000000000000000100000002000000FCFFFFFFFEFFFFFFFCFFFFFFFEFFFFFF020000000100000001000000030000000000000005000000FDFFFFFF0100000005000000FCFFFFFF0100000002000000FFFFFFFF02000000000000000500000001000000FDFFFFFFFCFFFFFF01000000FDFFFFFF010000000800000003000000000000000400000002000000FEFFFFFF00000000FEFFFFFFFAFFFFFF0900000002000000FEFFFFFFFFFFFFFF03000000010000000100000001000000FFFFFFFFFBFFFFFF02000000FFFFFFFFFEFFFFFF0000000000000000FFFFFFFF00000000FDFFFFFFFFFFFFFF0100000001000000010000000100000002000000FEFFFFFFFEFFFFFF0300000000000000FFFFFFFFFAFFFFFF00000000FFFFFFFF0100000004000000FDFFFFFFFDFFFFFF"> : tensor<20x30xi32>
    return %0 : tensor<20x30xi32>
  }
  func.func private @expected() -> tensor<20x30xi32> {
    %0 = stablehlo.constant dense<1> : tensor<20x30xi32>
    return %0 : tensor<20x30xi32>
  }
}
