// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<1x20xi32>, tensor<20x20xi32>)
    %1 = call @expected() : () -> tensor<20x20xi32>
    %2 = stablehlo.broadcast_in_dim %0#0, dims = [0, 1] : (tensor<1x20xi32>) -> tensor<20x20xi32>
    %3 = stablehlo.shift_left %2, %0#1 : tensor<20x20xi32>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<20x20xi32>, tensor<20x20xi32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x20xi32>, tensor<20x20xi32>) {
    %0 = stablehlo.constant dense<[[2, 0, -1, -1, 4, 0, -3, 6, 0, -2, 0, 1, -1, -3, 9, 4, 2, 1, 2, -2]]> : tensor<1x20xi32>
    %1 = stablehlo.constant dense<"0xFEFFFFFF0000000000000000FEFFFFFF02000000FEFFFFFF00000000FEFFFFFF000000000000000002000000FFFFFFFF070000000000000000000000000000000100000000000000FDFFFFFF040000000200000001000000FEFFFFFFFFFFFFFFFBFFFFFFFAFFFFFF0100000002000000FEFFFFFFFAFFFFFF01000000FBFFFFFF03000000FFFFFFFFF9FFFFFFFEFFFFFFFFFFFFFFFEFFFFFF00000000FDFFFFFF010000000300000002000000000000000200000003000000FEFFFFFFFEFFFFFFFEFFFFFF00000000010000000000000000000000FFFFFFFF00000000FFFFFFFF00000000FEFFFFFFFCFFFFFFFEFFFFFF01000000030000000000000000000000000000000000000000000000020000000000000000000000FEFFFFFFFCFFFFFF01000000020000000400000002000000010000000200000000000000FEFFFFFFFFFFFFFFFDFFFFFFFEFFFFFF040000000400000001000000FBFFFFFFFFFFFFFF01000000FCFFFFFF0000000000000000FFFFFFFF030000000200000003000000FEFFFFFF0000000003000000FFFFFFFFFCFFFFFF000000000400000005000000FDFFFFFF0000000003000000FEFFFFFF02000000FFFFFFFFFDFFFFFFFCFFFFFF0100000001000000FEFFFFFF0100000004000000FEFFFFFFFEFFFFFF00000000FEFFFFFF00000000FAFFFFFFFEFFFFFF00000000FFFFFFFF02000000FCFFFFFF03000000FFFFFFFF01000000FEFFFFFF00000000F9FFFFFF000000000000000000000000FBFFFFFF00000000FFFFFFFF01000000FDFFFFFF02000000FDFFFFFFFFFFFFFF01000000FEFFFFFFFCFFFFFFFCFFFFFF0000000001000000FFFFFFFF0600000002000000FEFFFFFFFAFFFFFF01000000FCFFFFFF0200000007000000F7FFFFFF00000000FEFFFFFFFFFFFFFF00000000FFFFFFFFFEFFFFFF01000000FEFFFFFF0300000000000000FDFFFFFFFEFFFFFF0100000001000000FEFFFFFF0000000000000000FFFFFFFF02000000FDFFFFFF0100000001000000FDFFFFFFFCFFFFFFFBFFFFFF01000000FEFFFFFF000000000000000001000000FDFFFFFF03000000010000000000000001000000FDFFFFFF03000000FFFFFFFFF9FFFFFF0000000000000000FEFFFFFF0200000000000000FEFFFFFFFEFFFFFF000000000000000001000000FCFFFFFFFDFFFFFF01000000FAFFFFFFFEFFFFFFFDFFFFFF02000000FEFFFFFFFFFFFFFF0200000001000000FFFFFFFF0300000005000000000000000000000005000000060000000100000001000000010000000100000003000000020000000300000000000000000000000200000000000000FEFFFFFF01000000040000000300000002000000FFFFFFFF01000000F9FFFFFF0000000000000000FEFFFFFF010000000200000000000000FEFFFFFFFEFFFFFF03000000FCFFFFFF0000000001000000FDFFFFFF010000000200000002000000FFFFFFFFFFFFFFFF00000000020000000100000000000000FEFFFFFFFFFFFFFF000000000300000001000000FEFFFFFFFEFFFFFFFEFFFFFF000000000100000005000000FCFFFFFFFDFFFFFFFEFFFFFF0000000004000000FDFFFFFF0300000005000000FFFFFFFF000000000200000005000000030000000400000003000000030000000300000003000000040000000200000001000000FDFFFFFFFEFFFFFF0000000000000000FEFFFFFF00000000010000000200000003000000F8FFFFFF01000000FFFFFFFF03000000020000000200000003000000030000000000000003000000FEFFFFFF0200000001000000FFFFFFFF0500000000000000000000000000000000000000FEFFFFFF01000000FDFFFFFFFAFFFFFF0000000000000000FEFFFFFFFDFFFFFF00000000FEFFFFFF00000000000000000000000002000000FEFFFFFF02000000FBFFFFFFFEFFFFFF00000000020000000100000003000000050000000000000003000000FBFFFFFFFFFFFFFF00000000000000000300000002000000000000000200000000000000FEFFFFFFFEFFFFFF00000000FFFFFFFFFEFFFFFF060000000200000001000000FDFFFFFF040000000A00000005000000000000000800000002000000FEFFFFFFFCFFFFFF0000000002000000000000000000000002000000000000000300000000000000020000000000000003000000010000000200000001000000FFFFFFFF0000000000000000010000000000000000000000"> : tensor<20x20xi32>
    return %0, %1 : tensor<1x20xi32>, tensor<20x20xi32>
  }
  func.func private @expected() -> tensor<20x20xi32> {
    %0 = stablehlo.constant dense<"0x0000000000000000FFFFFFFF000000001000000000000000FDFFFFFF0000000000000000FEFFFFFF000000000000000080FFFFFFFDFFFFFF0900000004000000040000000100000000000000E0FFFFFF080000000000000000000000000000000000000000000000FAFFFFFF1800000000000000000000000000000000000000F8FFFFFF000000000000000000000000000000000000000002000000000000000400000000000000FCFFFFFFFFFFFFFF1000000000000000000000000000000000000000FEFFFFFF0000000001000000FFFFFFFF000000000900000000000000020000000000000000000000000000000400000000000000FFFFFFFFFFFFFFFF0400000000000000FDFFFFFF1800000000000000FEFFFFFF0000000000000000FEFFFFFFF4FFFFFF900000001000000004000000040000000200000000000000000000000000000000000000F0FFFFFF400000000000000000000000000000000000000000000000000000000100000000000000E8FFFFFF2400000020000000000000000100000010000000000000000000000000000000F0FFFFFFE0FFFFFF0000000000000000E8FFFFFF0000000000000000000000000000000000000000FEFFFFFFFAFFFFFF0000000008000000200000000000000000000000FEFFFFFF000000000000000000000000000000000400000000000000F4FFFFFF0000000000000000000000000000000000000000FFFFFFFF000000000900000004000000020000000000000002000000000000000400000000000000FCFFFFFF000000000000000000000000000000000000000000000000FEFFFFFF0000000000000000C0FFFFFFF4FFFFFF000000000000000004000000000000000800000000FFFFFF000000000000000000000000000000000400000000000000000000000C00000000000000F0FFFFFF000000000000000000000000FAFFFFFF1200000000000000020000000100000000000000F8FFFFFF0000000000000000FEFFFFFF000000000000000000000000FAFFFFFF0000000000000000FEFFFFFF0000000000000000F8FFFFFFFAFFFFFF090000000800000000000000080000000000000000000000020000000000000000000000FCFFFFFF0400000000000000000000000600000000000000FCFFFFFF0000000000000000FEFFFFFF000000000000000000000000080000000000000000000000F8FFFFFF0400000000000000F8FFFFFFE0FFFFFF0400000000000000A0FFFFFF8001000000000000FCFFFFFF0000000002000000F8FFFFFFF4FFFFFF4800000004000000020000000400000002000000000000000400000000000000F8FFFFFFFCFFFFFF0000000000000000000000000600000000000000000000000000000004000000FFFFFFFF000000000000000020000000000000000100000004000000000000000400000000000000FCFFFFFF000000000000000000000000F4FFFFFF0C00000000000000000000000000000001000000F8FFFFFFFAFFFFFF0000000000000000000000000100000004000000C0FFFFFF000000000000000000000000FFFFFFFF4000000000000000E8FFFFFFC000000000000000FEFFFFFF0000000020000000F8FFFFFFD0FFFFFF4800000020000000100000000800000020000000F8FFFFFF040000000000000000000000FFFFFFFF0400000000000000FDFFFFFF0C00000000000000F0FFFFFF000000000200000000000000E8FFFFFF2400000010000000100000000800000002000000F0FFFFFF0000000000000000FEFFFFFF000000008000000000000000FDFFFFFF060000000000000000000000000000000000000000000000FDFFFFFF0900000000000000000000000100000000000000FEFFFFFF0200000000000000FCFFFFFF000000001000000000000000000000000600000000000000FCFFFFFF0000000020000000FFFFFFFFE8FFFFFF0000000000000000020000000100000010000000F8FFFFFF0200000000000000FFFFFFFF000000000000000000000000000000000000000000000000F8FFFFFF0000000000000000F0FFFFFF00F4FFFF2001000004000000000200000400000000000000000000000200000000000000FFFFFFFFFFFFFFFF1000000000000000E8FFFFFF0600000000000000FEFFFFFF0000000002000000FCFFFFFFFAFFFFFF0000000004000000020000000200000002000000FEFFFFFF"> : tensor<20x20xi32>
    return %0 : tensor<20x20xi32>
  }
}
