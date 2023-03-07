// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<32> : tensor<1xi32>
    %1:2 = call @inputs() : () -> (tensor<1x50x3xui16>, tensor<1x3xui16>)
    %2 = call @expected() : () -> tensor<1x50x3xui16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui16>, %arg1: tensor<ui16>):
      %5 = stablehlo.minimum %arg0, %arg1 : tensor<ui16>
      stablehlo.return %5 : tensor<ui16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1]>, unique_indices = true} : (tensor<1x50x3xui16>, tensor<1xi32>, tensor<1x3xui16>) -> tensor<1x50x3xui16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<1x50x3xui16>, tensor<1x50x3xui16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x50x3xui16>, tensor<1x3xui16>) {
    %0 = stablehlo.constant dense<"0x000002000100040000000000050004000100050005000200000002000000000001000000010000000300000005000100010005000500020000000000010000000300040001000000070001000400000006000400000002000000010002000100000000000500010000000300020004000100010001000100040005000000040002000600010005000100040000000100040002000100000004000300020002000000010001000000010004000200070002000200010005000500000001000100010003000200040002000200010002000000040004000300020003000000010000000000000001000000000000000300020002000100040003000200010003000100020001000000070001000200000006000000000005000000050001000200000000000100010000000300"> : tensor<1x50x3xui16>
    %1 = stablehlo.constant dense<[[1, 0, 4]]> : tensor<1x3xui16>
    return %0, %1 : tensor<1x50x3xui16>, tensor<1x3xui16>
  }
  func.func private @expected() -> tensor<1x50x3xui16> {
    %0 = stablehlo.constant dense<"0x000002000100040000000000050004000100050005000200000002000000000001000000010000000300000005000100010005000500020000000000010000000300040001000000070001000400000006000400000002000000010002000100000000000500010000000300020004000100010001000100040005000000040002000600010005000100040000000100040002000100000004000300020002000000010001000000010004000200070002000200010005000500000001000100010000000200040002000200010002000000040004000300020003000000010000000000000001000000000000000300020002000100040003000200010003000100020001000000070001000200000006000000000005000000050001000200000000000100010000000300"> : tensor<1x50x3xui16>
    return %0 : tensor<1x50x3xui16>
  }
}

