// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<2xui8>, tensor<2xui8>)
    %1 = call @expected() : () -> tensor<2xui8>
    %2 = stablehlo.divide %0#0, %0#1 : tensor<2xui8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<2xui8>, tensor<2xui8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<2xui8>, tensor<2xui8>) {
    %0 = stablehlo.constant dense<[5, 0]> : tensor<2xui8>
    %1 = stablehlo.constant dense<2> : tensor<2xui8>
    return %0, %1 : tensor<2xui8>, tensor<2xui8>
  }
  func.func private @expected() -> tensor<2xui8> {
    %0 = stablehlo.constant dense<[2, 0]> : tensor<2xui8>
    return %0 : tensor<2xui8>
  }
}
