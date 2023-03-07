// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xf32>, tensor<1x20xf32>)
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.broadcast_in_dim %0#1, dims = [0, 1] : (tensor<1x20xf32>) -> tensor<20x20xf32>
    %3 = stablehlo.add %0#0, %2 : tensor<20x20xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xf32>, tensor<1x20xf32>) {
    %0 = stablehlo.constant dense<"0xD940BC3F77340AC097D2F0BE297E69C082835F3F6CB9D73F731201C0A9B256C0ABD0AFC0B86C3A3FEEFC9FC052028CBF02F7A4BE01DAE1BF751F6F3FB1DE19C0A20419C02432803F239C9C3ECCB3F33F7F1697BFB0D046C03C9FA23E67DD3FC08D3409C0609A864010FA45BFC8D8A23EEBF0B03E6540EBBF1F8ABEBFAC43213F31BE33C031F3EEBEDB1ECFBFC95345C0F052DC3E89855340FBE92B40D8CA02C058A862C07A8A3DC02751B5BFDDB17140FEF354C0AADD41C07FBB0F3F13FDA8C03551D340CBBCB84019CB8DC0293D6E3E5FF21140D569BF3FEF9280C00EAE80BDF60DA7C09BFC3F40BDD9174057A742C08D38244079BD6A4063484A404FE621C0B4830040B502AEC0C119ACBFBE3626C0888D2940E96706406CFA87C0BE8204C07B64A7BFC32545C0C95570401181293E473F5D3F2120A93F3153383F6D3F8C3F68E7E1BFF708583E554240BFFDE41D3F32072AC0DACCE5BFB5DC02C09D493EC0732EFA3FD3060240364E98BF2C5DD2BF71DB91C00E1B10C0A8361F3FC39760C083521340DA41D13CD4B69040C3114640A7D7A74023204DC0F2444C4073E081C0A44807C094CE503E6D8B7CC00A278BBF761E124001A78E3D88B53CC0AAFA1C40D93E73C01B9134BF219D8CC0E19F52402582E23FE605D8BE971163C029EE0BC0A8C51040C0E08A3F4B5CFF3E6EE7624033746E40E3123F3FE5FDA63F2E39DEC00B5CA3BF6AA07640909B0840F854043FE76D15C00A13563EDDB7AEC0BC388ABF6DF84EC0C59D673F7A778BC0BE917DC0733C4DBE7B7D7640A893A740734181C0CB234FC05EB14340169726C027434FBE514F0540738A19BF1A9E26C062216040FD8BDBBD350033403B4832406543D63E4D3D2F405C18EB3F5D77E43FFF3F0F4073A81E3EA5A48640476164C0F6289140D612463F78F9ADBF57E62640C27B08BFADEB2240C22DFC3F036B29C0C049FF4097ADE8404DA99EBF43675340F1319EBFE8ED3E402F27153E869E9040AB5697C0E132CA3F7CF909C0EAE678404948753FA25B3640395F0741685F95BFCEBE88C00BC6F840F4656140211E0F40501501C02FF980C0A36221405E52063FD02B20BF85E19B3FAAE9953FD81FDB4069549BBFD8B7EFBF66B33B3F8678673F148C8DBFC1A0CA3F65E59ABF92709AC0A6CB37C0D2D8B740EEDDE640A74C25C0A8540D3FFD029A408B694A408D2578C0A5BC6FC0834115BE2711BC4020F8B53FCECACBC0866602C03EC3473F842E3B3F5DA757C05B6729BF3B9B29404D6C1640BD241AC07919D8BC216F1E407575543F76CE6DC0F3C2FF3FB235AAC0F77327C0DEF104C0FE87D940026BB6C0E33A2F408D05C3BFC9BFF5BFEB3D23408BAAAABFFFE08FBF398D9FBFA85958C0F10E3B4054E9C7BFE950A63F643F8CBF665BCD3E713AE2BC5B7990C041801CC18A2C31C01DE7C63FFAAE64BE644E6740A9C64BBEB3362AC09E787340E61128C06F8B6DBCCB8A71BFBCA729C059089BC034F5A2BE57BA02C0DF26E0BF3E8BD940E3FEF9BF784D633E54922F4033A9163F43E315C02072743F78F770C021EA7F3FF4E01BBF28CDFBBFCC6005C07AEBA6BEA2E08D3ED14855C03CD13AC0E2C725C0996E03BFF4DA7D40AE9242401F4F5EC0FBB78A3FDC7BFF3E265B99BF28DD803F29CF43C06A6495BE425CC6BF25B99C3F4872733F9B8A7BC02C109D3F31D458C0902D7ABF64BA4A40CE56BEBE1228823D21F1CB3E95F11EC0B0E201C07EE89440F5D156BF4214F1BE8CC0DCBF23BB65C05169BF40B5450B40E4C02BBE214118409EECB0C0053907C0117137C0FCF9843F381BAEBF42C5F43F0D758D3FFCB1AB4052D18B3F5B20B8BFA59D093F868EB43F8E2887C04478FABE9E99D93F64433EC0353626C0F66F32BFC902943F27678CBFE83392402501C73FDEAF2FBFB141EE3E2B3A174060B51A400C00964071C1A5BF7C74263EDF010740F0EF2AC09F8F9F3F311DB640AFF642409F6C4140AC30C43E81A8BD3F0C5229BF34B629C07182374051464E3F8BC5403F4DC09BBF48F28EC01CCEDF40DB2697BE14D21840AC9220BF02C04AC069A9E0C08822EA3F409E26C028042D40B7FDF2BECC151240EA0ACC3F279C13C0639C1EBF6E991C40DC1E95C0C5BF4D3F2CA777407E026C3F861D2ABFD3162AC0A3D866408FED49BFF4A29440AA8D29C0C5DAC6C0452DFFBF1A8F94401688233F489E483F97D0183F7D19BDC0F4471640D7580FC0497F21BFC74D634003D998BF52E544BF"> : tensor<20x20xf32>
    %1 = stablehlo.constant dense<[[-1.98736608, 1.15032697, -0.797650396, 4.03624821, -5.93501043, -1.85608387, -0.593810499, 6.45747232, 5.44781828, 4.16619539, 0.0957840681, -0.396913797, 2.66271806, 1.82745802, 1.92665374, 4.35052681, 1.26108372, 2.48304367, 0.00808839686, -1.34708858]]> : tensor<1x20xf32>
    return %0, %1 : tensor<20x20xf32>, tensor<1x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x544204BF042B81BF0E4EA2BFD89DC63E2BFBA1C0E0D52EBE711327C09194464000123EBD109F9C4044EC9CC064D0BEBF19CB15404002813D29163740AE20F93F139E90BF42035F404DC0A03ECC8C0E3F41BC4AC07663FABF66C6F5BEFAE8843FF14201C1AC6A164004FFAEBF2AD1D8409663B940C00215407847B2BF1E9E6E3E804315BE592DAE3FF0F69D3E7E36A23FED7FD83FDC37B940806E2C408B0159C0ADECB0C00AD7E7BF48B50DC0E001FA40CD3214C1DF539CC0808704BD289A963FDED2404122071F416FBA8AC0693328BE2C2E9E40FDA9544092D705C0CC34894054667DC06673AF40425E1840056F8CC02E1E143F372E9A40AF3B17402AD7C03F82537BC0BF67E9C0BC1BF8BF7C107740A68D01416E85C840C2E984C0C7E91DC0776FAD3F6161A0BF0AD2B5408D8390406A050840407A734046653A3FE4B780BEB62470C0093FAE3F933AC6BF92E594409A7709C181B069C0B3DD28C09DFD5E4024E0EC40E254C6408F0B8CBF9F9502C0D299F2BFDC2FD9BEF61B2340145D573F1C086440B48C204017F9904020B6DF3F4C7E50402E8103C03E3819400081B7BCF6C700C1567AD3BF354691C0DAD9AB40C263F740158C8740349436C0A1930340C0A991BF98A18F3FF6EB1DC07487F440ABF6414073E90340128D62C0DC2462C034A58C3E550F0F40570999BEA99CF24003630DC0B60A8EBFD3F7353F1059F9BE847D8540D7500041E4BC0E409CC6F53D90E0A73E435602406E2162C0AA525140A985FCBFA1D1584037358BC038E4A9C0C9040CC0380EA0404E0D8E40000844BBC0BE12C194CE993F14984CC08429C84030FCF04055406440C67C20C059BA4640998D2340A4FA934043CB9640BA9B9840E6F27F402F3B8A406780E53F3025643FF58CEABF2074AB40FEB68BC0F42809414029A5C0D0C64DC059E500402594BD405ECAFF40EA5CC440B04923C03B96F2404AF11E41B081163FC75AA74010564740C0D18740A33C2840C9E090400472C2C088BCD0BE0EB580BF36DA4540FBD19F40947B45C06859D3406461E1BF9EC90B40498D53417304F640743F1540597C1AC0CA10AFBFDB2B8B40E3E21C4014646E405BA61E4005DF69401B62DB40E8E023C0EE0C77C09D17F13FA82DDA3DDA8B3B406B438BC0C63C44C01171ADC0947B6540AC163341B4173641542B1FC00EE21E3EFA37EF404FAF9F4083AEF9BF8CC91A3F01C38E3F20C305412A01B73F28E6F6C0C4CB80C0891FF73F682288BD1CAA2A3F8618D3C09C444B3F9ED6E03F3E9181406E7CAD400A89D440C3FA6C3FC09A83C0B925954052765FC0AE9630BF2A7D114065F10041D4EB4DC068BF2F407AB937C0E6107AC0E0DC6C40FA6108C064613A40E9CEE5C0DE91A7C0F30D154048A99C40C1E8D740408344400266FE3EF05BD9BE7A11EDBFF985FEC0FA7857BF4BF1BC4052D5843F4A1CC340567E43BEB33680C0398FE83FE2E5BCBFFFE84FBF31EF4540BC5F09C1636DD6C0917E69BF72468D409E956C405C6E2F413CBCEDBF1A2333BE26FEAC405F9F1A40BCA7D4BEC8C5A940E04120C0B8E45E40DFCE19BF471D54C0E74882C01706533F804205BF4C24343F1CAA0DC1FB488EC048B98DBF8CC82641EFCE07414C4F313FA2FA963F4C0ED13DCC78BB3FA6633540BB0191BF3DE1814044C493BEC2466D405D84753FA7E0A8C0AEA342BF3C350FC03030E3BF2486E64008D1C9C0A771E5BF9A2D48BEA5557E405EC65A40FC1C0D41A74C3EBF46265EBFCC26703F218CE1BF7710FD405EDAD04014F38B3FA8959B405BAAB0C0B86F5DC009519BC0F31B0C40501A0AC0425ABE40588E9AC0E49960405A3DFF3E869BA0403C88BF401A75B240E41784C046D862BF649B8B40A39C92BFA69F2BBF0AD36940FDB61A40396DB13F2B769240F89D543EF91C2BC056CECE3FEE5AC83FA283CE403CAE9FBFCCAA49C0B0CDDCBE461209411EB931406135AD40DB2DB940A68F29404CEBB540287B0D408C225A40851A6C403701B2BF5036AB406658503F411518BF28114DC09B4554C0C247C640096D6F40220563C0BFEE1EC000C170C0602E10BF29DDE8406409C83F7C253340001B5FBFE23F9E4088FA5A40DC6EC2BEEFC76E40064F6D4088530BC0DAD14F3F79702140C46088BF9CBCF83E87235DC04495F4404D29D7C0D47B3240A88E4FC0001B793E6C125D404AF00C41640D3C3F4704C63E1F9E5040F49E82C020CB8840311607401957213FFC1BC140F9CF97BF087007C0"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}
