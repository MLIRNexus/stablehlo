// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0], [1]], [[2], [3]]]> : tensor<2x2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xui8>, tensor<5x2x2x7xui8>)
    %2 = call @expected() : () -> tensor<5x6x7xui8>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<ui8>, %arg1: tensor<ui8>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<ui8>
      stablehlo.return %5 : tensor<ui8>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 3], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xui8>, tensor<2x2x1xi32>, tensor<5x2x2x7xui8>) -> tensor<5x6x7xui8>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xui8>, tensor<5x6x7xui8>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xui8>, tensor<5x2x2x7xui8>) {
    %0 = stablehlo.constant dense<"0x010502050001020203050007030104030001030305000805020001070101010101040101000103030002030507000203020000000005020303020400070206010000000100000003030301030302020401010001050302020204010004020101030102020103040101020100020203000601050101000003040503000002020002010405020202000400030302000007010301000000010002040105030602020100040004030101010205010001010404030201010200000204000004010004000102040402030403040000020100040603"> : tensor<5x6x7xui8>
    %1 = stablehlo.constant dense<"0x0000020300010100020200050100040102000100000100040204040000040203050007000101030401010002050204050001010301000303040000020004030202040500000502000002000400000104000003050302000400050103010004000202020200020103010007060202020100040000000000020001020102010203000201000000050302000202"> : tensor<5x2x2x7xui8>
    return %0, %1 : tensor<5x6x7xui8>, tensor<5x2x2x7xui8>
  }
  func.func private @expected() -> tensor<5x6x7xui8> {
    %0 = stablehlo.constant dense<"0x01050408000203020507000C0401080402010403050108090404050701010101010401010001030300020309090307030900010103090304030409020B070602010301010303000303030103030202040101000109030204020804020606060103060402010504050102020402020605060105010100000304050300000205020205040A030503000800050504020009020602000706030204050105030602020100040004030101010605010001010604040402030302030206010004010507020104060402030403040000020100040603"> : tensor<5x6x7xui8>
    return %0 : tensor<5x6x7xui8>
  }
}

