// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xcomplex<f32>>
    %1 = call @expected() : () -> tensor<20x20xcomplex<f32>>
    %2 = stablehlo.log_plus_one %0 : tensor<20x20xcomplex<f32>>
    %3 = stablehlo.negate %0 : tensor<20x20xcomplex<f32>>
    %4 = stablehlo.log_plus_one %3 : tensor<20x20xcomplex<f32>>
    %5 = stablehlo.subtract %2, %4 : tensor<20x20xcomplex<f32>>
    %6 = stablehlo.constant dense<(5.000000e-01,0.000000e+00)> : tensor<20x20xcomplex<f32>>
    %7 = stablehlo.multiply %5, %6 : tensor<20x20xcomplex<f32>>
    %8 = stablehlo.custom_call @check.eq(%7, %1) : (tensor<20x20xcomplex<f32>>, tensor<20x20xcomplex<f32>>) -> tensor<i1>
    return %8 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x604289C069D783402467A3BFCABB3EBFB6D7A440FD870D40E285443D8E10273F1635B040FE078CBF4D60EA3F7AA485C0D4E4CB3F1F83F63D30836840FE1AC3BF02160340A531EF3ECE47B6BF4508B33F1AB0F63F869A60C09B48EE3F6CDB1740786F2A40C9BDB4BFDAE62EC0395110BF98A312400B2DC33F093494BF40036CC0176BAF3F3F70EDC018FA09C0FB4F9BBE8DF24F400E6609C0453C4F3F969DC23F85EFA7BE3D5804C09316183E276BADC0CC676540E79FA13FF4A498C00BB928C0622E88C0B3B793BF349C853F6F86A7BF1885E63F36EE43C07DC24FC08D5BC4BF12CF2B407A8146C0F3305440631B08408B459DC068B779BFBDAFF83F6495DC3F9A534C40C78305BE0D6E1D40415FC73F81B49540B3BDE4BF1D1D42C0B975B23E97243D404A565BC0737A41BFA27D3FBFE1BABE408C71873F780728BDD2223340179B13C0705EB3400256CBBD7F33D9BFE1D56FC0B043BE3FBF87B83EB28319C022C162C0CE0D933F95B1A03EA31664C08A105EC0B29C923FA7681FC06DCD03C07DA49D405A2A04C04892483E0D9CE93FD97E0D4071CECDBDE66337C00953E7C0D3C73DC0E63C8C409774123D3AD22740A8805D3FDE9D70C0B98441BF9E9011406BC2963F16B736BF141C883F12572DC0621ADABFC5FBEBBF7F0B33C0A1F8964005C96FC0DB0A86BFAF29A0C0E4D47940CD2E95BFD37C6DBFFD868B3F5622B83F95CBA0BE8CB933C0E12C94C04A1619C0C2AFCA406224A5C0354A5BC05F7BCC3F4F4914400AEB76C0F373CBBF22C38640BB6E65BFC81811C0A42A1F40DAB1D93FD60D8240ED441CC025AD1840252F4040411DBB3F737ADDBF158C883A2D4EEDBF0B1CAD406C65A5BCC6D006414D9D7B3F645F6CBEEDBDABC048F7CD40F6C33AC0241E32C03B89B5BF92815E403227B5BE8EA302418070B6BFD694493FCA4A1140135AE0BE082B44BF179BB23FBA4B6840986571C044D3EE40682A96400BF44C407224D7BEA3D169BF1FD3D5BC945E80BE359562C0E5F644C070128FC0F589BB3F479E00C015DE0940A7C9AD3F8BB391C0A89008BFE1597DC01712BDC0EDAE94BF39273DBF8F9802C0C82D074083F9D5C0B4EC8DC0B1817440422CC8406F663EBFC03CBEC07966A0C0E268DE4063CE9AC081C782BDCEA7B9BD2C40EC3E53530D40A444E3C025D9FE3E8A1058C010481D40B2437140438506BF3207983F60561840D0532A40883F993F006B31C0FC63AA4032743BC0B8AB07BFDF1206BF8489D7BF65023CC0B3D99CC00877563F70E1FCBFCC329F40F82035400BEC84BFCF3CC1BEAFE39ABFC0913240CD981ABF7738F7BF70A5D4BFD5CB303FCB2211401D7205BD469E4DC034AFCCC0007F19C0A8BE674016521F4066A3A6BFB5EC7FC055A8773E06D985BFF58084404DF911C0B24202C1172D0EBED45929C09358C9BFE1554A4071FD9AC08626AABFC7D5353FBA9E0FC075CA51C012B235405BA435C0A94F26406B8319C0F1DC273F9EC6B73FCD308B3F135203BFE8051340F19D64C045B4D53F56ABA53F09041D40139D3E404113C8BE88C7FC3F046A0341901DA13F343AF6BE22285FC017DF3C4063954AC0A4B8CD3C94A2C03F9C277E404FB037C0C365D6BFF84F3F3F262932C097CACABF2B1FDCBFFCEB6F40DA4ABFC0919E9540BEE9504030B335405DDD1C40D40CDB3F48DE09BFF611F93EDEC4C8C0AB8C95BEB10989BE5ED7E7C015073FC0E37F8A40D03EA63FA55B8D40C8DA0240C4C4DEBFFF3BABC0B36208C08E67BABF424C84C07A31DE3FF1A089BFEE19CA3E00DD8AC0D063CF3F6B72DF3F71910D402A65CABEAD64673FD239B7BFA77080409D3A18C05D833F407CC7A440B994184091CE51BDCF5E34C0E3C3F93FA76234400A92F53FDC57424089FB6940D9A782BE66BEF4C0CAF22FC063E06EBE604A4ABE64244CC014F6793E8458B9401770D5BFB4E35CC0C64F72BFE9A35040CC9993C0E3A1543FA8053FC0EEA02A40C05143406CFC88BF0AC62E3E082C18BF562FBDBF77621ABF91393AC06DA50A3E7F9B493F38F63340F93559C06E83373E6995BD40C8DB8D3F66383BBE86BDBD3F4425BAC01E540DC05FA7FC3F21E990BF82E078C099B91AC0848437BFBDEB3040DA71543F70327F3F0150CABFA43745C0A82F074026F59640D9F98E4039E58F404FF243409F73843F3003103F0A785B408B2F7EC08EE752408EF66840EA5BE0BEBF767A40035712404FF519C000D3923EFA734E3F2605A3BD8E0923404051543F8ECA93401F8E4DC0E45767C0B541E93F50E9A43F9FFB7EC027D789C04482A5C0A5E7E2401573A9BFC4642FC0D8A1F0BFD31E4640FDEFC54070AD84C0AC72F5BF9B444740202338BF098BDB3FEEEB1F40C7C253BF4007A53ECF1FEF3E58B2CDBF3B16E73F6E56784091E106C0AF71903FA89F16C0113D3F3FFABB25C086EC3F4070254FC097F4BDBFA4BA154045F9853F67BC32405DD74A3F0A8476C0273A68BF20D86340FBAEB2406EF5E03F4C5137C00292B33FB9ABEDBFE80410407D400840FCE29ABF510DAFBF56CCA4405C703DBF47B820C0F2B0D8BFD55573C07251233FA96D1F4071B288C029BC3F40642E9B3F62A20940919801C02400B63ECAFC82BF60ACE4C005F82D3FE9DF4840CE6F11BD1EC4A6C0C27EBE3F1006F6BF5F61BFC09906343F148D464034D48A408C9383C0403417C0CB286540D8D0D8C0A51590BF189A4BC0DAF05FC06B9F714070DFD8BFA363E43F29CD82BFB231BAC0188741C099BBB73F78F335C0FCA8C93FAC922CC0F3F1ED3FC8CFE33F8BAD64C0469B4C409A48994051960AC0B068C6BEE87997C03D3EF93E803AF0BFFDC98AC027EE64406ABBA63FA4ACEA3FFA235CC014003CBFBDF21E407AE8B13FE4827C3F4CFB034091604640DD67524015AD7140231F893FA129863FD16D8C3ECC7716C05C49C1BFA6F2A7BFC12647BF6301A2C084CB50BFB748F73F11443F3F1A1422407CC8CCBFDD998A3F6AB865BE6A9D03C0109442C063C1C5C085DEFFBD69B1013F17FA9A3F997386405EA52CC012A1A240FA4AAC3F157A9A3E51D9D53C895EA340C5B1BBC018821940B0C84BC044BBBC3E6F4C93BFBFAEC4BFA8A9BDBE423BA6C0327B75C0245D9EBF070226BFE64FA2BEB94F953FC91C44401E43AFBE5D8CABC001F6AFBF716485BFF73EB5BFBB0AC43FA53D36C0ABB7B0C0934322C009AD88C0207E75C07486D84068F064BFAFCE5C40D62DB340363AE3BF70EC264077C1B3C09261013F37D6923F188EE63F2FF0B53FBEEA5B401C3A53407F3AE73F41D5963F4AE9E740D781C03E91612F40615D9BBF00C0A540BB790D403CFC853FE1F16840D1F74A3FAECC49C091646DBF9A74E2BF8490B9C0BEF5E5BE54212BC003C756C0696606C007F99B3EB2C7E7BF704424C04AF2293FD3DAF43EBF4DBCC06031B440DA1651BF936DB7BF44DB47C03A6CBABED8FE54C09CB3C8BE7F691DC027904C3FEA55A83EEB9C5440A04C313F1234303F237BB9BF6E53313F1FFA80408BC144C0FD50E5BF42A232C0FA4CDC403FA014BF7EF55DC0236CF2C04D6C7E405B5C024007D870409DD157408BE0AABFD44B9CC00674F43D2813993FF37566BF9AD2313F1E103CC0C87E1E405044D23E27E24BC02985DFBFAF3DEA3FBCC254C005EA713E104C4C400AADCB3E25EFACBF9A7AA2BFC4BBEBBF186D9DBFB76241C0B7F12DC0B4D7E2C09DFA13C0983022C0673C6ABF50A38740DE2F6540F8E21CC053EB5AC0DFC7D6BD516C2E3F4B4576BF10A2873EE742C8BCFC96A13E82418FC0091A913E4BB6823E54C06940ACF42340ACCE8840960AC2BE3494DABF35B54FC0B59E3740A1AB203FB820C040E77F6BC088DDA23F2F69E03F948DDBBF00B36B3D4F1F41C0D1DB6F409FDC37BEE75B02C167DE90C092D839C0D4C28CC09F16D7BF1786BB3F3BE7A64066832CC073FA133DE66029BEDC4786C015E086BF7AA899BE572ADC401E8D1940AE127ABFCDA6A6C0EF9D4F3F665CCBBF3D4D0E400FC8C4BFF4030FC0141583C0B94B32BF835CB6BFA5AC063FBB3916BF8BF00C405540273D80E962C09F225E40F60F7940D2FE06C0E298FBBF86FC20C0C4DA0EC09CF81F40367E1D4014A026C0DF2DABBEB635D73D5F643340980E853F171C0AC0536B9940B76DF33EC0E217BF074D89BEEC009F401B1571C08EF19940B26149BFD03B34409663B03EF5A93BC092E267C0B06AB23E2D44033F246D5E3E5F3D8FC05D3505C083B86ABC2D33D2BF5BD82CBE46ECA44019528BC020C3873F83F0FC3DB8F122C0464FF53F6025AEBF4C3545C09AB183BEDA355DC027814D40C2D4153F1F73814009BB5DBF4643A9C0CFC954C084F980BFA5EC0D404C9826C0704C8C3FBEA7093F33F39D3F38B5023F07E4BFBFC844E13F601C3ABFA31D99BE6D81C13F536620404134B9C06258E4401F40A3C0DEC1E7BF713BFF3EFA8E9B3FE9BB1BC00B5664C03DC72DBFAFDD8E3E61671840AF131840EF22D6BE60DD43408705C6BFF6811D3F7F25B8C0"> : tensor<20x20xcomplex<f32>>
    return %0 : tensor<20x20xcomplex<f32>>
  }
  func.func private @expected() -> tensor<20x20xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x5025F6BDF800BA3FDA380DBFBF858FBF5481283ED2D2BF3FA0CF093D4235143FC886343E377BC4BFB8B5AD3DB981AFBF1A6A3A3F6636BF3FB0A3713EB4D1BBBF2C0DFD3E5AF6B73F2A4EA6BE64DD983F98D8EB3DF819ADBF6A28463EFE20A73F6765963E758EB3BF3C77BABE6B86BEBF0CA7983E4D44AD3FE8D295BD95EAA9BF40EEC13CE076B8BF44C7F9BEF7C4BEBFB41C5A3E203AB6BF92E05D3E1A47893F90CA7ABDBC6A90BF0025A03BDAB8B1BFEEAF803E612DBD3F408624BE826FBDBFDCF462BEFD17C1BF54F29D3E3A208BBF54BE0A3EDB03AABF7EB781BEDCE6B8BFD8221F3EAE27B1BFF0D3593EA4D1B63F38C04ABEC8E4C3BF80378D3ECF79A63F909EA53E1140C7BF3A3C933EF7CBAF3F7C3D403EAAA1BFBF279AACBE68B6C33F949E103E7668B3BF7CD0E2BEB73754BF54E6273E3F44C53F002298BBEA259D3FB0947BBDB89BB53F904ED1BC690A85BF503F6EBE05BEBC3F3840573DB25D97BFBCB384BEEEC1BD3F8071BA3CCC48A6BF481187BE3453BD3FECC66EBE70BEAEBF2C9B313E5788BFBF601D383DBC60893F26E6F83ED7C3C5BF60803FBD64CCB9BFA86AD4BDD6F8B43F00BE943B266F9A3F3004603D584BA9BF4481E9BDC824983FE677113FF26C88BF340BEA3DA1E4A0BF6F7D81BE632CA2BF1859BABD07FCB43FF0C180BE91A5BFBF784DFDBD0482BC3F2D92EABE91BB89BFA2C4903ED81C8F3F60680FBDECB79DBFE8DB2EBEBA7CBDBF00BEC13DCA18BFBF3CF676BE01F7B93FE8E8E23DB8AAB0BFB0429ABD04AEAE3FF03C07BE408E99BF906F8A3EC88DAF3F20E3383E2FC1BABF0894203E7BA2AE3FA3D8843EC36E9CBF00387639D4BE89BF387D3F3E73F8C8BFB0DAF03D1F4AC73F805BFDBB1286B1BF983D043E4877C1BF05A692BE9C03B5BF26C1953E3407C5BFA075F43D5C5EC6BF8881F23D6866983F13198ABE10BF36BF0811B33D1AACAA3FA0A55ABDC469BB3F886D143E8022BC3F5BF163BE53D149BF1136C9BC5AB57BBE3CDD22BEAED1B6BF8CB950BED13EC03F224662BE0957A83FE0F26C3D1F80AFBFD00A01BDB0E6A9BF942E28BEE5D9C4BF109807BEAEBF93BF20D72C3D34BBB7BFB89A03BECD9CBA3FDCB6223E259AC6BF709AC8BD905FBEBFB034C63DD65BC0BF06E281BDACE5B9BD88669C3DB655943FC06910BEA5C7C73FE0A244BE4677B63FCA29883EC315C4BF582C1B3E8F879E3F57C1A13EDC52B53FD8729ABD662DB63F1F1CAFBEA07BC0BF2A6F05BE255988BFE09CB4BD6FD7B5BFD6DF1D3E82DD93BF0C831B3E37C6BD3F676159BFFD7D6DBFC072F6BD60FFA23FA472F7BD3CC38FBF3C3207BFA0A8A53FF552F23E3E0EC8BF70357DBD6D1AB9BF1042FCBD8669B03F05FAA13EA3F1B1BFEE4782BE6C01C73F20825FBD8A66AC3F800F01BD2988BABF80DB8DBC18EA9ABFF8ABF3BD0AD1A83F987E46BE0211C2BF5804E23DA22A97BF001E30BE124EB53FC46C40BEBC05B23FCE8ACEBEDB33B93FCAA6D23EC7CB973FA8F6A1BDF76A963FB48F6CBE409FBA3F82331D3EA494A03F612CAF3EE6D8C2BF40CCDF3C0462BA3F8A91383F6F8B91BFC82E29BE7394B63F6177A7BEA1B4C83F484AA33DFA23AD3FA6C484BE0B75B4BF08DEA53D14659FBFC13589BE2A129FBF6047983D7EAEB9BF14BD123E52FDBB3F38F14A3EF817B23FB3BF103F0B23ACBF4059443C52F2B4BF544F8EBED6D390BE8834F2BDC8C1C2BF346E5B3E3A8DC03FF8A73F3E00A7BD3F40145BBD0092B3BFF29CA0BEBFA7AABF44E953BECE8EBD3F6A6C54BFBD39793FB4B850BEDB01BF3F6627533E1BBEA43F694F59BE412B473FD02A9ABD990EAD3FE82021BE208DAE3F4C3C243E285BBF3F80A4BBBB126E9DBF04E2213E1328AA3F8014113E41DDAA3F1AE98E3E936FC6BF10C8EDBD59AAC3BF586369BEF56E52BE08F6A4BE6CAEC53F584E243ECA09C3BF7F978CBE59E3BEBF70A2CD3DF07EB6BFC0D5A13D2839A2BF28E4213E41F1B03F64EF9ABF27C5823F140133BE7D3B83BF908C7CBD5028A0BF6ACCAA3DCE2F2C3F38B4103EDA78B2BF0089A23B56ADB33F911A933FEE488CBF604B243DFA8AB4BF8E6879BE25FCAA3F78FB85BD4823ABBF9FA3C9BE8354B8BF437CAE3ECFCFBA3FCA3A743E58418FBFA04960BE30E4B43F8835E33DE365BB3FD0141B3E838FBB3FE608293F967D733F400BFB3D1B72B6BF5C9C093EB587B53F80AAD9BCC065A93F04324D3E8B66ACBFA11D303E7A08343F60022EBCE337993FB0D6133DC98FAE3FBC250ABE1211B5BFD03CB53EA34BA43F7051EABD4AEBB8BF908D88BD8C42BD3F982307BEFA93A3BF80BB0BBE87D4AA3F801AE43DCC63BFBF88050CBE9337AB3F9C4A2BBE64568C3F4DF4BD3EF6A4B7BF506E883EC564F13ECC7F82BE7E0DA03FDCFD4B3E3BB9BABF403F183E407F9DBF702FBB3D89D89CBF2C8D1A3E7B7CB3BFE88436BEBDEFA13F70F4DB3DCDA7A13FE0BB453DC9BDA9BFE0D380BDEDEAA73F28E5273E3053C23FC10291BE3D10B63F061A53BECB83A63F26E6B43EDA31ACBFE0223FBD2E0BB23F9C4BC3BDF4AD9BBFC06DBFBDA028ADBFB044AD3D71999A3F800020BE7AAFBA3FC251363E5C309C3F3B2304BFC42EBB3F40EA9DBCB49CB7BFD03C773DB41AA33F0046A5BAEECBB0BF86F86B3EAC8B9EBFB85F2ABEB982C63F000DDB3D2A77B53F1C2C3BBE9035BBBF70BC763D4C4EBABF0031BCBDB9E3A5BF6C3C05BEAAA2B63FBC0086BE90B7A13FC06FE9BC16E6B3BF421B8BBE9182B73F34CB89BED7B1B43F248D7EBEFAB1B13FE07EDA3DB17FACBFE8EBC13D2289B63FD346F4BE3E50BCBFA82759BE5C2FC63F182CA6BD7E58B0BF08CA7F3EB1DABC3F40F8EB3D1A2DACBF608DC5BD4C3A9B3F811AE43EB6AC953FD0ED113E8A50AC3FE4FD033E109AB53FBCF6CA3E8EDB863F388A2A3DDE1C96BF6AF8B2BE0C169BBF203EEABC49A4B0BFF8B81FBE1DB1923F343EC23DE00A9C3F5D71D2BE5F2A9E3F38782EBD509C8FBF103D81BD9E69B8BFA5C2CBBD04ACF23E00B1773D3445AD3F305CA3BD5F70B53F6AD8513FDD5AA33F00D87C3AD14DB03FA41716BE9542C13FDAD0A3BE38FCC33F84A489BE2C7E92BF00DD57BCD9D5B0BF34E674BE2DC3BEBFD90822BF8B7EECBE380CCE3D1C26A53F40E13BBC128CB1BF33D3D9BE661695BFF2D096BE06AA993FC84594BD70C7B6BF58F7CCBD83E5B2BFC86880BDA4BFBA3F986C86BD60F7A63FF431273E184EC2BFB885883D8F5DB6BF95B5543E104E683FC9AEA73EFA6EA33F9CD9183ED529B63F7DC3C13E3762A43FF4CE0D3E6621C83FE5F19D3EFF2AB6BFCCE4273EAFE9BF3F18988C3D6A19A93F68388D3D5AC6A3BFFCDD47BEB26E91BFF83F31BEA84FC7BFE8CA10BED783B1BF618100BF4B0ABE3FBA6831BEA579A7BF60F90A3F1E771E3F00D5B4BD3123BE3FC12B71BE7D2287BFA137A7BEE5D3C3BF83359CBEA52AC4BFB206C2BE2788B73F60FFDD3C78F3A33FDFA6E23E43BB443FC51E10BFC3FB9A3F90921F3E1172B9BFC0AD1DBE307AA8BFC8B4143ED978C7BF00624ABD3C1DBBBFD4824C3EEF82BB3F2854153E59E4B73FB0F64DBD6CE7B0BF20A6483DCC93603F0B8907BF4EA9633F507D48BED8F5B23FA0E5143DE9ACA2BF0E4283BE3CEEA23F92FE9DBE8212C63F2DF9A23EC4A0C33F2218B5BEAF7B95BF7033BBBEE614A5BFD83038BE547FB3BF440B03BE76A7C3BF7CFAB6BECFDBB6BF0CEA0B3E3CF6B93F605E09BE1431B0BFD09592BD4A021A3F531380BF6000483F5624B6BCA09A9C3E38A667BE572AC73F203F913C8700A73F58C3CD3DD005B33F1C75C1BD334387BFE09D2EBEF110B53FC05E893CB227B43F74AA7BBE4CAEBD3F8E8C8C3EB6ABA2BF8089BA3B191DA0BFAEA38B3E174EC7BF801AC0BDC556C2BFA880D1BDC5BFB4BFF81AA3BEB85EA03F84281B3E51D7BEBF8C17103D801128BEC0B668BE517CC1BF0015CBBBFA9EB63FEE91BA3E17F7B3BFAC1742BEB430C53F06FD49BE9A83A23F0CA445BE4AD8A1BFBC3B77BE2398C3BF096A26BF0BAC9D3FDC66C4BD0C3B953F002C453BC6E0A5BFA8B7003E4293B63F44177ABE4A7EA9BF743A5EBEB3E8AEBFA44E4A3EA5C7AE3F98EFCABECDD3C1BF402F423CAD3F9D3F9050233E10C699BFBC7E563EE252C63F887719BF42EBBFBE0455023E347FBCBFB0F8513E34A5C4BF9699BA3E87D3C23F382E07BE1C89B3BFB6CC8D3E7FDB033F00D1283C4CFDACBF1A0606BFFB82C8BFFC0931BFF3B1BCBFA0BBE63D20B3BCBF8654AD3FDB92853FF0567CBE9DAFAF3F4074E5BDDDADA6BF0002A2BCFE2FA5BF87B59E3EC156C13F4C02763E5E35C2BF68960ABEF4FBBDBF7C3E19BE9E319A3F598FA9BE3594B53F644E4E3EBFBD713FA778193E8D5B82BF4695FF3E6CB2A8BF306AB7BD56B07F3FF0057D3D2A7FB6BF20A1BD3DCB83C0BFD69A0CBF7102B13FFE8A183EB2719FBF509A8DBE8CF6C1BF78BF293D90B3963FEA61DC3E4E11BEBFA4C9853E0E24B7BFC02E923C9A46B3BF"> : tensor<20x20xcomplex<f32>>
    return %0 : tensor<20x20xcomplex<f32>>
  }
}

