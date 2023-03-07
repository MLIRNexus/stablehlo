// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi32>, tensor<20x20xi32>)
    %1 = call @expected() : () -> tensor<20x20xi32>
    %2 = stablehlo.and %0#0, %0#1 : tensor<20x20xi32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi32>, tensor<20x20xi32>) {
    %0 = stablehlo.constant dense<"0x0700000002000000FFFFFFFF02000000FEFFFFFFFFFFFFFFFEFFFFFF000000000200000000000000FFFFFFFF0400000000000000FFFFFFFFFBFFFFFF0400000000000000010000000700000001000000FFFFFFFF01000000FDFFFFFFFFFFFFFFFEFFFFFFFDFFFFFF020000000300000000000000FEFFFFFF04000000FDFFFFFF00000000FFFFFFFF0000000003000000000000000400000002000000010000000200000000000000FFFFFFFF000000000100000000000000FDFFFFFF00000000FCFFFFFF0100000002000000040000000000000002000000010000000300000003000000FFFFFFFF010000000300000000000000FFFFFFFFFEFFFFFF06000000FEFFFFFF0000000002000000FCFFFFFF000000000000000000000000FBFFFFFFF8FFFFFF02000000F9FFFFFF0000000002000000000000000200000003000000FEFFFFFF0200000000000000FFFFFFFF0000000000000000010000000000000003000000FAFFFFFFFFFFFFFF00000000FEFFFFFF04000000010000000300000002000000FFFFFFFF010000000100000001000000FDFFFFFFFEFFFFFF00000000FFFFFFFF04000000FFFFFFFF00000000FEFFFFFFFFFFFFFF000000000000000001000000FFFFFFFFFCFFFFFF0200000002000000FDFFFFFF01000000FDFFFFFFFCFFFFFFFCFFFFFF0300000003000000010000000100000000000000FBFFFFFF00000000FCFFFFFF0300000000000000FAFFFFFF0300000003000000FEFFFFFF0100000000000000FFFFFFFF00000000FEFFFFFF0000000000000000050000000100000004000000FFFFFFFF00000000F9FFFFFF0100000000000000FAFFFFFFFDFFFFFF0000000002000000FEFFFFFF030000000300000000000000020000000000000004000000FFFFFFFF00000000FFFFFFFF03000000FDFFFFFFFFFFFFFFFCFFFFFF040000000100000001000000FAFFFFFF0400000002000000FFFFFFFF010000000000000000000000FDFFFFFFFDFFFFFFFEFFFFFF020000000100000001000000FFFFFFFF00000000FCFFFFFF00000000FDFFFFFF03000000FDFFFFFFFDFFFFFF0000000000000000FCFFFFFF0000000002000000FFFFFFFFFDFFFFFF00000000000000000000000002000000FFFFFFFF02000000FEFFFFFF00000000FCFFFFFF0100000001000000020000000400000002000000FAFFFFFF00000000FFFFFFFFFDFFFFFF0700000001000000FFFFFFFFFFFFFFFFFCFFFFFF01000000FFFFFFFF00000000FFFFFFFF010000000200000003000000FCFFFFFFFDFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFAFFFFFF000000000000000003000000000000000600000000000000FDFFFFFF02000000FDFFFFFF00000000FEFFFFFF0000000000000000FEFFFFFF06000000050000000200000001000000FCFFFFFF0100000000000000FFFFFFFF010000000200000000000000FFFFFFFF0100000002000000FFFFFFFF000000000000000001000000FCFFFFFF03000000FBFFFFFF00000000FEFFFFFFFFFFFFFFFDFFFFFF03000000FFFFFFFFFDFFFFFF0000000003000000FCFFFFFF04000000FFFFFFFF01000000FAFFFFFF0200000000000000FFFFFFFF030000000100000000000000FFFFFFFF01000000000000000100000000000000FEFFFFFF02000000FDFFFFFF0000000000000000FEFFFFFFFCFFFFFF02000000FCFFFFFFFEFFFFFFFFFFFFFFFDFFFFFF0000000000000000020000000200000005000000050000000000000003000000FFFFFFFF04000000FDFFFFFF02000000FCFFFFFF0200000002000000020000000200000003000000FEFFFFFFFDFFFFFF000000000000000000000000FBFFFFFFFEFFFFFF04000000FEFFFFFFFFFFFFFF01000000F8FFFFFFF9FFFFFF0100000000000000FEFFFFFFFFFFFFFF0200000002000000FEFFFFFF0000000000000000FEFFFFFF03000000FEFFFFFF00000000FDFFFFFF01000000FCFFFFFFFFFFFFFFFEFFFFFF000000000300000000000000FDFFFFFFFCFFFFFF0400000000000000FFFFFFFF000000000400000003000000020000000100000003000000FBFFFFFF030000000000000000000000FFFFFFFF0100000000000000FEFFFFFF000000000000000001000000030000000000000000000000FFFFFFFFFCFFFFFFFEFFFFFF0200000000000000010000000000000000000000000000000000000003000000010000000500000000000000"> : tensor<20x20xi32>
    %1 = stablehlo.constant dense<"0xF9FFFFFF01000000020000000000000000000000FDFFFFFFFEFFFFFFFDFFFFFF0200000000000000FDFFFFFF0100000001000000FDFFFFFF0100000000000000FFFFFFFF010000000300000004000000010000000100000004000000FEFFFFFFFCFFFFFF00000000FEFFFFFF06000000FCFFFFFF05000000FEFFFFFFFFFFFFFFFFFFFFFF01000000FDFFFFFF010000000000000000000000FEFFFFFF010000000300000002000000FCFFFFFF0200000001000000FEFFFFFFFEFFFFFFFDFFFFFF000000000000000002000000FFFFFFFF00000000FCFFFFFF000000000200000004000000FFFFFFFF0100000002000000000000000300000003000000020000000000000000000000FFFFFFFFFEFFFFFF040000000000000000000000FCFFFFFF000000000300000000000000FCFFFFFF0000000005000000FEFFFFFF0700000003000000020000000100000001000000FFFFFFFF000000000000000000000000FDFFFFFF0200000000000000FFFFFFFF050000000200000001000000FFFFFFFF0000000001000000FEFFFFFF0000000000000000000000000200000002000000FFFFFFFF0000000005000000FFFFFFFF010000000000000000000000FCFFFFFF020000000000000001000000FEFFFFFF01000000000000000100000000000000FFFFFFFF00000000FEFFFFFFFDFFFFFF0200000000000000000000000000000000000000040000000000000003000000FEFFFFFFFFFFFFFF00000000FFFFFFFF02000000F8FFFFFF0200000000000000000000000200000000000000010000000000000000000000FDFFFFFFFCFFFFFF02000000FAFFFFFFFCFFFFFF01000000FFFFFFFF03000000000000000000000000000000F9FFFFFFFEFFFFFFFFFFFFFFFBFFFFFFFDFFFFFF000000000100000001000000FFFFFFFFFEFFFFFF020000000000000002000000000000000100000002000000000000000000000001000000FCFFFFFFFFFFFFFF00000000FEFFFFFF0200000000000000000000000000000001000000FDFFFFFF0200000003000000010000000400000000000000000000000200000002000000050000000200000000000000FEFFFFFFFCFFFFFF04000000FFFFFFFFFCFFFFFF000000000100000000000000FCFFFFFF0100000001000000FEFFFFFFFFFFFFFF0200000002000000FFFFFFFF00000000000000000400000000000000FAFFFFFF04000000FAFFFFFFFFFFFFFF0100000001000000020000000200000001000000FFFFFFFF0400000000000000FBFFFFFFFDFFFFFF02000000FFFFFFFFFEFFFFFF040000000100000005000000030000000000000005000000FEFFFFFF020000000200000000000000FEFFFFFF01000000010000000000000007000000010000000200000005000000FFFFFFFFFDFFFFFF00000000FFFFFFFF000000000000000001000000FEFFFFFF0200000000000000FEFFFFFF02000000FEFFFFFF01000000010000000600000000000000FFFFFFFF0100000003000000FCFFFFFFFDFFFFFFFBFFFFFFFFFFFFFF020000000100000002000000010000000200000000000000FFFFFFFF0000000004000000FBFFFFFF00000000020000000100000004000000000000000100000000000000FEFFFFFFFEFFFFFF000000000600000000000000FEFFFFFF01000000FFFFFFFF0300000000000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFF02000000FFFFFFFF03000000FFFFFFFF0400000000000000030000000200000005000000FCFFFFFFFFFFFFFF02000000FEFFFFFFFFFFFFFF0500000003000000000000000300000001000000FFFFFFFF020000000100000003000000010000000A0000000000000000000000000000000100000001000000FDFFFFFFFEFFFFFFFCFFFFFF01000000FDFFFFFFFFFFFFFF01000000000000000300000001000000FCFFFFFFFBFFFFFFFDFFFFFF04000000FFFFFFFF04000000FDFFFFFF00000000000000000000000000000000000000000300000001000000FFFFFFFF0000000000000000000000000000000000000000FCFFFFFFFFFFFFFFFDFFFFFFFEFFFFFFFFFFFFFF02000000FEFFFFFFFDFFFFFFFDFFFFFFFFFFFFFF03000000FCFFFFFF00000000FFFFFFFFFCFFFFFF000000000000000004000000FDFFFFFF00000000040000000300000000000000FDFFFFFF010000000100000000000000FFFFFFFF01000000000000000100000000000000FCFFFFFF"> : tensor<20x20xi32>
    return %0, %1 : tensor<20x20xi32>, tensor<20x20xi32>
  }
  func.func private @expected() -> tensor<20x20xi32> {
    %0 = stablehlo.constant dense<"0x0100000000000000020000000000000000000000FDFFFFFFFEFFFFFF000000000200000000000000FDFFFFFF0000000000000000FDFFFFFF010000000000000000000000010000000300000000000000010000000100000004000000FEFFFFFFFCFFFFFF000000000200000002000000000000000400000004000000FDFFFFFF00000000010000000000000001000000000000000000000002000000010000000200000000000000FCFFFFFF000000000100000000000000FCFFFFFF00000000000000000000000002000000040000000000000000000000000000000200000000000000FFFFFFFF010000000200000000000000030000000200000002000000000000000000000002000000FCFFFFFF000000000000000000000000F8FFFFFF0000000002000000000000000000000000000000000000000200000003000000020000000200000000000000010000000000000000000000000000000000000001000000020000000000000000000000040000000000000001000000030000000000000001000000000000000000000000000000000000000200000000000000FFFFFFFF000000000500000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000100000000000000FCFFFFFF0000000002000000010000000000000000000000000000000000000000000000040000000000000000000000FAFFFFFF0300000000000000FEFFFFFF00000000000000000200000000000000000000000000000000000000010000000000000000000000FDFFFFFF0000000000000000000000000000000000000000FDFFFFFF00000000000000000000000000000000010000000000000002000000000000000400000000000000000000000100000003000000FCFFFFFF020000000000000000000000000000000100000002000000000000000000000001000000000000000000000000000000FCFFFFFF0000000000000000000000000000000001000000FDFFFFFF000000000000000000000000040000000000000000000000000000000000000000000000000000000000000002000000FCFFFFFF040000000000000000000000000000000000000000000000000000000000000000000000FCFFFFFF0100000000000000020000000400000000000000000000000000000000000000F8FFFFFF0400000000000000FFFFFFFF0100000000000000000000000200000000000000FFFFFFFF000000000000000003000000FCFFFFFF00000000FFFFFFFFFEFFFFFF000000000100000000000000000000000000000001000000000000000200000000000000000000000200000001000000000000000000000000000000000000000200000004000000050000000000000000000000FCFFFFFF000000000000000001000000000000000200000000000000FEFFFFFF000000000200000001000000000000000000000000000000FCFFFFFF010000000300000000000000FCFFFFFFFBFFFFFFFDFFFFFF020000000100000000000000000000000200000000000000040000000000000000000000FAFFFFFF0000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000200000001000000000000000000000000000000FCFFFFFF02000000FCFFFFFFFEFFFFFF02000000FDFFFFFF0000000000000000000000000000000001000000000000000000000000000000FFFFFFFF00000000FCFFFFFF020000000400000002000000000000000200000000000000030000000200000001000000000000000000000000000000000000000000000000000000000000000100000001000000F8FFFFFFF8FFFFFF0100000000000000FEFFFFFF010000000000000002000000000000000000000000000000FCFFFFFF00000000FEFFFFFF00000000FDFFFFFF00000000000000000000000000000000000000000300000000000000FDFFFFFF0000000000000000000000000000000000000000040000000300000000000000000000000300000002000000020000000000000000000000FFFFFFFF0100000000000000000000000000000000000000000000000000000000000000000000000000000004000000020000000000000000000000010000000000000000000000000000000000000000000000010000000000000000000000"> : tensor<20x20xi32>
    return %0 : tensor<20x20xi32>
  }
}
