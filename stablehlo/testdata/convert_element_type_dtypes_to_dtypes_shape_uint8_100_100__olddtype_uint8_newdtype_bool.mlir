// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<100x100xui8>
    %1 = call @expected() : () -> tensor<100x100xi1>
    %2 = stablehlo.constant dense<0> : tensor<ui8>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<ui8>) -> tensor<100x100xui8>
    %4 = stablehlo.compare  NE, %0, %3,  UNSIGNED : (tensor<100x100xui8>, tensor<100x100xui8>) -> tensor<100x100xi1>
    %5 = stablehlo.custom_call @check.eq(%4, %1) : (tensor<100x100xi1>, tensor<100x100xi1>) -> tensor<i1>
    return %5 : tensor<i1>
  }
  func.func private @inputs() -> tensor<100x100xui8> {
    %0 = stablehlo.constant dense<"0x0002030003010400000401000203020004020201030000000005000303010200020302000402040000000503000204000100000104010100010001000002070003030302010003010001050102040400010502000200000201020000000100010500020502020501020206010002000100020400030200000203030006000502000303010102010004010401050102000000040001010105040000000400040000020302050102030300010201030500010001040001000003000200000201000002000300030005000100000301020201060B010200040603000001040401030001020000060201000203070006000402020001020001000106000103000200040005040102000101020101020400020103010101040101030102010003020300020202010103040701020600000200010200020300000200050201020300030605030200010100010000020301000102030201000401020100010302010304000501010102000101010102080200030308020300020502010000040000030605030000020303000203010002030001000101000202060200030103000304010003020002030400000302050106050201000300000501000301010104050002030001000402000602010004010301030000030102010401050102000201020305060300030201020504040303040200000101040101010100000101040003020201020000020100090203030002010201010002050200010200020202000100060002010203000300060003010200020300000002030501080400050304020004010401020103050301010002040504050001040200040103040000040501040500010006060200000000000203050104020002010303010300050200010100000401000000000200000101040202000201010005040301050004030404010200010405000100030405030201040501010101010405010300000603050201020001010201000002020200030402020406020000030400020200060102020003000102000403000101060101050702000104030202000101000002000001010500020500010200030401010001000002000100020305010004010403030505020201010000060001000000000003000201000403020200000100050403010100020004020000040005040100010401020201010100060001020001030201010101010000030400020100030205020302010002030202000601040106050301010203020503010000010000060001010506050201040300010100010300030100050202040401020303000903060001030302000101000202030301010200020700020401000201000101030302000202010001000000040202010101010500020001010202020403010201040301040401040100010001000302060301000000000402050402000002010003050302040101020102020103010001040002020102000402010500010202000003020402000001030001010401030303020200020000000103010200020202030101010000030105000000010202000202010201010403020003010300040101020401010201020003050203000302030506030102020001040300010001010504010002010101050101030001010403020001010101000203010000030101000102010102010001010200020001010102000105010200000102000604030100030300020205010205000302010002030300050004010103050005010002010101020601020102070301010004010203010204030002030302000003000101080102070403020103010100020403030003010600010205000002020302000008010400000204010001030503000500040103040301000401010204010500030202010204000500020000010100000202010503020002040101030105050001060301010000020004000202080104050000010000000200000000020202000500000102000004010700020501030400000802010101030006030200010401020004000101030203040002020301010200030004060306030200050000010400000205020104000200020005000200010201010602000404020502010203010002000100010101040001000500040303010005010103020301010202000202000301000403020200030204010005020101040501030003030204010103010107000100070102000200040202000304000201030101000300010305060300010601000503030201010204000001020303010502030402020001000407050001020603050000020002020202030502010202000000040101000102020202010003000005030702000101000006000302000200030101010103020203000000030101060101000402010202000400000001020604010004000200020301040101000203010101010000010104040100020101030205020104040001040400010201020205040200000103040003000202000401010003030001040305020102000101020300030501010302020007000301000202000000020001020303010104030601000103000201020204000103000200030003010001000003050703040104010002040004030000010101020700000103030201000400010101010102000005050200060401040200000201020000050105030201010602040000060A02060300020304030000000300030302000200010001000004030101000102020000010100050201060001020302050001020001050102010102010403010000080001010003000004010102000300010001010301010501020203010205020200060104020100020002030001010002060304030700010203010001030404020802020301010201000300030400010202030003000202030101050104020000040005030202000302040101030202000300040000010101010000040304000003000101010002050303010104000002040200030101050104000103000302050201050203000207000000000103000201010601010401000002000002030201040401020000030401060000010300010004020002010502010403030000060203050003010002020001020206020004000204040100000503010701010101000002050101000503010404000004000300000001030200050300010802030000030202020001080000000203010000030701000805000200030100000305030003010001000102000002020001010003010003020205020202060500010501030602000301070000000000040106020101020300040404000004010702020002010400010305000302060404010000000403000206030001040500010102050204000200020001020203020202020001010100020005020502000101030001020101010300000000010401030103020207010404010207020002010000020203010301020102030301050103020504030005030003000202000300010101010003040000070701050200010401030704000304040405060101010003010101020300070106020003050201010301010000020200010503040100020300000004010200010001020301010103000501040200030402000108040300000303000101030102040201000000020006030300010003040305030701020501010500010601000300010300030200010100020202020102040104010304030100010302030001020102040003030003040204010105010501020003000102020101010000010203000004010302000002030103060307040302060100000800030002000301020100000303010201000000020500070300050203050400020203010203000704000000030000010300010004030201010504010300020102010006010200030104010603000002010001010005030202010205020001000204010204030403000304040003010002000001020201000102010102030408030602020000040200010001010103030104010202010107040300020A0201000200060101020002030400010402010202000001030101000101010204020404000201030101040100000101010205010202010303020000010201000001020205000203050200020002000303030202030204010200050000030701000400030002020300030300010601010301030603070203010204050301020003000301000006030301010601010100020100000100030304020105040301050104010100000101000103000000000400000004020000000001030100040102050101010304000103010502010302000104010101010100000101020402020104010100040003020101030205000000000501020201030103040002000000010500010100040601020004010302030702060204030102020102010202000205030000000003010201000005020500010100000501000002010004010300030306010104030000000101010101010004000301020300010101010102040404000200000601000100030201000001030001020003000503060002030201000004000208000001070104020106000503000108000001020102000306010004050501020001030100020007020303010101040300040101030100000100020104000001000502010103010303020200020502000300050100020102000103000402010100000300010406020102030001030107020003010101040003030000000200010001000201030201000102000101020401000100030102000204000402000001050000040302010202010301020101030101000606010001030100000500000001020402000101020101000302000102000405060002050003000001000204030000000201050001040202020100010000050001040102040300000102040002000102010404010404010304000203010002040005010402000401020401000202000000040107010005020303030000020000030204040103030101020201010001030501010000030402000300030001020001010102020301010005000401040002030001010101010201010604010407010101020101010508010107000003000700060004030602020303070002010005040100000101050001040900010105020101020005020100000004010003010000060402030000030306000101040301000500020202020401010305010200020300010300000104020201030302020401000102000201010303010101000000030206020200020601000801000100000601020106020300000607040105040000000303000201020101020400020301000407000100010203030102000100030006000100050102030100040004020000020002020200000205020000020000000206010500000103020400000000030000010201000102010000000102000501020104000205000201010103030204050700040603010004010101000002040407030706000200020100010502030001010002010301000300000005010106000003000204060302010402020100030402030505010005000000050201030202010301020201030000020100030304000100020201000202020701020104030200050201000002010403010004010306000105000000030006000001030301010304000702030302070001020400020300030006050703020303000401040103010100040103040005010103010301010200040105030002010007010103020500010104010004020302010003020002020204020001050400000305000503020003020001000101000503040201000204000002060203000301050300060104030200020205000100010000000000090303030200010100020000000302030401000404020100020101010000020102020301020204000200010502000001020405020001030103020300060202010002010003010300030200020202020202010100050103000000030000030205010002000200010102010202030100030004000400040100010103010102010102010500030304000003050300000203020102020405000302000100010401030005010103000B080506020504030502030201010000000205010102010203020201000402000001010301000102000302050200030001050301010200010101000100010405000306030007040100030A0300000604000000010304000300000400010102020507050002020001000002020600020001030401030500050103030303000001050201000203040202050400010304010801010203050205000001020500020301050401030304030100000204030000030201000001040001000002000201000404010600010001000006010204000400040002010104000005000301040002000201050108010100020400000000020104010100010201050100010403010200010303030204000502010206040500040103060304060008000402040007000202000300020002010303020102010302020401040602020303000103000602010208000000060204000002000100010106030304000301000201020206020002030200020605010104000505010203010101040005020102000002040303030100030901000700030203000200000000000102000200030206040101020200010207040004000303030200010100000300090302030200000102030102010400000103010100000102010602040005020204020501030300000003000203000205030103060201020103070000020204030300010001020106000101010001000105010103020001000202000001030000000007000004000100000000000102000003090100010102020400050400030000010001040100000206000100000200000100000202040100000200010504010100020000080002000000000502030301040000030004030406010504000401040102030A000202040805050103000102040003020006000000020101000000000103030300010903030203010503000607030001000100030002000001010202010000010302020500040402050000020202020102000703030105010600040102030304000100040104000003050104050500000102000201010100010003020200040000000303030204010402020001000001020102000003030005000000030302040202040501020201020602000105010101030203020000000206040100000300010202020403000404020402020109010003000000040203040800020101020303040200050201060102010009000002000303040001000102090002000008030100050600070204020102030301030100090000000000010305010202040003000503010106010200000204020601020002020502010301000300010304010001010604070001050105000204010102000500000300000201010302020003070005000202010104000104000403020101020203000106000000000504000401030200000006010101030303040201030001010305030105020103000400000502060400010000040002000604000502020003010103010700050402010101010004010000000201040101010204030000000100010305020300000000010002010002020302020501000200010103020105010103000600000200030001000002050202000004040201040403000200060300040100000203000000030000020400040302020107050405020206010304030001010100050000060203000001000104000101010003000202010100010200020304020101030400000002000205030202000200000303010204020502020003020100000202000305030200020005080100030101060104020003030103040102010201020403040400020105020006010002040100020003000004000204020903030001010101020201000100030000010502000100000102020701010204020602010301080001000003000004010001030105010002010301050303020301020102010003000000040001020101000304000105000300020202010100040100050001000004010106020003010000010100020103020300000001010201010302070401010004010506030001060303020101030304020504060501040301030101000201020101000004000406020003030203000003010000000402020103030103010000020203010200010C04020000010400060600000404000801000104020702020002020105010005000101030202010002000102000302050000050104030300020006020A040204010103000203030406010400020203000001040400030103010000050204000200010003030701000301000000030301000106000202010504080100060301000100030000010201010302060005020001010001000103040000000700000000050001000204010100030005020203060102030100000002030000020104020103020202000106020502030700000100000601010300010300000401010100000300000604020001010100040001040202000005020000010005000200010407040101030001050203020300020002000503010003010400010204040100010101010503020102000201020100000003010801090201030200040101020105030200000301050200040005020001010602000002010300010002010000010003030002030001060402030201000100040102000000000104020000020204020201050302010002000104000000000000010002020201030401000100020202010102000600000004020005030207060300010101000201040001000101020302000101020202000201050406010005030004030300030003000000010200030000020503040401040002030004070503010102010305050102000102010101030302020201020500020800020006010403000401050204000003010100020002000100000402000100000000030002010304030001030302050105030402010100060201010302020003010202000202030403000000010201070602000100000600010101010200010000010307030102000004000206010001050201020301010304020703050100000301040204050204000200020004010006000002010005050202010101000202020101030102020001020001000201020103010202000002010001000100020301030100000201030101010401010103050101000001000101000000030002000201020201010301020503020204000200010200000103020104010003000208020004050002040100060101060303020003070006000103030103050001040201020001020103030207000601010707040200020001080200020406020003050100030001010505020003030302030403000100010000030404030200060600040201030401030406030101020300000703010402030002000109040001040104010403030102040205020103000100000002030301000405050003020002060203000104020001050103000102030302030304030400000802000601040105000600020201000300060202020300020501020502000100020200060500030402010400050003020007000302030700040401010104050104010203050208020804020102010600020303010101030100020101030302010001020202000302030903000500000202000305000301010200000104010000010102050001040102000002000002000403010100070102030301020001020004000400000100000103020100000104020002020100000100000002020505010000010003010200000002030002040100020502030001000200040001030108030100030007040000060100010101020C02010702000301000101000000020000020500010105000102000100000001010001010003010002020203000302000001010200020407020202020104010002010600060002010104000300010300020002010000000201040204030400000200030601000303010101020004040200000001020000010202020505030201050205030301040100020200040107010301010200000104000303000200000102010004000101010203000005040003060201040000040105010203000301010301020100040102010001020002020101060107020304030102010002000101020100030000020000070300040003030101000003050100030100020301030201030100000303030001020603040101040301020100020204030501010400000001020103050000040101030106000006010000050200030600040200020300020100020002020302030101070002030001010200010202040200050502000402020101010302010201030502000204000100010000020601000503000606000201010202000000040100020100000104060003000100030200000101050101040302040205010301010003010103040001000201020002010000010200010105010300010301000004000602000005010001020204040000000105010101000105010103060203000103010103000003050100020102020007010200000002020202020601010003030100010200010102030400010104000400000301040000000100000201050202000202010300050402010401010201040000070101010403040100060001030203020002010203020200040002000300020101020203040102050004020300020205020001020202020201010106040100010002000101020202000203010200000300000000020300050800050507010201000100030400050001010401020300020101010204000403010201000004000104020101030401010305070806040102040000010102000404040006000001040100020304010007040205070101020001010407030103050100000200000001040300020100010300010000010101020100010401020206010100050100000101000001000102000203040501020004020801000008000203040102010202040200040103010103010203000104050004000202010302030000010A010201030401010304030202040204010200000300000102020104030200010004010401020302030002030504040101010002000001010200000402050101020501020000020001000404020300020000000102010401020602010200020101050003000004010003020200000000050002010404060003040106000500070101000202020204030407010400010000000000030000000001000300010008060001030400010301060102020002020105020004020104020200000003020300010003030301020000030604060404010000010203020001020201030101020002000503000301020103010101000204000504080300010101020102000203060003050103000301000004010200030301050807020101040200010103010400030201020104010501020001040001020201040400030604010002000300020100040002010004000500020203010000000000000100050100010301040003040008020003060004010601000500020000000002000401010303020005010003040401000400000000040000020303000101020003010408010101020000040302040003050104020404010001000101000401050004030602010104010300030602020200030100010101000101000003030004020102000302010001000101000001020103000204070003000000000001030103010003020201020000000002000101020002000201040100000201010100000501010703020102000407000300000300000002000302040600040303060300010106030002000300010100020101010004060204030601010002010000010300000300060302010100010202040400030203000207020504000101030300000102020104000503000302030004010001020102000002000104020303010102000101020102040101000601020000020402020307000003010302030102020101000301000202010000040100030001000102040101000304010206000304000305010102060101020200030305010500000405000506040000010104000105000003020104020000020100080404000402010304030004030707000200040A020008010000000101010202010003000307000300030000040700000003030604010001030101030501010302010001000200090101000401000101020300030102020105030404010302000203020302010403030302000103040300030201040401000101020201010102040301020302000100060102010401050300010300010203000205010300000101010101020300010101050202000503000004020002030205010200020700020205050101050002020301020200000304050404010302000001030301060400000301000202000201020002010002030006040302040501000406020300030402010001040002020701030501020103030006000301020300000200020401000402000003020301060001060107030302020402050105020001040104030200060500000105010201050406000302030301010300050101020002000500020202050000020402030006000201000100000202000201030202020300050106010202010502020102030201050205010301030104000303040100000001010100030003010403060102010100010504030504010102010500030200000000030605030201000201020101000401000102000106010000010502000101040502010303010202050502020000000102000203010005020401020001000202000300010000000300030203030302010200030201010403030400010101010301050000020205040202010103030300020102020000010405030203010005070404020200000200050201010200000006060203030202020002010100010006030103010201010505000304030301030000000200050001000202020203020003030100030100040402000005000203000000010300030104040000060201000004030104030301050303000102040002030201030302000302020002020100010102010001080204020100020101030001000201010002020302010003060102000100010203020202030200030000000002010200060403000401020101030603030001010303010701000100040300010400000304010403010303020200000501040301030301010302020301000001030602040201010502050003010001070003000003030002020100050501000704020004000804020401040700030002010303000303010004020402030003000201000202020000010202030504020501020201040201010100010100020200030103020002000200000104000401040202020003020000040200050202010200000003000200010002020002000202020104010704020500010100020100010201000300050400050200030400030100000101000001000201020101010400040304030100010100060302040302030100020101000505030200010300010303040103000102050103040100010200000004050501020101010500000101010002010504000101000100010303010305020400020100040201000001000103000203040001030301030403020101030002020200020203010503040103000604060403010302010501010105010002020105070101020102000601020104020202000001010200050201020004010001010000040103010402000300010004010201010500020103000302050003010100010201010204000201010103010001000304060200000102020200030001000400010703000102000001040302060003050000020002000302070301000303080001"> : tensor<100x100xui8>
    return %0 : tensor<100x100xui8>
  }
  func.func private @expected() -> tensor<100x100xi1> {
    %0 = stablehlo.constant dense<"0x76761F7A776C7965DF7E97A3FDAF36D77E7FF451FE7D2D65AAF2DFF9E6AE5B5BBDBFFFEFFE4F9BBE6FB9EFFDBEBFEFC973B7F6EE76FE65BFB5FBFCF7F77FFEDC67EFBB5DBDBAF17BFFF7DDF375F0FB6D867CF7FDAEFFFFFC9EFBB3BDB67FDFE4B6977AFFA7A03D7D4DF7AFFDB3FDBDFF3FE9BF6DFFDDDBDF6EDFC5BFFEFF571F3EFBFFEDBDF3ECBF787F8EFBEFFEF7FEBBBE7FDF3BF7BBDEB3B7DF5DDFFE7FFF9EFEBF77E739F7FAFDFDCAFCFE7DEA27C265EEF3BBD7EFD72FF355FDFEAB57EF7FDB7BFFFED775FBFAEE9FFFEB3EFD8FFBE54DEB3F7E5F7CF5FBF9FE77FF5CBBFDBDBF36FADFBED5F26FF3F9FAB9CFF99FEFD155DED9FBF67F5A5EFDFF7D6DBFF7FFB5D77F7AFFCA73BA3FF7DBBF61FFE49F67ED9FB77D3DFFBC4F717BDE38B7E6D66CFBEF77F0EF7C773F76F7AB7FD7BB1FFEFFCDFFFFADF5E6FBFDF77BFFEC1BD7DFBB67FFE8FA7FD7B6FFDFFBF67FFD9CE7FFA99E8FEDFB8DACFFDEFD6CFFFA77CBFB7FD6FFDFEBDDCFFBF7E7FF39EFD5FF7275FBFFBFE6BFE9FF67430CF7DFBF3FFFEB0FFFC5F6FEFFEFF0DCCCEE8F5FEFBFACB3754FF3B779F75DFF7D3AFDEFDAEDE9EFFB46F5EDEB36F3FF7727DEB7DDD271BFF473FDDFED7DE37DF2FF7DAEF6AFDBFFFF7FAA7F3B777FC7E6B9AFFFDBFCDFFEF1DDF2E7C7FE6EFDAABEA673E279C81DFBF6BFF7FCB5B7174FFFFB8BFFCFAEFBDFF9DE287FBF5B7F7FEFBFB7DFFBF69DDDDA37EF7D57F02DBEF7FCD7F97E6FB77F475EFDABF67FE7FC5BEFFDFFF8BF797BFDAEBB3BE3D2DF72FD7EDEDFFF73FFE79CA5BDF2EAE9FA1BBEEFFBFDFD75ADFEFF6F1FA77EFBDDEFBFE7775DB0FEBDDEF4F9F3FCFEA3FD3F5FEFFA35430AE6BEA5B3244F5F0A3FFDFDFDBBC5E1FD77553EDFF3FBFB757EF6BAF82FCFE2FFEF3F9E7EFFC5F7EF2F5D97DBFF057FFDF9FDF5BEF725BFF5EDDFB0C7FFFD2F2FB5FBFD8DFFE843FBEBBF549EBF3623FBFF7739ED7AFB475FFE3B7BDDDFFFDFDB957E7FE5F2FF97ECFBFF456FEB5BF9661FFFF7FDFFFF3EDD33FEF33D9BEDF7F56BE7EBBFBF73CFD51BB7BF2B7F5B47A8D77FCC7F7FF2E6C95DCF547FBFBAFBFE7BFCF7CF6BCF356D7F1DCEFF1AE8AF5FEC77D7F7FD76C5F2B7FFEFFF5BEF739585BEFFF7F73E7EE9CB4FF7FFE75F2DFBFB6FFDB3FAFCFF34EAFFD7FCBADDDFFA7D7F7FDDBBBEBFF2EDFFE7D7FDFF8B777BF7FE675FD7F76BFB5AEFFFFFEFDFDFFBB23DE73DE9FDADE4B9139F8EDDAB7ECDFEDBC86EB1EDCDFDEF7AADF1A7FB1DF3FFDFFED9727DF6F9FDBDFDFF7AC97A6EFFDCFFFBC7E767B66DFDDB7DF7FF5BB9ED637335FF7F5F37FB4EB38FEFDFE7DEF1EFF65D8E7CEF7FFEF5FDAAFFDDFB7FF53D61FBB57EBF4FFFFF73977BFFFE13B7E5FB37D37E4FFFFBEFFAF9FF3FF9EBDFBF9CFFD48BFFBDECD0F7BAFF05A1DAFD7D3FAECF9FF7AFFDDBFBDD9BFBBFEF7FFBBD5AAB07DADBF60AFDF642EEFE79FFDAFDF7ED66EF9A77C1F7A1EB79FE2DD1FB5EEDFD9BE9FBEE7BBEDD9EFEFD3B3FFFDB597DDFFEF7D9B9F9EC7EAF1BBF56C6F77F757BFFEFFFDEEFFFD7BFDDF3F79BFDF6F7F3CFCF76DBDF7BFBBF9E6EBEFFDF6FFEFDBD7A5ECBFEFEFFFF3DAEFFFE6FF87DDBB9FF3F765F2BFAF7EFCFFF3D7F3F7DFCBBFEF7A3FADD4E63CFF9DFFDDDBDDFEBBED7BF70F7DF5F9BFFF9FFF9BF2DBBBBFE7AF7B5F3FFDFF6CA7EB38F6AFD6FBBB6CDF4F7EDDFBDFDFEC67FEEAD7F3BEDFEEFFEFBFFFBDF3FF736BFFADDDDEFD7F3AA9B6FEABB"> : tensor<100x100xi1>
    return %0 : tensor<100x100xi1>
  }
}
