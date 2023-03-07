// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf16>
    %1 = call @expected() : () -> tensor<20x20xf16>
    %2 = stablehlo.convert %0 : (tensor<20x20xf16>) -> tensor<20x20xf32>
    %3 = stablehlo.constant dense<5.000000e-01> : tensor<20x20xf32>
    %4 = stablehlo.constant dense<-0.693147182> : tensor<20x20xf32>
    %5 = stablehlo.add %2, %4 : tensor<20x20xf32>
    %6 = stablehlo.exponential %5 : tensor<20x20xf32>
    %7 = stablehlo.subtract %4, %2 : tensor<20x20xf32>
    %8 = stablehlo.exponential %7 : tensor<20x20xf32>
    %9 = stablehlo.add %6, %8 : tensor<20x20xf32>
    %10 = stablehlo.convert %9 : (tensor<20x20xf32>) -> tensor<20x20xf16>
    %11 = stablehlo.custom_call @check.eq(%10, %1) : (tensor<20x20xf16>, tensor<20x20xf16>) -> tensor<i1>
    return %11 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x4B408ABD64447CC1C73C50BCD22D9FBFBF411BC29A3F084004316B3A4AB9E3C1CAB67543D5C329C3B0C42EBC17C4CDC28BC557C63CC416BC4FB9FCC28140A542E1BCCCB6254218377443373AF0273738CBBEA5B9B13E7CBE36C0523FAC3DCB40CCC01CB937C50F472D3C3B3EC32FF3C451B70F3FBE41F4C16945A9AA9F3AD8A5D8406CC2AE441CB641BE623826401944963A87C043C215BF9DBF47469940A03CE335E54034BB02ADB2BB1644073A10A794C0923ED3C414C4EFC553BC794780BDFFB56AC06FC1DE3DB631F0C07E3BC6BF653915433342413F58C0142EE842F344C8B6DC3C5ABA8F40A14305C2144276BD5C3DEB45C13AD1BD30BD854232BF0B44073C3545C931E535B434BD44224469C4884550BF1E43A93C02BDEB46173018C330B71043FAB10943E136A5B7A945ACC0D1BD80C5E2368DB651433BC01DB86B42B7B890C1B9C13ABBC43918B82FC323280DBCD3C42240603046B9E9C0EEBCDC445CB74D4244C15229503F783A5DC25E3F2340BD3955B3CFC1A23B97BD00BDDD4059B95F3F66413C4037AFFF4482B548BC12400B40CF34DD38A74118C4AFC1D9C52D3E533CD4432AB819C02FC169C48CC16EC10CC1CEB44ABB70C3C84535C780C50943EF401FC51BC4A8B1FFC206402EC34F3C24C26BC2E5383DC13635D342902D6F40A1BC9641CCC47B41213D5EBC35C5ACC7DA3D16C49F44E035EBC0F333DAC3EBC5163F2A46C8B8C1C41EB72C4282C4ACC39FBEFDC0E3C3514703C864B95534A1C4AAB9B1C32E3FB7C52739B73BDAAF60C42EB907B9CA433F43D8331941BCC66C4264BB523B9BC4C1B593BA3AB560C1303789B005C553C0FBBF3C3053BA41C1B0B96F3D8FBCEF3FCE426DBD02C17DB8A1AE29438CC378407FBD44C149C04DC233C3EAB5E344F642CCC0C7C386BC2DC0D7B99838D6C5773EDF3EDEBBC3BF3C3888B911C40B3B864092B86EBEFA40ACB99CC45838D840B4BCE83E21C08E28CFC5233EDBB30AC451397B3E5A3C1A3809BFD8BF6E3C94C2E54027C4573E82C0AD3514C23FC407B8F7422CC66F3E5ABD1539FAC158397B4557400CC444BFEAC63CC584BD4CAFFB4361C290C084C45D42CF462F46A2C2C941FE39B446973E51C4EAC6"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
  func.func private @expected() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x56443F400B51CB47353F8F3E043CDF4270484E49D742A3430D3C5C3DE83CC2485E3C354D474E7D4CC952643E784F814BFC576D5C5150463EEA3C1C4CCE44F14A5D3F5E3C6949663C324D453D003C913CA6410A3D844142412B4465425F408A458C45D83CC0558B60633EF540083C69546D3C03426E48EB48FD56013C733D003CAE45364ABC524C3CFC409E3C0B44874F6F3DDC44BC490B42DB42295C0845FC3E463CD245BC3D033CFF3D704F313D003CFC445D41C853624FE659933EDF623540493C994499479140103CF245E33D2043F23C514C8F494B427244053CE84B69545D3C553F543DF044AC4D15493C492C401540CF59833D8440DD3F854A3542204F343EB455113C463C2D3C2453CC4F2551E4576242654C093F913FE55F083C574C693C464C123C374C603C773C7D5838458440A657603C573CDA4C35448A3C334AB73C0D486348BF3D163D893C8A4C013C3C3EC85303440A3CE73CDE45713F08546E3CD949FE46013C6242613D084A77420544133D1B3C9448F73D4B408E3FBC45ED3C794278473744073C9F543D3C853EC943AF432F3CC33C3C487F4F4D486A59E640933E444E8E3CE343B74625510548964747462F3CC73D284D11594561A657374CEF453C55964F103C234C9C43884C8E3E6649334AC63CE646373C974B043CA544FE3E19489253C747C43FA13EB45532648D40704F5A52463CE445203C574ECF590D426D5BBC3C4153673C7C49AC51CB4D6D411946744EE161F665F13C263C67520C3DDA4D2F42BD58DC3C023E083CF750DE3CD13C254EAF4C1F3C6F46925E364AD53DCB3D4152433C6E3D373C6247693C0A3CBB5467447D43093C513DF4460E3D2640E43E6843844B24402846A53C053C7D4C724DB9443440FE465244D949944C473C2454104C8C451C4ED83E19441D3DAE3C5A593C41C041183E1B43933CFF3C4C4FA73DDA44AC3C314110460C3D47529B3CAE45193FCD410144013C3559DA401F3C194FEB3C40419C3E8A3CFA413F43B73EB74AD245F34F1641D144413C3C495E50853C124C7C5B32411340D63CFA48ED3C80577044284F5042DD5FDD553940073CC34E144AF244B751084A135F935BE64A86482D3D5E5E6341AF50DD5F"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
}

