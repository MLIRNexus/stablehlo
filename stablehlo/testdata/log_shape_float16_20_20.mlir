// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf16>
    %1 = call @expected() : () -> tensor<20x20xf16>
    %2 = stablehlo.log %0 : tensor<20x20xf16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xf16>, tensor<20x20xf16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x4E3E1945DBBA02B6CCABFCC57444644482C7F9C0DCC26EB3DD3F92C3C8C39BC3E344D7BDA6C241C1B0AFD6407A3270BC2D3CF6C03DC583BA1BB00044CDBF2CC1993CEDC1ED432AC429C585446DC4664581425AB97D3B463F5DB58BB88B42FA3FA6BADEBD883E0CC1743D6A47D4345E3CC74203383BBA17B67D3D3EC0E43A4DB0B43C8D409CBC814467BC2BC120C22F401B3D173A6A328E3C1C45ED43D6BCEC43DCC10C321D3DFB4311441A3BC2C082448F41E13AF63CC140E0B7953F7D42F8BFF340C4BA603F5D41C0BF8E451BBA2D3E6CBC9A3C0C3CE5C4D734734153380C378D4573C2BBBA1A453E3D3EBD993C9D41082F82368A3FD23EBEC557BB7FBA2648C7C16646283CACC402C14DC672C49042B13CC9BF7543733C5F3E224214BFC4BE33443EB807C3BF3E11BE34C44A3F1444FCB8573C0F43E346A0BE7CC4A1346F3E5345684599B9ECC477431EBA56C08F45E94330BE34442D3DA8BAC4C6EFBB1341FCBFF2358BC0BDB826434140D9B3A7C271BDA64589B73E41DA415CADD1BC303B77BB10BDCC40E7C4CF4119C12E3492BE214767477EB59B34934140C1FCBAEF39FF38A0B45C45612DD343DE4335BF40B5634364BC1644B941943C1F3D95BD1A43534371C074B0C6C17F434A44F2C09B3EDA3DC73F8443C141BAC2ACBD633F7BBFD04533C27AC275C2DF3BFEB9B53F323A1F4453A984413641CABED5C2FDBFBB3E3E3C64C6E43E57C59144EBB7F54101BCF6C4523581B792379C412DB4774831B015BE123804C852C2B93EFEBEDB4451BF50B818C03F2DC83EDCBC97C6B63ADDB4ABC4EAC4004107B874B834B75A4186C0BABC0DBC234856C4DE4196415EC320B8313F08C47B4643303E35023D6AC17FC413C15243CA41F6BEEB3E4145ED40CE4115C4F6C1CFBA18BF42C25345A63C16C6DBBB7142913E8C44D4C30CB034BC0EBEB2410F35BA3AC140713C6F3F79408047E040A2B78AC7A23D2B3C523F5AB24BC06D2B223CBDC1A5C2E6BD5542103BE9441345D3C0DB3AF1C2ACB8C445DC3CD83C383FE6C195B4A694913C70C578345DC280B8D43DDDBC55C0D1BC633C194802C14245C8C1A9BCC7B2FB420241A2BB8E4443B4B6ADD73EF9C259C057C592BD6CBA"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
  func.func private @expected() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x4837843E00FE00FE00FE00FEF93DEB3D00FE00FE00FE00FE683900FE00FE00FE593E00FE00FE00FE00FE103B64BE00FE812900FE00FE00FE00FE8C3D00FE00FE753000FE823D00FE00FE093E00FEBF3EB83C00FE3BACC93800FE00FEBE3C863900FE00FED83700FEF5340240CBBC9F2DE23C86B900FE00FE103500FEC7B000FE2F31943A00FE053E00FE00FE00FEE739CF335DB46EBE2830863E823D00FE823D00FEAABEDC33893D9C3DA0AF00FE063E173CD5B0E432ED3A00FE1E39B53C00FE403B00FEE538E43B00FEDC3E00FEF33600FE7C30F72100FEC8BC023CECB88FBADB3E00FE00FE853E543400FE7530213C6BC032BB1239453800FE00FE00FE3B4000FE6D3FE82800FE00FE00FE00FEC13C1A3100FE443DD02E73377B3C00FE00FEBD3D00FE00FE2E3800FE00FECD389F3D00FE382D0B3DB83F00FE00FEF6BC9B37B03EC03E00FE00FE453D00FE00FEDD3E803D00FEBE3D203400FE00FE00FE733B00FEEBBB00FE00FE183D0A3A00FE00FE00FEED3E00FEB53B4B3C00FE00FEDBAE00FE00FE003B00FE443C00FE5FBD00FEDB3F014000FEFBBC1A3C00FE00FEC8B488B700FEB73EF4C0753D7A3D00FE00FE3A3D00FEA13D353C5230E83300FE123D313D00FE00FE00FE493DD33D00FE0338163652394C3D3A3C00FE00FEE83800FE0A3F00FE00FE00FE29A400FE3F3917B4AA3D00FE0F3CA93B00FE00FE00FE2A38862B00FE5A3800FE133E00FE5E3C00FE00FE67BC00FEFDB9203C00FE614000FE00FE68B900FE00FE273800FE523E00FE00FE00FE01C1393800FE00FE9FB100FE00FE00FE553B00FE00FE00FEE03B00FE00FE00FE3A4000FE4E3C1C3C00FE00FEB13800FE7A3F08C077BC313300FE00FE00FE313D403C00FE6238A33E363B433C00FE00FE00FE00FE00FEB03ECF3000FE00FEAE3CEE370F3E00FE00FE00FE00FE303C9BBC8CB1ED3AB32EF538703A0840213B00FE00FE7A354429D63800FE00FEB2C12E2800FE00FE00FE9C3CFAAF5D3E7F3E00FEF1B000FE00FE023F3A322032B93800FE00FE00FE3D3000FE1ABD00FE00FE063600FE00FE00FEE82D354000FEA43E00FE00FE00FE003D583B00FE113E00FE00FE4B3800FE00FE00FE00FE00FE"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
}
