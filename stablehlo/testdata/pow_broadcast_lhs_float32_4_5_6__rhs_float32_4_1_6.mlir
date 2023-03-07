// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<4x5x6xf32>, tensor<4x1x6xf32>)
    %1 = call @expected() : () -> tensor<4x5x6xf32>
    %2 = stablehlo.broadcast_in_dim %0#1, dims = [0, 1, 2] : (tensor<4x1x6xf32>) -> tensor<4x5x6xf32>
    %3 = stablehlo.power %0#0, %2 : tensor<4x5x6xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<4x5x6xf32>, tensor<4x5x6xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<4x5x6xf32>, tensor<4x1x6xf32>) {
    %0 = stablehlo.constant dense<"0x395F47C03A940DC00BB006BFD7AA83C0702A933FC6F90FC0063F31401ECCEC3E6EFFC5BF84D57840317A9D3F3325DBBFC45EC33E3623D0C073711CBF9A8F143E325D50C0B16C4D405EF5CD403C4683BF5FEF023F87D18FBFFC2733C02C5D013E0A9DD93FCDDF57C0A89AE23F03037B3F6AFA28BF45D1B9BFA95096C019F5C13FBB77ACBFA9C24BC008091640DC5100C0FCB834BE5F2F85C0DA3C9A4089211D404E7798BF914E00C0318EE0BE4367DAC07F861D3FE529FABFB426354015298BBE04A6583E2EB788BF006216BFC295C0BFCD4E243F861054BF19025ABFA58B0BC02AD7C740E43742404ED4EEBE80E4C0BD0B6343C03CDAD53E3EABC2BF91138FBF90F7A23EAD1E8FC0AD8F1A400ABF084074BAF23FC84A5A40C3B00FBF80F662BEB973BDBFFB398BC015B71D4007A7ABC06340A23F6D421DC060369ABF09CFD03E5A0436C0AC26183FD23D0240AEEB13BF88752A40C9E1A5BEB6A1CDBFFA072E409586983F47F14D40BBC2D9BFF23A873FDF7EFABF681B703E3FCC7EC0AB2129C086ED6840DDDF0B3F254724C08D4EDD3E282A93BFADC5563E5CDDEE3ECE59873EDF2087C0EE5504C0AACF3840B0004240F227C3BC6924D7BD8730184000130F41C7DC30C09CC3A03F742D9940AD32B43F2BF48E3F12EE04BFEBD376403136413F"> : tensor<4x5x6xf32>
    %1 = stablehlo.constant dense<[[[1.64268851, 3.04523325, 0.224084094, 0.399428636, 2.89719391, 3.90988421]], [[-4.47687674, 1.48246312, -2.13088346, 0.227733329, 0.23193197, -6.052650e-01]], [[-1.70759535, -3.4984448, -1.17683494, -3.50630856, 2.35138059, -2.00173688]], [[1.86934507, -4.6151185, 4.03832674, 9.103520e+00, -1.57059622, -5.53881693]]]> : tensor<4x1x6xf32>
    return %0, %1 : tensor<4x5x6xf32>, tensor<4x1x6xf32>
  }
  func.func private @expected() -> tensor<4x5x6xf32> {
    %0 = stablehlo.constant dense<"0x0000C0FF0000C0FF0000C0FF0000C0FF00C4BF3F0000C0FFAB8EAA40FAA8C33D0000C0FF672CDC3FDE55E93F0000C0FF3C5E523E0000C0FF0000C0FF14CEEC3E0000C0FF9C1BBF421561AA410000C0FFA7495C3F0000C0FF0000C0FFB8E9A039F90719400000C0FF3D7A913FEBFE7D3F0000C0FF0000C0FF0000C0FFB705ED3F0000C0FF0000C0FF1CF79B3F0000C0FF0000C0FF0000C0FF63820F3D6B0D9D3F0000C0FF0000C0FF0000C0FF0000C0FF991E34400000C0FF0AEFA23F0000C0FFAAD882440000C0FF0000C0FF0000C0FFD8FA663F0000C0FF0000C0FF0000C0FFC745A53C34D1A43F0000C0FF0000C0FF0000C0FF88A5A9410000C0FF0000C0FFF6C48A3D0000C0FFA335633EA2CD8F3D271CF13E09D95D3C0000C0FF0000C0FF0000C0FF0000C0FF4B23B13E0000C0FFD989DF3F0000C0FF0000C0FF9A6BB8410000C0FF055CC640921AAA400000C0FFC53A403E0000C0FF0000C0FFCA84F53C584CC13FD362C53D0000C0FF5AA8463F0000C0FFF97BF7350000C0FF0000C0FFF4043341B82F82410000C0FF4A27FD390000C0FFEFA0B245BA38763E1A13E8430000C0FF0000C0FF5CA0413ED5DF0C3B0000C0FF0000C0FF6838044297B1DA4D0000C0FF38E4903E80649541C63C533E80FBC73F0000C0FFF2D2F53DB1109840"> : tensor<4x5x6xf32>
    return %0 : tensor<4x5x6xf32>
  }
}
