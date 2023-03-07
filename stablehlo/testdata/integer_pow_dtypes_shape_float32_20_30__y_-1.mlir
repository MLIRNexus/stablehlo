// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xf32>
    %1 = call @expected() : () -> tensor<20x30xf32>
    %2 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f32>) -> tensor<20x30xf32>
    %4 = stablehlo.divide %3, %0 : tensor<20x30xf32>
    %5 = stablehlo.custom_call @check.eq(%4, %1) : (tensor<20x30xf32>, tensor<20x30xf32>) -> tensor<i1>
    return %5 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xf32> {
    %0 = stablehlo.constant dense<"0x326C19C0167A5EBFB833523FAD920BC067F92B40BA88AE401BC410C01673E5C09F215340304D87C0D50ED54063262E3F11B4F63FD187B4BFF296034005D7AEBF903093403D7AA2C0CDF6FF3F53E8F13F402D72C0BF4995C006D9B53F1AA600BFAB7828C0917E1740FD0F8B3FDF1222BFEB6A0E403484ACBF7B5022C0171EB6BFA302B34086C299BFF5CF1F40B1BFB23F157E1540188DA43FAD998AC0189E1AC09B3401402E7A31C07CCC99404ED524C0A44BC33F9EF624C00A2285C0BB98F6BF10B3B3BFFCA1E53F68A405C0FCE593402F2685C09C7FA3C0B5AEA63F911B4F402A051CC0D77ADDBF20ED93BF0594903EAE5470C071688F3E2C2EBE3F3EF5B0C0864DD6BF70653ABE55FC924059028CBEEC33B340C4C27640E04322C016DF6A3FD56C923E8B87BFC034C992BF63F9084022B48940801099BD82EAC8BF2A30C6BFAD48B63E932217402242A0C0BC6EFC3FA5109BBF2FC179C01202C2BF76198B406E0E88BFC9488740EA36EFBF015649BFB8AE4EBF105E77C0A94AC63F4AC8AEC0281AB0C08D7B324048C219BFFD5A2EC035DDECC03B6D63BFAA4B8640FB28C93E21BEE8BFDCC0B43FF16F00C048BAE73FD58F9EC0721585BF264B40C06EC786C0EB5C5AC093F8B2C04C49833F1F5EE93FA9BA8CC0E30F763EC683C13FB1D91BC0CAF2814043F68AC087A4AAC098C881C0D3F032C0B4DEC03F3E52D13EE2E45F40E36FC03F4885B0BD9AEC8240AFE65CC0488B21BFC3563540992DF33FFD49D4BFBC2EC1BE47A703C0F4AFD9C0C5F5B840771B71C068B0D2C052376640632EC23E1E6B49C0BB84A43E62C6A83F9FBC74BF167C5940B83F2E40043C28C0999710C027ABCA3F32EC0D403B863B40B9ACA3C07C08DD3F85D6BABFE40FF0BFD0BF90C09AA826C0B300BC40667DE03F408EE53F83153AC00F9F2AC00B8E8640294643BE4568B9BF0BC588BF42922D3E36008EBFFFD13BBF33B2B540285D093F8642F53F546844C057B1474009C3A43F9B1B75407421523FC0F138BFD1A810BF3543F93FE68D78C0462F09403A1A5FC06A8044C05352D2BF3F87813E392886C0A0459EBFD569D03FCCA5B13F6DC7FC3F80EFA33F33543CBD8D0981C031458BC0E1962DC01ED268BFAF8E074112FE2BC02F9486BF260C543F910B9EC08A87CFBF9A19E33EEB3F4DC06404264011ABBF3FE2BF0A40E2947FBF464D0DC14857953F51AE01C0C1DF6A3F8A36403FF66EBFBFE01CB53F57C8B3BF2B341DBFC0B80440BD0B0FC0627C60BF8E2E67C0ED270DC0595CAD3F94D89BBFEA0F4A406ACC3ABF67CFAD3EF25A3D40727A8BC05C412140103E8C40F8924D402D8C4CC04EC4333F9D1A843F7FCAB940432EE53E462B473F97AE9A4045831ABF49FC4DC01AC666C0547052C0F74261BF3FD22E40BCAE3540FEF24CBF6959AABEB1097040083B5FC059DB81C0588C36C015243E3F49DAA540EC6D80BF61CD873F68F495BF723ABD40C4E5A33F6727AE3F4DE3F2BF162C9C3FC35A7EC0AA9D2CC073BA2BBF482A2DC0F438E93E73AD56C03B72584018532E3FD5939140A52DB9BE0444DE40441C833F9E13F3BFE29C2CC0646605C07E016EBE3A39863FDC4F47BC04B40240924E18405133153D7033BD3E68C04E40C0B7E2BFBDAFCCBFF300B73F34FD65C04B3E9640F3AD01411E8E7B3F0B358640FF8551C097A2CC3F81A008405CE78C3E52C649C0D942853F2B19D33FA71F70409401AB3F743A23C1841010C0C6F12FC0E46361C0A5CB2CC0B464E7BF787D2BC0EE17C440B1A0EC40DA5245BFC1E2B6407822E53E81BF0F3F7FBE813FFDAF4B404E742E406F9A8940F3A0ECC0D7DA294037D95DBFB6E9F03F56ECDD3FE52CFE3FC15E4A4051C652400D9F663E08295C401279B8BF86088440944D14C07F52B53F26BD20BF6BE74EC036210CC0E9C356C09A0D77404E32104075A11B3F5BE880BEB3D6FCBF3ACDA6BF3EC104C0E0AA71406AC7123EAACE00C08A81FA3F78D6A0BE43E8CDBF317EF03F958E3E406165A1BE48F3943F9902073FEF7C26C0B3EAD0BF05A003C09E6D79C0A08E08C00B014DC028F7AAC0B6D406BF3DCA39C046F8FCBE52C3524048CCB73F90393B40048716403C4E0240A16A1340105B4FBFD6FBE1BF02597E40ADD338BF842ECEBF76718EBF60C5A4BD7910CB3F7E9675C0D7EFE7BF1CB1C6BF1D7695BFA6C96CC05D90833F0C3C1FC02E051D408AE45C4062E436C0B60C22409335FCBF0A0EACBFB3615AC0DDE03B3F1E7BA4C0452D9140D520BBBFE4BBD240029306407DEBAB3EEDB8A1400436C3BD021748C000BFAE3F6C838AC053CD8E40A6FD9E403C655740469A3E40B2CBC7BE57A2BCBEC5A2973FEA6746408CA480BF786C274074FC374037D6383DBA0AA8BFE33D83C0A97AB2C012514E40F28EFE400FBC1DC039099B3FB4717FC0CBE4914088E78CBF3E8A0B40E62668BFB6B29040030F3BBF8A112EBCBC2CCDBF92795E40C3D7903F86DA933FCA7AA0BFD36BE0BFA8C493BF5EEF923F86CFA7BFB54324C08D96D9401F5AECC0370E63BF58079140AB7A9F40AAE717404C4A4C3EE076A2C0406BFDBF03985CC0CB9474C055D587BF3137C4BFEC293D3E3DDDB9BEEC9A4840B93DF1BF3EF8073FDDC2CB3F00C015C0A9A29BC0617583BF04AED540874911C0C5F43940301D91C083510ABF8917C23F6920B3C09625DCC0D52476400068EBC0EEF4DAC0F53C7DBE3E42CDC00238323F9A78DBBFDD23B7BFF008E2408853204095505B40FFD43B3F7256503E9C1B84BF7FA01B40D59A9F3FE3F9AE3C825356403613663F0B8BB7BFBD4AA03F81C6913FD434E33D432E04C0D5F19DBE771A89BF9AE6C5BD853B8AC0C1D68FC0BDB1684099BFC1BF689E323D58CD5DC02DBB87C0BAF596400A06AEBF25CAAF3FFF735AC08DBDC4C01D57E4BF73FF70C0EA96D2BE34D78C402B06A23F03F01E3FE918F8BE5D342E40E1F5B4BFBACC87C0F0833B40D090C13FFFDD2840408240BFDC25A33ED016A1BF9E4102C0AA4F1AC0C14C3E4041ACC6BEFDBA8BC023715740C9521E408DD937BF3BE451406E4ECF3FBB51C1BF2FD870402FBCAEBFDB5C793F28050840E79020C0AF4256400DBCA440249A3E405EE24240C891DC3F92D23B400BF00C41B5CA60C01015A4BFA961BD3F651602C06B268D4084149E4041D23C3FB878563FB3AC653F7CED2A3F6B0C3BBEA5FF00405AA031BFA19B2A408941C7BFFC49B9C0557486C0403551C03F6B72C04F62D03FE47590BFE272F03F863ED3BFA763B8BF41F386BF25F075406754D7C0E2342DC05944E63F0CE44CC06F05E83FBA6BAD3FE715694022F003C023FB2F3FF521B4BFB306433E20853B4062B503C07C8E4E3FC64686BF21958FC033ABC340BFFD05C0059EECBF"> : tensor<20x30xf32>
    return %0 : tensor<20x30xf32>
  }
  func.func private @expected() -> tensor<20x30xf32> {
    %0 = stablehlo.constant dense<"0x7894D5BE864993BF5CE39B3FF6C5EABE498ABE3EDDBE3B3EF859E2BEB4CF0EBEB5339B3E5E2F72BE6DCC193EE128BC3FCFD2043F6C8235BF3F04F93ECB6A3BBFD19F5E3E5BAD49BE9A04003FEC74073F5F4E87BEBF7E5BBED831343F79B5FEBF7D80C2BE664CD83E98A26B3FFB2DCABF7715E63EFCF03DBF3DE1C9BE81ED33BF090D373E8E1C55BF5E0ACD3E9851373FE731DB3EBA22473FBD6B6CBEEBEDD3BE8C9CFD3ED1A1B8BEC00E553E7DCBC6BE6BC9273F58A3C6BE3F2176BE88E104BF525936BF8AB20E3F2631F5BEBB8E5D3E961976BEF36A48BEE296443F9B379E3E2D06D2BE44F313BF09845DBF40A562406D5888BEB67E6440B34C2C3F852C39BEB6E718BF2BCCAFC0ECEE5E3EB40A6AC0B1DA363EE6CA843EECF0C9BEBF838B3F67C95F4001162BBE933C5FBF433AEF3ED6F56D3E6B1456C1CF1723BF7D5625BF78C333400DD0D83E49784CBE16CF013F5C5153BF663383BE72E628BF8C926B3E63D770BF3F37723E4EFB08BFBBC0A2BFEE8A9EBF887784BE6540253F967A3BBEE4123ABE9497B73EE41CD5BF1DF0BBBE48570ABEE41490BFC7FF733E28E522406ACA0CBF2449353FE120FFBE4A680D3F54A84EBE8A3876BFF867AABEB71F73BEE40F96BE541737BE8697793FE4690C3F2ED868BE6F2B8540AD54293FC240D2BE61297C3E38CE6BBEE80640BE5D7B7CBE421FB7BE9AE5293F488B1C40DC5A923E70472A3FF8A139C13D487A3E7F5694BEADD7CABF48B3B43EBCBF063F095B1ABF379F29C05BE5F8BE208716BEA029313E04E887BE1B871BBEF9558E3EE6BF2840ABAFA2BEDA2C4740ED26423F0AE485BF06AB963E870DBC3E9CC6C2BEA49FE2BEC5AE213FE8E2E63E70BDAE3EB63348BED03F143FC5612FBF7F7F08BFAE6062BE169EC4BE9B4B2E3E6EF7113FCEBE0E3FAD17B0BE100DC0BE6887733E21CEA7C037BC30BFD2956FBF76C9BC405DC266BFF276AEBF5958343E828CEE3FF09A053F37D6A6BE9417A43E88E1463F27B0853EE9F09B3F792DB1BFAB84E2BFB575033F9AD583BE4BDCEE3ECDDF92BEC4C1A6BEADCC1BBFBEFA7C403C4074BE39094FBFD9391D3F7C74383F8AA1013F29E2473F54FEADC12BF17DBE94486BBE6FC4BCBE53BE8CBF5ABAF13D1D85BEBE4B7C73BF0D889A3F47554FBE4AE51DBFF249104043A69FBE9060C53E4BF62A3FA32AEC3EA53580BF95E6E7BDDA6A5B3F86AEFCBE59838B3F3E7AAA3FF92B2BBF0AED343FBD4336BF5D71D0BF81E4F63ECA12E5BE17F891BFC1BD8DBEF123E8BE2B043D3F434252BFFD2AA23E426BAFBF0C873C40E60CAD3EBFEE6ABEAA34CB3E0DA7693EC3659F3E8D32A0BED447B63F0D0C783FC75E303E98FA0E400886A43F51D7533EB612D4BF44149FBEE9FD8DBE76B69BBE697791BFE96FBB3EC95BB43E2FE29FBF955B40C00583883E38CA92BEE6567CBED680B3BED755AC3FAC92453EE4247FBFC14A713FF1845ABF9F2A2D3E08EE473FC8273C3FF4E806BFD5D1513FFBD380BEF8D4BDBE23D0BEBFD13ABDBE44800C4063A398BE1664973EA0F8BB3FFC16613E2BF430C05B6D133E40ED793F23CE06BFD4D5BDBE23A3F5BE64AD89C04B21743FD567A4C298B4FA3E0025D73EBE9FDB4109312D405E7D9E3E398810BFB81620BF760E333FF1798EBE7B195A3E3DAFFC3DFF42823FE728743E9D649CBE0121203FE5D5EF3E508E68402266A2BEA7E4753FEC391B3F8976883E6B9E3F3FDDBFC8BD2374E3BE9A3DBABE286291BE74A2BDBE969C0DBFFD13BFBE9E1A273EA97A0A3EED0FA6BF062C333EF3010F4052F4E33F038F7C3FB9DFA03ED7D4BB3E47226E3E827A0ABEECEAC03E54B493BF1504083F9AA7133F3BEB003FCFEBA13EF0769B3EF4158E4047D6943E62A131BF092E783EF7F3DCBE89B7343FCEDBCBBF7C5F9EBE28D7E9BE6D9398BEACA2843ED63EE33EBB8CD23F90327EC0B69901BFEA7244BFB6D4F6BE5D97873E4C3FDF404365FEBEA7CE023FB6BB4BC0BD231FBFE440083F86F5AB3E50074BC029FE5B3F2BB5F23FA8D1C4BEDED81CBF14F3F8BE5B5F83BE4BF5EFBE3AD79FBE19AA3FBEC407F3BF065FB0BE828801C026799B3E5F48323FFE04AF3E1DB0D93E6B78FB3E2048DE3E28079EBF680011BFDFD4803E4E4AB1BF83ED1EBFE50A66BFB5DE46C1195E213F426D85BEA2470DBF30EB24BF973D5BBFB5628ABEB410793FD3C8CDBEBDAFD03EEF57943E6D2AB3BEAA35CA3E81EC01BF6F733EBF9B0C96BE2469AE3F7E3847BE00B6613E1F1C2FBFA17E1B3E6C7EF33EB5993E406D9E4A3E01DC27C133C4A3BE8D843B3FB9916CBEE976653E97194E3E2621983EFAEAAB3EEF0124C041B62DC0C118583F0828A53E8DB87EBF10B8C33EB219B23EDE47B141BDFF42BF39AD79BE7F9837BEE5D29E3E93B9003EC9BDCFBE7A5B533F4E4780BE139A603E088E68BF26D4EA3E21268DBF2D75623ECE2CAFBF6A3FBCC230B51FBFDE49933E403B623FE79F5D3F1A304CBFDC0212BFB3C05DBF98025F3F894443BFB17BC7BEB398163E02A40ABE2F5190BF07F1613E06784D3EBFB6D73E3666A04087B149BEBD4D01BF668B94BED7F985BEA03C71BFFFFF26BFBF39AD40FE4C30C08358A33EB7D407BFB0FEF03FD3D0203F6AD1DABE1A8B52BED44379BFDA59193E1A8AE1BEAF36B03E04CF61BE16E7ECBFC4D3283F9CEE36BE9BD814BE1A20853E9A320BBEB6A715BE616581C074A41FBE29DDB73FED4D15BF53EC32BF00F8103E1962CC3E2B69953E2974AE3F7B489D402E0A78BF088ED23E9E4E4D3F72453B4271E3983E506C8E3FBE8732BF4F6D4C3FBEC8603FA83810412EE7F7BE0F774FC08C006FBFF29325C1C60C6DBE79CF63BEE9D18C3E642029BFC173B7413CBC93BE1D6B71BE7710593EDB4B3CBF96673A3F0A0096BEF28D26BE4F810FBFD0F787BEEE991BC0FEA8683ED53D4A3F462BCE3FC41304C0C919BC3E071435BFEA4B71BE93BFAE3E4549293FC70BC23E3237AABF34D94840556A4BBFC790FBBEA259D4BE0231AC3E38EF24C03A826ABEBF18983E03F8CE3E813BB2BF661E9C3ECA101E3F838029BFFB0D883E93873BBF2F68833FCFE7F03EFB13CCBE73EF983EF7E9463E19EBAB3E0E24A83E988F143F6A76AE3EFC7FE83D3BC591BE67B447BFC3062D3F5DE4FBBE6C26683E8A494F3E2C8AAD3FEAC8983FE2AB8E3FF2B4BF3F3C2FAFC0AB04FE3E247AB8BFEC10C03EA77324BF1AD930BEFAB573BEF9A09CBEC42B87BE863F1D3F85D462BF4D47083F791E1BBF04B631BFC3D072BF9F3C853E0B2D18BE3C2FBDBEEC4D0E3FD9ED9FBE7C3A0D3F68F33C3F65958C3EEA5BF8BEB133BA3F0FE935BFBB04A84077BEAE3EB3CAF8BEACA39E3FAA0874BF993764BE7A77273EAA8DF4BE397C0ABF"> : tensor<20x30xf32>
    return %0 : tensor<20x30xf32>
  }
}
