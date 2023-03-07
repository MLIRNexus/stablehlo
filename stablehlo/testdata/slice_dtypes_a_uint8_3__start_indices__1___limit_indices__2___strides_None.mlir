// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<3xui8>
    %1 = call @expected() : () -> tensor<1xui8>
    %2 = "stablehlo.slice"(%0) {limit_indices = dense<2> : tensor<1xi64>, start_indices = dense<1> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<3xui8>) -> tensor<1xui8>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<1xui8>, tensor<1xui8>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<3xui8> {
    %0 = stablehlo.constant dense<[3, 0, 0]> : tensor<3xui8>
    return %0 : tensor<3xui8>
  }
  func.func private @expected() -> tensor<1xui8> {
    %0 = stablehlo.constant dense<0> : tensor<1xui8>
    return %0 : tensor<1xui8>
  }
}
