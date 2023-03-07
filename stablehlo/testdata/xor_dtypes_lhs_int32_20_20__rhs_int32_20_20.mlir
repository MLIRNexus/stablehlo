// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi32>, tensor<20x20xi32>)
    %1 = call @expected() : () -> tensor<20x20xi32>
    %2 = stablehlo.xor %0#0, %0#1 : tensor<20x20xi32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi32>, tensor<20x20xi32>) {
    %0 = stablehlo.constant dense<"0x01000000FEFFFFFF03000000FFFFFFFF060000000200000000000000FCFFFFFF00000000FCFFFFFFFDFFFFFFFDFFFFFFFFFFFFFF020000000400000004000000FFFFFFFF01000000FDFFFFFFFBFFFFFF0100000002000000FFFFFFFFF9FFFFFFFEFFFFFF01000000FFFFFFFF0000000003000000FDFFFFFF00000000030000000100000000000000FBFFFFFF010000000000000001000000FFFFFFFF020000000100000006000000FFFFFFFF0000000001000000040000000200000001000000FFFFFFFFFEFFFFFFFFFFFFFF05000000FDFFFFFFFDFFFFFF0100000000000000000000000400000001000000FDFFFFFF04000000FBFFFFFF02000000FFFFFFFF0000000004000000FDFFFFFFFFFFFFFFFBFFFFFFFEFFFFFF02000000FFFFFFFF01000000FEFFFFFFFCFFFFFFFEFFFFFF03000000FEFFFFFF00000000FCFFFFFFFEFFFFFF02000000FFFFFFFFFFFFFFFF01000000010000000100000003000000FEFFFFFF0400000000000000FEFFFFFFFFFFFFFF0000000005000000000000000500000000000000FEFFFFFF0000000001000000FEFFFFFF0000000002000000040000000100000002000000000000000000000001000000FEFFFFFFFFFFFFFF0100000002000000020000000000000001000000FEFFFFFFFFFFFFFF0100000002000000000000000000000004000000FFFFFFFF01000000020000000000000004000000FFFFFFFF01000000FDFFFFFFFDFFFFFFFFFFFFFF00000000000000000300000000000000020000000500000000000000050000000000000001000000FDFFFFFF0200000004000000040000000200000005000000FCFFFFFF02000000060000000000000001000000FFFFFFFF04000000000000000000000001000000FFFFFFFF03000000FEFFFFFF01000000000000000300000000000000FEFFFFFFFFFFFFFF010000000000000006000000FEFFFFFF000000000100000003000000FFFFFFFFFBFFFFFFFDFFFFFF0200000000000000050000000400000000000000FEFFFFFFFCFFFFFF05000000FDFFFFFF000000000000000001000000FCFFFFFF03000000FDFFFFFF02000000FEFFFFFF04000000000000000100000004000000FFFFFFFFFDFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFDFFFFFFFDFFFFFF0000000002000000FEFFFFFF00000000000000000000000000000000000000000100000003000000080000000300000000000000000000000200000000000000F9FFFFFF0200000001000000FCFFFFFF08000000FFFFFFFF020000000300000001000000050000000300000000000000FCFFFFFFFFFFFFFF000000000100000002000000FEFFFFFF0000000003000000FEFFFFFFFCFFFFFFFBFFFFFF00000000FFFFFFFF0000000000000000FDFFFFFF0400000001000000FFFFFFFFFEFFFFFFFEFFFFFFFFFFFFFF0000000001000000FEFFFFFF0000000002000000FFFFFFFFFEFFFFFF010000000500000001000000FBFFFFFF02000000FEFFFFFF000000000200000008000000FEFFFFFFFDFFFFFFFBFFFFFFFDFFFFFF0100000000000000FEFFFFFF00000000FAFFFFFF00000000000000000600000000000000FDFFFFFF000000000000000002000000FFFFFFFF01000000FEFFFFFF0000000000000000FFFFFFFF0200000000000000FFFFFFFFFFFFFFFF000000000100000002000000FFFFFFFF0000000001000000000000000100000004000000FEFFFFFFFDFFFFFFFCFFFFFF01000000FFFFFFFF000000000000000002000000FFFFFFFFFFFFFFFF00000000000000000100000000000000FCFFFFFF02000000FEFFFFFF00000000FDFFFFFF060000000200000001000000040000000200000001000000FDFFFFFFFFFFFFFFFCFFFFFF030000000800000001000000FEFFFFFFFCFFFFFFFDFFFFFFFCFFFFFFFDFFFFFF02000000FEFFFFFF0300000000000000FAFFFFFF000000000000000008000000FEFFFFFF06000000FEFFFFFF01000000020000000400000000000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFEFFFFFF00000000000000000000000001000000010000000700000000000000FEFFFFFF00000000000000000000000000000000010000000000000003000000FDFFFFFF02000000FDFFFFFFFBFFFFFF020000000000000000000000FAFFFFFF0000000003000000FFFFFFFF00000000000000000500000001000000FBFFFFFF0300000000000000"> : tensor<20x20xi32>
    %1 = stablehlo.constant dense<"0xFFFFFFFF01000000FFFFFFFF02000000000000000000000000000000030000000200000000000000000000000000000003000000FEFFFFFF010000000600000001000000030000000000000000000000FFFFFFFF03000000040000000300000002000000FFFFFFFFFFFFFFFF0A000000000000000000000004000000FDFFFFFFFCFFFFFF030000000100000001000000FFFFFFFF00000000FDFFFFFFFBFFFFFFFFFFFFFFFFFFFFFF0000000001000000FEFFFFFFFBFFFFFF03000000FEFFFFFF070000000100000000000000070000000300000001000000FEFFFFFF000000000200000005000000FFFFFFFF0000000000000000FEFFFFFF010000000100000001000000FEFFFFFF0000000001000000FEFFFFFF0000000000000000FFFFFFFFFEFFFFFF0000000000000000000000000000000003000000020000000000000001000000FEFFFFFFFAFFFFFF01000000FDFFFFFFFDFFFFFF0100000004000000FFFFFFFFFBFFFFFFFEFFFFFF010000000100000000000000FEFFFFFF06000000030000000000000002000000FBFFFFFFFFFFFFFFFEFFFFFF040000000100000000000000FCFFFFFF04000000000000000000000006000000FFFFFFFFFCFFFFFF0000000004000000FDFFFFFF00000000FDFFFFFFFDFFFFFF00000000010000000100000000000000FFFFFFFF0100000001000000FEFFFFFFFBFFFFFF0400000000000000FBFFFFFF0400000003000000FDFFFFFF010000000000000001000000000000000300000000000000060000000000000002000000FFFFFFFF0000000000000000FCFFFFFFFEFFFFFFFFFFFFFFFDFFFFFF0100000000000000FFFFFFFFFCFFFFFF02000000020000000200000004000000000000000000000000000000FFFFFFFF01000000FEFFFFFFFBFFFFFF000000000000000005000000FFFFFFFFFDFFFFFF0000000001000000000000000000000000000000010000000400000002000000FDFFFFFF03000000010000000100000000000000010000000000000000000000030000000400000002000000FFFFFFFF0100000002000000FFFFFFFF06000000FBFFFFFF0000000002000000FDFFFFFF00000000FFFFFFFFFEFFFFFFFFFFFFFF030000000000000000000000FFFFFFFF0000000001000000FFFFFFFF00000000FFFFFFFF01000000FFFFFFFFFCFFFFFF00000000000000000300000000000000F9FFFFFF00000000FEFFFFFF01000000FEFFFFFF00000000FDFFFFFFFCFFFFFFFFFFFFFFFCFFFFFF02000000FFFFFFFFFEFFFFFF00000000FDFFFFFF03000000FFFFFFFFFFFFFFFF00000000FFFFFFFF06000000030000000100000000000000FAFFFFFFFEFFFFFF000000000100000001000000FFFFFFFF010000000100000000000000FEFFFFFFFCFFFFFF020000000000000002000000F9FFFFFF0000000001000000FEFFFFFF0000000001000000000000000300000000000000020000000000000004000000020000000000000000000000010000000400000001000000FFFFFFFFFEFFFFFF00000000FFFFFFFF010000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF01000000FDFFFFFFFFFFFFFF01000000FCFFFFFF0600000007000000FDFFFFFF0500000003000000FEFFFFFF00000000FAFFFFFF0200000000000000FEFFFFFFFEFFFFFF0100000002000000FEFFFFFFFBFFFFFF02000000050000000000000001000000FEFFFFFFFFFFFFFF00000000010000000700000000000000FCFFFFFFFDFFFFFF050000000300000000000000FFFFFFFF02000000FEFFFFFF00000000FFFFFFFFF7FFFFFFFBFFFFFF00000000030000000200000001000000F7FFFFFF0100000008000000FBFFFFFF000000000000000000000000FAFFFFFF03000000FDFFFFFF03000000FEFFFFFFFEFFFFFF020000000000000002000000010000000000000000000000FDFFFFFFFEFFFFFFF9FFFFFF0100000003000000000000000100000002000000000000000000000000000000FEFFFFFFFCFFFFFF0100000003000000010000000000000000000000FEFFFFFFFDFFFFFFFCFFFFFFFEFFFFFF02000000030000000100000000000000FDFFFFFF00000000FEFFFFFF0000000004000000FDFFFFFF0000000002000000000000000200000001000000FEFFFFFFFDFFFFFF00000000FFFFFFFFFCFFFFFFFFFFFFFFFBFFFFFFFBFFFFFF020000000000000002000000FFFFFFFF07000000FFFFFFFF"> : tensor<20x20xi32>
    return %0, %1 : tensor<20x20xi32>, tensor<20x20xi32>
  }
  func.func private @expected() -> tensor<20x20xi32> {
    %0 = stablehlo.constant dense<"0xFEFFFFFFFFFFFFFFFCFFFFFFFDFFFFFF060000000200000000000000FFFFFFFF02000000FCFFFFFFFDFFFFFFFDFFFFFFFCFFFFFFFCFFFFFF0500000002000000FEFFFFFF02000000FDFFFFFFFBFFFFFFFEFFFFFF01000000FBFFFFFFFAFFFFFFFCFFFFFFFEFFFFFF000000000A00000003000000FDFFFFFF04000000FEFFFFFFFDFFFFFF03000000FAFFFFFF00000000FFFFFFFF0100000002000000F9FFFFFFFEFFFFFFF9FFFFFFFFFFFFFF01000000FFFFFFFFFFFFFFFF01000000FFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFF02000000FEFFFFFFFCFFFFFFFFFFFFFF000000000200000001000000FEFFFFFFFDFFFFFF040000000500000003000000FEFFFFFF01000000FAFFFFFFFDFFFFFFFEFFFFFF05000000FEFFFFFF0200000000000000FFFFFFFFFEFFFFFFFCFFFFFFFEFFFFFF03000000FDFFFFFF02000000FCFFFFFFFFFFFFFFFCFFFFFF05000000FEFFFFFFFCFFFFFFFCFFFFFF000000000700000001000000FFFFFFFFFEFFFFFFFFFFFFFFFEFFFFFF00000000FBFFFFFF060000000600000000000000FCFFFFFFFBFFFFFFFEFFFFFF00000000040000000300000004000000FDFFFFFF0600000000000000000000000700000001000000030000000100000006000000FFFFFFFF00000000FCFFFFFF03000000FFFFFFFF000000000300000000000000FFFFFFFF05000000FEFFFFFFFFFFFFFFF9FFFFFF04000000040000000400000005000000FEFFFFFF00000000FEFFFFFF0000000001000000030000000300000002000000030000000000000007000000FFFFFFFF01000000FDFFFFFFFEFFFFFFFAFFFFFFFBFFFFFFFFFFFFFF04000000FCFFFFFFFDFFFFFFFAFFFFFF0200000003000000FDFFFFFF00000000000000000000000001000000000000000200000000000000FAFFFFFF0000000003000000050000000100000002000000010000000100000006000000FEFFFFFF000000000000000007000000FDFFFFFF06000000FEFFFFFF0300000001000000050000000500000000000000FEFFFFFFFFFFFFFF01000000FFFFFFFFFFFFFFFF010000000300000003000000050000000600000002000000FCFFFFFFF9FFFFFF00000000FEFFFFFFFAFFFFFF00000000FEFFFFFFFFFFFFFF00000000FFFFFFFF00000000FEFFFFFF02000000FDFFFFFFFFFFFFFF0300000001000000FCFFFFFF00000000000000000300000000000000F8FFFFFF03000000F6FFFFFF02000000FEFFFFFF00000000FFFFFFFFFCFFFFFF06000000FEFFFFFF0300000003000000F6FFFFFFFFFFFFFFFFFFFFFF00000000FEFFFFFFFAFFFFFF03000000FFFFFFFFFAFFFFFFFCFFFFFF0100000001000000F8FFFFFF000000000000000002000000FFFFFFFF03000000FAFFFFFF01000000FFFFFFFFFEFFFFFFFCFFFFFFFFFFFFFF040000000300000006000000FEFFFFFFFFFFFFFF010000000000000000000000FEFFFFFF0300000002000000FDFFFFFFFEFFFFFF050000000700000001000000FBFFFFFF03000000FAFFFFFF01000000FDFFFFFFF6FFFFFFFEFFFFFF02000000FAFFFFFFFDFFFFFF01000000FFFFFFFF01000000FFFFFFFFFBFFFFFFFDFFFFFFFFFFFFFF07000000FCFFFFFFFBFFFFFF07000000FDFFFFFF07000000FCFFFFFFFFFFFFFFFEFFFFFFFAFFFFFF02000000FFFFFFFFFCFFFFFFFEFFFFFFFEFFFFFFFDFFFFFFFEFFFFFFFAFFFFFF00000000FAFFFFFF0000000000000000FEFFFFFFFEFFFFFF04000000FFFFFFFFFAFFFFFFFCFFFFFFFDFFFFFF0200000005000000030000000200000000000000FDFFFFFFFEFFFFFF00000000FEFFFFFFF7FFFFFF0700000002000000FDFFFFFF02000000FCFFFFFFF1FFFFFF0300000009000000FFFFFFFF0200000001000000FDFFFFFF05000000FFFFFFFFFEFFFFFF0B000000FFFFFFFF00000000FEFFFFFFFDFFFFFFFEFFFFFFFCFFFFFF02000000FEFFFFFFFEFFFFFFFEFFFFFF03000000010000000300000008000000FFFFFFFF04000000FEFFFFFF0100000002000000FAFFFFFFFCFFFFFFFEFFFFFF03000000FEFFFFFFFFFFFFFFFEFFFFFFFEFFFFFFFDFFFFFFFCFFFFFFFFFFFFFF030000000400000001000000FEFFFFFFFDFFFFFF00000000FEFFFFFF0000000005000000FDFFFFFF03000000FFFFFFFF02000000FFFFFFFFFAFFFFFFFCFFFFFFFDFFFFFF0000000005000000FCFFFFFFFCFFFFFF04000000FBFFFFFF0200000005000000030000000400000004000000FFFFFFFF"> : tensor<20x20xi32>
    return %0 : tensor<20x20xi32>
  }
}
