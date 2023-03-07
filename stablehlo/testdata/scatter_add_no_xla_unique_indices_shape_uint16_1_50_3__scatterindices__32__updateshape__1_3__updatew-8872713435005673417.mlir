// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<32> : tensor<1xi32>
    %1:2 = call @inputs() : () -> (tensor<1x50x3xui16>, tensor<1x3xui16>)
    %2 = call @expected() : () -> tensor<1x50x3xui16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui16>, %arg1: tensor<ui16>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<ui16>
      stablehlo.return %5 : tensor<ui16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 1], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1]>, unique_indices = true} : (tensor<1x50x3xui16>, tensor<1xi32>, tensor<1x3xui16>) -> tensor<1x50x3xui16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<1x50x3xui16>, tensor<1x50x3xui16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x50x3xui16>, tensor<1x3xui16>) {
    %0 = stablehlo.constant dense<"0x010002000200000004000300060004000400010000000500010001000000050005000000020004000200000000000700050001000000020001000000020001000300000000000000000001000400020000000100010003000200040002000600000003000000010004000200060001000400000001000100010001000000000003000500030000000000040004000300030004000100040000000000030002000100000003000100000000000100000001000300000001000000030002000200010001000000030000000400000007000000000003000100040005000300010004000400000003000300000004000300040001000100000003000400010000000400000000000000010000000200000002000000020003000000020001000400030004000400030003000200"> : tensor<1x50x3xui16>
    %1 = stablehlo.constant dense<[[0, 1, 3]]> : tensor<1x3xui16>
    return %0, %1 : tensor<1x50x3xui16>, tensor<1x3xui16>
  }
  func.func private @expected() -> tensor<1x50x3xui16> {
    %0 = stablehlo.constant dense<"0x010002000200000004000300060004000400010000000500010001000000050005000000020004000200000000000700050001000000020001000000020001000300000000000000000001000400020000000100010003000200040002000600000003000000010004000200060001000400000001000100010001000000000003000500030000000000040004000300030004000100040000000000030002000100000003000100000000000100000001000300000001000000030002000200010002000300030000000400000007000000000003000100040005000300010004000400000003000300000004000300040001000100000003000400010000000400000000000000010000000200000002000000020003000000020001000400030004000400030003000200"> : tensor<1x50x3xui16>
    return %0 : tensor<1x50x3xui16>
  }
}

