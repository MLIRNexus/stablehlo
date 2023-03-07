// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xi32>, tensor<20x20xi32>)
    %1 = call @expected() : () -> tensor<20x20xi32>
    %2 = stablehlo.shift_right_logical %0#0, %0#1 : tensor<20x20xi32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xi32>, tensor<20x20xi32>) {
    %0 = stablehlo.constant dense<"0x02000000010000000000000001000000010000000300000003000000FFFFFFFF02000000FDFFFFFF02000000FEFFFFFF02000000000000000200000000000000FEFFFFFF03000000FEFFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF020000000000000003000000FFFFFFFF010000000400000001000000F7FFFFFFFDFFFFFFFFFFFFFFFBFFFFFF0000000000000000010000000200000002000000FCFFFFFFFEFFFFFFFBFFFFFF030000000000000000000000FBFFFFFF0400000003000000FEFFFFFFFFFFFFFF0000000003000000FDFFFFFFFDFFFFFF0200000002000000FEFFFFFF00000000FEFFFFFF00000000000000000000000002000000FDFFFFFF0200000001000000FDFFFFFFFFFFFFFF000000000000000004000000000000000200000003000000FEFFFFFF0000000000000000FFFFFFFFFBFFFFFF00000000000000000300000005000000FFFFFFFF0200000000000000FEFFFFFF010000000100000002000000FEFFFFFF000000000000000002000000FFFFFFFF02000000FFFFFFFF0000000000000000040000000000000000000000FEFFFFFF000000000000000000000000020000000000000001000000FEFFFFFF050000000100000006000000FEFFFFFF000000000000000003000000FEFFFFFF0000000001000000FFFFFFFFFCFFFFFF0300000001000000010000000000000000000000010000000300000000000000030000000100000000000000FAFFFFFF0300000005000000FEFFFFFF0000000004000000FEFFFFFF00000000FDFFFFFF0100000000000000020000000000000000000000000000000000000002000000040000000000000000000000000000000400000009000000FBFFFFFF040000000100000002000000FFFFFFFFFEFFFFFFF9FFFFFF0000000003000000FDFFFFFF05000000FDFFFFFF050000000000000001000000FEFFFFFFFEFFFFFF050000000000000003000000000000000000000004000000FFFFFFFFFEFFFFFFFDFFFFFF03000000000000000100000001000000FEFFFFFFFBFFFFFF050000000100000001000000FCFFFFFFFDFFFFFF000000000000000001000000000000000100000000000000010000000000000007000000FFFFFFFFFFFFFFFFFCFFFFFFFDFFFFFF00000000FDFFFFFFFEFFFFFF0300000003000000FDFFFFFFFDFFFFFF00000000FEFFFFFF0200000001000000FDFFFFFF03000000FFFFFFFF000000000000000000000000FDFFFFFF0000000008000000FFFFFFFF0100000000000000FDFFFFFF0000000000000000000000000300000001000000FCFFFFFF02000000010000000500000004000000FEFFFFFF00000000FEFFFFFF00000000FAFFFFFFFAFFFFFFFEFFFFFF010000000100000002000000FEFFFFFF0200000004000000FCFFFFFF010000000200000002000000F6FFFFFFFCFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF01000000FEFFFFFFFDFFFFFF010000000000000001000000000000000000000000000000FFFFFFFF00000000FDFFFFFF010000000300000001000000030000000000000003000000FDFFFFFF03000000FCFFFFFF000000000200000001000000FDFFFFFFFFFFFFFFFEFFFFFF0100000001000000FEFFFFFF0100000000000000FFFFFFFFFBFFFFFFFEFFFFFF0000000000000000FDFFFFFF0000000002000000FFFFFFFFFEFFFFFFFCFFFFFFFCFFFFFFFDFFFFFF00000000050000000000000001000000FEFFFFFF00000000FBFFFFFFFEFFFFFF00000000FFFFFFFFFFFFFFFF0300000002000000FBFFFFFFFFFFFFFF000000000100000000000000FFFFFFFFFFFFFFFF02000000FFFFFFFF02000000000000000000000000000000FEFFFFFF030000000000000004000000FEFFFFFFFDFFFFFFFEFFFFFFFFFFFFFF01000000FFFFFFFFFCFFFFFF01000000060000000100000000000000020000000100000003000000000000000300000002000000FDFFFFFF00000000FDFFFFFF0100000003000000FDFFFFFF000000000100000001000000FEFFFFFFFDFFFFFF0000000000000000FEFFFFFFFDFFFFFFFDFFFFFF0100000005000000FCFFFFFF0500000000000000000000000100000000000000FEFFFFFF01000000FEFFFFFF05000000FEFFFFFF00000000FEFFFFFFFEFFFFFF00000000FFFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFDFFFFFF0000000000000000FEFFFFFF0000000000000000FFFFFFFF"> : tensor<20x20xi32>
    %1 = stablehlo.constant dense<"0x00000000050000000000000000000000FDFFFFFF02000000FFFFFFFF0400000001000000020000000000000002000000FFFFFFFF03000000FFFFFFFFFBFFFFFFFFFFFFFFFDFFFFFF06000000FDFFFFFF0000000000000000FEFFFFFF00000000FEFFFFFF02000000FEFFFFFFFFFFFFFF01000000030000000000000000000000F9FFFFFF0500000000000000010000000000000000000000010000000000000001000000010000000000000000000000000000000000000001000000FCFFFFFFFEFFFFFF0000000000000000000000000200000001000000FFFFFFFF00000000FDFFFFFF00000000FFFFFFFF02000000FBFFFFFF00000000FDFFFFFFFCFFFFFFFEFFFFFFFFFFFFFFF8FFFFFF02000000070000000000000001000000FAFFFFFFFEFFFFFF0200000001000000FEFFFFFFFFFFFFFF06000000000000000000000004000000000000000000000000000000FFFFFFFF03000000020000000000000006000000FFFFFFFFFFFFFFFF04000000FFFFFFFF0300000000000000FEFFFFFF000000000000000001000000000000000100000000000000FBFFFFFFFEFFFFFFFEFFFFFFFBFFFFFF0000000003000000030000000800000001000000010000000400000004000000FAFFFFFFFFFFFFFF0000000005000000FBFFFFFF0300000000000000FEFFFFFFFFFFFFFFFEFFFFFFFEFFFFFF0000000000000000FFFFFFFFFEFFFFFF0300000000000000FDFFFFFF0500000002000000FFFFFFFFFFFFFFFF020000000000000002000000FCFFFFFF01000000000000000000000003000000FCFFFFFFFFFFFFFF000000000000000007000000FCFFFFFFFEFFFFFF00000000FFFFFFFF00000000FDFFFFFF01000000FCFFFFFF00000000000000000000000000000000FEFFFFFF0400000007000000FAFFFFFF0300000001000000010000000000000002000000FDFFFFFF000000000100000000000000FFFFFFFF040000000000000002000000FEFFFFFFFEFFFFFF0400000001000000FCFFFFFFFEFFFFFF0000000003000000FDFFFFFF00000000FFFFFFFFFDFFFFFF000000000300000005000000020000000000000000000000FCFFFFFF0000000000000000FEFFFFFF0000000003000000FAFFFFFF00000000FEFFFFFF03000000FBFFFFFF0500000001000000FFFFFFFFFEFFFFFF0000000002000000FBFFFFFF00000000FAFFFFFF01000000FCFFFFFF010000000800000000000000FEFFFFFF02000000FEFFFFFF00000000FAFFFFFF05000000FCFFFFFF0100000002000000FBFFFFFFFFFFFFFFFCFFFFFF040000000000000005000000FFFFFFFFFDFFFFFF02000000FFFFFFFFFDFFFFFF0200000001000000FCFFFFFF00000000000000000400000000000000FFFFFFFF020000000000000000000000030000000000000000000000FCFFFFFF000000000200000000000000020000000100000000000000FFFFFFFF00000000060000000000000002000000000000000000000002000000FDFFFFFFFFFFFFFFFBFFFFFF0200000000000000010000000300000003000000FDFFFFFF030000000200000001000000FAFFFFFF030000000000000004000000F9FFFFFFFDFFFFFFFFFFFFFF0100000000000000FCFFFFFF00000000FEFFFFFF06000000020000000200000000000000FCFFFFFFFCFFFFFF02000000FDFFFFFF010000000200000001000000FFFFFFFFFFFFFFFF0200000000000000FFFFFFFF03000000FEFFFFFF00000000FFFFFFFF0200000000000000FDFFFFFFFFFFFFFFFFFFFFFFFAFFFFFFFFFFFFFF01000000020000000600000001000000FEFFFFFF0200000000000000FCFFFFFF01000000FAFFFFFFF8FFFFFF0000000002000000010000000000000003000000FDFFFFFFFDFFFFFF02000000010000000000000004000000FEFFFFFF00000000FBFFFFFF000000000200000001000000FEFFFFFFFEFFFFFF030000000200000000000000FFFFFFFF030000000000000001000000030000000100000004000000FEFFFFFF0000000000000000FEFFFFFF040000000300000005000000000000000000000003000000FBFFFFFFFAFFFFFF000000000200000000000000FFFFFFFFFFFFFFFF02000000FCFFFFFFFFFFFFFFFDFFFFFF0000000000000000FCFFFFFFFEFFFFFF03000000FBFFFFFFFFFFFFFF040000000100000001000000FBFFFFFFFEFFFFFF0400000003000000FEFFFFFF0000000003000000FCFFFFFF"> : tensor<20x20xi32>
    return %0, %1 : tensor<20x20xi32>, tensor<20x20xi32>
  }
  func.func private @expected() -> tensor<20x20xi32> {
    %0 = stablehlo.constant dense<"0x02000000000000000000000001000000000000000000000000000000FFFFFF0F01000000FFFFFF3F02000000FFFFFF3F000000000000000000000000000000000000000000000000FFFFFF0300000000FFFFFFFFFFFFFFFF0000000002000000000000000000000000000000000000000200000000000000F7FFFFFFFDFFFFFF00000000FFFFFF070000000000000000010000000200000001000000FCFFFFFFFFFFFF7FFDFFFF7F030000000000000000000000FBFFFFFF020000000000000000000000FFFFFFFF0000000003000000FFFFFF3FFEFFFF7F00000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFF3F000000000000000002000000000000000000000000000000FFFFFF7F0000000000000000FFFFFF03FBFFFFFF00000000000000000300000005000000FFFFFFFF0000000000000000FFFFFF3F01000000000000000000000000000000000000000000000000000000FFFFFFFF00000000FFFFFFFF000000000000000004000000000000000000000000000000000000000000000000000000020000000000000000000000FFFFFF00020000000000000000000000FFFFFF0F000000000000000003000000FFFFFF070000000000000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000030000000000000000000000FEFFFF3F0000000000000000FFFFFF3F00000000010000000000000000000000FDFFFFFF010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000040000000100000002000000FFFFFFFF00000000FFFFFF0F0000000000000000FFFFFF1F02000000FEFFFF7F050000000000000000000000FEFFFFFFFFFFFF7F05000000000000000000000000000000000000000000000000000000FFFFFF0FFEFFFF7F0000000000000000010000000000000000000000FBFFFFFF000000000000000001000000FFFFFF1FFFFFFF0700000000000000000100000000000000010000000000000000000000000000000000000000000000FFFFFFFF00000000FFFFFF1F00000000FFFFFF07FFFFFF7F0000000000000000FDFFFFFFFFFFFF3F00000000FEFFFFFF00000000000000000000000001000000FFFFFF00000000000000000000000000000000000000000000000000FFFFFF070000000000000000FFFFFF3F0000000000000000000000000000000001000000FFFFFF07000000000000000001000000000000000000000000000000FFFFFF7F00000000FAFFFFFFFAFFFFFFFFFFFF0F010000000000000000000000FEFFFFFF0200000000000000FCFFFFFF010000000000000002000000FDFFFF3FFCFFFFFFFFFFFF3FFFFFFF7FFFFFFFFF00000000FDFFFFFF00000000FEFFFFFFFFFFFF3F010000000000000000000000000000000000000000000000FFFFFF3F00000000FEFFFF7F0000000000000000000000000000000000000000010000000000000000000000FCFFFFFF00000000000000000000000000000000FFFFFF7FFEFFFFFF0000000001000000000000000000000000000000FFFFFF3FFBFFFFFF000000000000000000000000000000000000000000000000FFFFFF7F0000000000000000FFFFFF3FFDFFFFFF000000000000000000000000010000000000000000000000FBFFFFFF000000000000000000000000000000000000000001000000FEFFFF3FFFFFFF03000000000000000000000000FFFFFFFF00000000010000000000000000000000000000000000000000000000FEFFFFFF000000000000000000000000FFFFFF3FFEFFFF7FFEFFFFFFFFFFFF0F00000000FFFFFFFF0000000001000000010000000000000000000000000000000000000000000000000000000000000000000000FDFFFFFF00000000FFFFFF1F000000000000000000000000000000000100000000000000FFFFFF0FFFFFFF1F0000000000000000FEFFFFFFFFFFFF1F000000000000000005000000FFFFFF3F05000000000000000000000000000000000000000000000000000000FEFFFFFF050000000000000000000000FFFFFF1F0000000000000000FFFFFF0FFFFFFF7FFFFFFF7F0000000000000000000000000000000000000000000000000000000000000000"> : tensor<20x20xi32>
    return %0 : tensor<20x20xi32>
  }
}
