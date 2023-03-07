// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xbf16>
    %1 = call @expected() : () -> tensor<20x30xbf16>
    %2 = call @integer_pow(%0) : (tensor<20x30xbf16>) -> tensor<20x30xbf16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x30xbf16>, tensor<20x30xbf16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xbf16> {
    %0 = stablehlo.constant dense<"0x883F16C00A4046406B40F340C6C097C08CBF2BC041BE08C08040A6BFAC403BC0064054BFC540B9BFD6BF843F07401BC0783F8E401A400AC0D0BE8D408340AAC07F40F03F3CBF4E3FB6C0884070C002BEFDBECABF88400940283F62400FC0313F36BF90BFEF3F8DC00EC0673F4EC0D4BFAD3CF7BF843EBABF0641B0C0FFBFE2BED4BF70BFC33FFCBF173F05C0DC3FC63FA73F9AC092BF37C02E3F1C4010C0913F90C006C0B4BFD03F90BFB13EABC0224071BC71BFCE3F1A3F6040D2BE1AC05840EF3FCD4018404D404AC02340D83F33C0B93E08BF47BE7D40A93FB13FE2BF10405E40DABDEFBC32BF3EBFA83E94C00ABC983F843E4AC04840EBBFD73F7C40C0404640D3C004C00C40FDBFA33F8F3F7D4033BFE53F2E4046C0AE4005BFCA3E43C0D63FAA3E8740E240A2BF05C091BE6040693F303FC7BF0D4084C094401CC01E40B03F8CC0993EF33F6FC0CBBF76C07640413E2CBF8140D7BD963FC53E1340613EB2BE9E3FFE3E29C027C0CCC0994009407E3D854001416CC05EBFE140943E053F974085C0F5BFA4BD87C0D73F99C005C080C034C093BFF83F93C0AC3FBABF8F406A4071C055C0A140E63E0140C53F6540F13F233F5AC031C06DBF3C40893FCE40C93FD9C01A403FC0DDBE3AC062BF1140EDBFD7BE85BF923F123F2E40A2C071BF45408740FBBEB73EC83E93400D40D6BF3DC0FF3E91401F3E5FBFB8C0D83FD2BFBBBF624010400140AA405C40A9408C3FA23FB5C085BFD2401640E3C0B53F4EBE5E3E9FC0853D3740D73F8A3F40BEAABF38C09240CF3FEEBF5DBF073F283F714057BE1BBF803E0FBF66409F3F7D406640B93F3BC0883F79C088BF213FA740B5404340A540FFBF103FAABF8BBF0D3F2240C6C0EEBFC24059C006403540BBBF114088C085C00FC0F4BE303EF53F713ED63F23405E40AB3F1240DDBF7C4023BF72407BC0B13F66C031C059C053402A3F39C07340BB40553F8C3F72C095BF893F62C0CEBF033EDCBEB8BECC3F8A4089C03ABF77BFD33F5FC0EF3E83C00BC09340B8BF25C0EF3FA54030BFAF4044C03CC03BBDFBBF39C01940383F17C01840E5BF50C0AC3F25C0A1C03740A640A3BFA2BE54404F40E13E5E3F88C0AF3FD5C059C023C016BF87C08E3D5EBF1ABF59C0E73DA0BF23C0544067BFD83F05C0DCC05DBFE6BE31C02240AD405F3FBF4082C038C08D3E22C0053F20BFB93FF7BF4E3FAD3F72408BBFD5BFC53FEE3FC83DCA3F0940EF3F9E3F594085BF7F4085C02A4068C062400F40823F7F4064C008401F40A34016C099BF2CBEC0BFEEC086BF8C40CB3F3FC0A7BEACBD4F3F7CBF1E403140EE3F2940AEBF943F94BFE03F7940AB3F11406BBE94BF153D25C19D40C83FFC3F93C0143F33C0A5BE413F064184C00CC0F53F6EC0C6C08940793F383F87BF47BE40BD03C0C3C03E3FE83FF03F543FF9BF1BC006C0A6BFF93FE740C53ED7C03ABFDBC083C04440C1BF24C0873F62C074404BC041C019C08E3F214007BF243FAC40623FE6BF463F1EC019BE1440A5C0F6BF48BF8D403A3E94C0413FA3C0943FCA3F2D40EFBF9D3F1DC09240C1BF353FDC3F2F3F00C0FEC0BEC05A3D9FBF5C3E913E144031BF28C0B840BDBC41C05C402BC0C73FF8BFCEBF75C05EC037BFC93FFB3F2D408AC09EBF8B4027C00CC086C0EDBFC7C090C083BE284034BF07BFC03FB5BF3D40A9BF"> : tensor<20x30xbf16>
    return %0 : tensor<20x30xbf16>
  }
  func.func private @expected() -> tensor<20x30xbf16> {
    %0 = stablehlo.constant dense<"0xA23FF241AD41B74236435045B744F843B73F4B42A73AA24180433540504493429941F23EB4448C40FA40903F9E410A42613FC3430642AD41DF3CBC438C4348447C434641953ED73E8244A24346438839743DC640A243A9413D3E1C43C8416A3E823ECD3F4241BC43C341293FD742F24056345D41903B8E40994565447C411C3DF240463FAD407041F83D95410C41B7403A400644DA3F86425B3E0D42CD41D23FCD4399417A40DF40CD3F6A3C4B4424424933493FD740063E1643E73C064201434241D244FD41D242C6422942014174428C3CA23DBC3A744342406A401C41CD41124307394235703E9B3E3D3CE443AD31FD3F903BC642BE42364100417043A244B742ED449041B74174412940C83F7443743E24415B42B7425B44953DC63CAD42FA40483C9E431C4524409541D23B1643303F653EBC40BC419043E4430D4215426540B743033C50414243CB405A435A43A73A503E84430039F23FB43CDF41193B703C1540783D42423A42D0440344A9417837954384453A43123F1945E43B953DF843954356412C389E4300410344954180437A42DF3F6141DF4350408E40C84333434943F5422144273D8441B44024434941293E07436A423B3F9542A93FD744C34004450642A0420F3D8E421C3FD2413B41003D953FDA3FDA3D5B422444493FB4429E436C3D863CBE3CDF43BC41FA4099427C3DD243193A133F88440141E74093401C43CD41844148440C434244B73F24408044953FE744F2411E458040D73A123B1944953786420041AD3FA23A48408842DA43DA403F410F3F9E3D3D3E4943003B0A3E803BC83D27431940744327438C409342A23F6543A23F213E3A448044AD4231447C41CD3D4840B23FBC3D2442B7443F41A9440443994180429340D241A2439543C841543D653A5641493BFA40294212434B40DA410F417043293E4D436C436A4027436A420443ED42483E8C4250439344F53EB73F4D43EA3FA93F1C43D7408C390C3D883CD040AD43A9438E3E5D3FED401343423D8C43B241DF438840314242413144653E5F44B042954293366C418C420342883EF841FD412441DF42504031422144864235442940243CF242DA42193D123FA2435F40F54404432942F23D9E43C337123F063E044329391C402942F242293F014195410C450F3F273D6A4224425644133FA04488438842BC3B2442953D1C3E8C405D41D73E56404D43B23FF540B4403F41BE38C640A941424115400443953F7C43954348422C431C43C841883F7C432143A24119422944F2410340503AA2403F45993FB743CB40A0423A3C5038DA3E703F15426A423F4142425B40E43FE43F164165434B40D241363BE43FEA3531461244BE407041DF43E43D7442313CA73E99459043B74156413F43B744A943653F883E9E3FBC3AA2368C41AD449B3E2C414641F23E65410A429941354065412945B43C00458E3E09458C43B042A7402C429E3F1C435443CB42A7420342C33F21429E3D2C3E50441C3F2741B73E1542033AE44131445A41BE3EBC438E3AE443A73E2944E43FC6405642424112401242DA43A740803E0C415F3E804178459B44073719400C3BD23BE4416A3E3D4288449934A7420C434B42BC406141D74056431243863EC3406C415642AD431540B2433A42B74199433B41BC44CD438C3B3D427A3E9E3DA240804099424240"> : tensor<20x30xbf16>
    return %0 : tensor<20x30xbf16>
  }
  func.func private @integer_pow(%arg0: tensor<20x30xbf16>) -> tensor<20x30xbf16> {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<20x30xbf16>
    %1 = stablehlo.multiply %0, %0 : tensor<20x30xbf16>
    return %1 : tensor<20x30xbf16>
  }
}
