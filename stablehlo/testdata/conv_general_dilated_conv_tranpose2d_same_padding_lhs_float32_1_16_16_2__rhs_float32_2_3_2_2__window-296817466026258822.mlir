// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<1x16x16x2xf32>, tensor<2x3x2x2xf32>)
    %1 = call @expected() : () -> tensor<1x32x32x2xf32>
    %2 = stablehlo.convolution(%0#0, %0#1) dim_numbers = [b, 0, 1, f]x[0, 1, i, o]->[b, 0, 1, f], window = {pad = [[1, 1], [2, 1]], lhs_dilate = [2, 2]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64} : (tensor<1x16x16x2xf32>, tensor<2x3x2x2xf32>) -> tensor<1x32x32x2xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<1x32x32x2xf32>, tensor<1x32x32x2xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x16x16x2xf32>, tensor<2x3x2x2xf32>) {
    %0 = stablehlo.constant dense<"0xD7DBADC05B621CC0B8F94F402647D8401FEADFBFAF81823E33EC27C1ABED8DBFEDE54EBE03446B3F45E084BFB81724C0AA483BC0FAD5B73E5002634085D17140E0E89F3FE0786D40B8EB08C079C0E23F84C78740045020BF626D11BEFA3B20C02536A4BFD6C800C184C0E8BFDAEDC4C0518251C035E999C03B96F4BF6AAB37405AFF323E814EB7C03CBFF83EF7D4EE3F4AEAC8BF834075BE769E9ABE1E7D633F909C10BE9193F9BEFD2F77BF6F2238BF754294401AAC433F3A5A44C0384A063F83181EC03EBD263FA2B726C0F93D853F7A0B593EAAFCB7BD6C18883F17641D3F5F4520C09A53363FFB5F78C04E9B85BE90EB2B40BFAE453F7DD40EC02773AFBFDD67F13BC6854540FBA5D6BFF402F8BE4190D93E7BDC88C01CC79340EF9E0540B85024C08960EF3F510073BFF80381409A5066404037E13D09A77A3F9483A5C05A8A283F669D0E40A539E5BF41487A40E5EAEF4099F5B7C02581A33D47860EC0E459D63F7474A3BF78ACC6BF42263E4077DE80BECD8277C0FDCFBEC0D8A772BFE3578CC02E93B13FD79B4840E168A13F76E3A1C0D2C971C04E456740150BDE3FA37A00C0341594BF9C6C90405C63B0BF76C61E407EA19BBF65D25FC0D048073FCADFD24095F6E53FEDB1A53C8752D23DDCE20D40CDD2893FBE86F2BE37B54CC06D9384C07C079EC01AF0F2BD715001C15EE391BF7A0355BF2514CC3E239E8A40B7A6A93F7865F43FAD3D31401D6A38401E85D6BEFC5B983F293D123F001A8CC0F24747BFB2D346C0FDA2DF3FC05EF5BFFFDEE53F473640C0271F4FBF3F4A8F39136D14BF79AF66BFD8A8C83F7E3A87406614A83F1CC8044030F63FBEF2C6DD3FE07CF13D64E3E6BFCC1878406564C7BFB03F0FBFEF121A3F68BEB93FBA2CD03FD750773F578BBFBEC81ECFBFAC0026C06D4B993E5D6DA0BC275882C0168052C09ED85540D704DFBD080B08401411D4BE1C948F40A89E7940F03F9340336B8C3F67E349408D76ED3FBA041CC0D70FEE3F14CBEC3F436194C039C1D4BF76E53940F24560404B285E3FED17F1BF165565BFF88196C08E92AFBFF0545C3F9C47844066AFA140F7CD29408EFC4840D1303E4028C913405FFB47C064C498BF1223EBBFC638A9401ABCCCBF75506C3E1C4A9BBF3EDDD93EE2A504C111D586BF354D9ABF4A1DB83FACB8E03DDB3BFD3F6C7AB93FC731BF3E2FBC22C019B549BFC0EA8B3FED2AA6C0183160BFDCC4A9C091CEF53F97285D3EDD49C7C00CAA17C0475B7F40815EE03E38B463C099C6AF3F8F7903409AC0C3BF0A78C2C09D45314037A3093F52EB5EBF8C4D74C00197233DB1AE08C0CC2B94BF601C7E40F80E46BF2F3E2FC034FCBF40587619407F3E54BF41E5ED3FA6ED59BF6EB84ABF4D9915C046FF1D4047BD993FFCA2CCBF56D19E3F36D3A8C0799F01417E1E82C066F003413BDA4140C074673FB63EBF3F258FB3BFBED69D4015619A40BE358D3F3ADA34C0DEAAA740FA72E93FA468424075631C40F674D33EDDE44040C8862540BCB5563ECDEDCBBF2E35A4BFCD8C59C0779B0BC00DDAEC3F90EC4DBDD80F683FA39B514089E189C009CA904018BC92BFC3F5803EE0F248C037A23540AF9021C0DC1531C0751E9ABFA84A7E407CC209C0B54F35BF8D0108C0AB240FC0D7C511C01E97DD3E3A1FB640752B3A3FCF561540286909C0EBCA2FBF94C91040DEC172C00D1304C08BC488C0159EDCBF7606C1BF5DE3493E76EB04C0FC99EC3F8A27C5BF77E8883E33C54BC0D8D9B1401112B8BE835A9FC07AEED8BFCE0B5340ED1EADBE2F7A8BC027B587BFAD53F8BFB3EBB13B71EA0BC0688992BFAB466FC0A9C209BF3F1D1140374A6D3F55C5BAC015A989C094184D40D37025C0B3A0A83F37D4F63EB7EF993F9DB7BB3FDE0E8ABF425AA0C0A8DC8ABE6E6702C0A46A89C0AFFF17406B01D93E1AAC41C058173D3E075D4040D8D6804061478B3DA0E553406EB9743CB61AC03FD4CE0140A78F38C0B339B0BEDE5959BE4B750DBF906619C09E74A7BDAA52F3BFC5572FC02856D540289282C071E39D3F89EE813F057A5740DBE2A43F8B9EC33FE41886C021B57A40C65AE1BF6E481D400F342640D2229B3EFD5EEB3EAFA4053FC76698BF9DE619BFFDCCFF3F87E7D1BEF1D5B7BF33B71B401D578440A52B2C3FB9D09EC002F5C4BFE92988406C9FFE3F52019FBF8D5B99C0002175C0A5D29B40640643C0D504373F9574B6BFB73797BF2E12E5BFF8BD0BBF971EAE3F502449C05D863BC0A84D33400569A03F14619E4082BE204000D6CDBE8BD87540C46A23C00998803FC22A0EC0C5B3443F9EA93E40B728803F06B01C41E830843FBCB083C0B69AB1BE374C133F5DB00D3F8DC277C09502D63F13D4DEBD90157C40C316D540A2EB3BC0D73F073E7EC4743F94A71340EA5E85C0E54D88C08EE2C0BFCA0C69408757B73F6C9DAF4089AD803F05CC44C0B45B56BF29E50040E1031F400E4F5AC0FB7324BF0CC6D93DA6AAE53FBA580D3DAABF74BF08C249C06B088940F25766403C897ABF26724EC0A22491BF02D11A4047CAF4BEB58885408A91DDBFF6C69A3FEDE913C05BF286BFC227A13DADB7934063942C40DE8F2FC07D8D6C407DF38BC04C68BDC0113DC33FB2CE0BC0548F61C0649C473FD7658C3F0E95C2BE084A08406C2591C0177E9B40FA63EABF5060CF405D679C3F12D9F0BF3BD3DBBFFBBC774042117DC074EAB93F5B8EAA40CF442B4003813CC0D567A040B82A993E19BAE53F932A5EC0FBB893BF429DC5BFC2A0E6BF31C7664034020C41CE128BC043DEB4BF98505E3F24871AC0D17983BE3CC4EA3FCE6E26C0B1C06DC01FCC603F5C6986BE706EB6BF9956593DF96095403D258340618FAB3FA5E70D3F0DD84A402B18F43F0DA82140"> : tensor<1x16x16x2xf32>
    %1 = stablehlo.constant dense<[[[[-5.40160084, -0.489201427], [2.09286475, -2.59588647]], [[3.2384696, 2.775050e+00], [2.15702796, 3.12790585]], [[-5.50670385, -1.00909209], [-1.09383368, 1.02197862]]], [[[-2.18184781, 1.15243089], [1.82309341, -0.24316524]], [[-0.476841807, -0.97529751], [-1.74165547, -0.371816605]], [[-1.94535339, -3.01535559], [2.1693244, 4.38509798]]]]> : tensor<2x3x2x2xf32>
    return %0, %1 : tensor<1x16x16x2xf32>, tensor<2x3x2x2xf32>
  }
  func.func private @expected() -> tensor<1x32x32x2xf32> {
    %0 = stablehlo.constant dense<"0xB997A840AE5DB5403A16DB401BA3C6403ED57B4126BF6241382255C1AFD5B5C046001341C3E707412ECAC73E8D40CE3FDD57B241C2A6C54153F1DD40F85E2A41CC1CBA41E7F4E5C02D8BC0BF911D14BEFA90B6BFAC1B09C195BC9E40529EFB3F09FE814030351D413421453F021D2E40425F05410C771A405B5A04C120A89BC00A969840A3C37A413ADCE1C09E4626C0C3B24041501B6C41182C04C053C4B63FE691DBBF837E93C1C2C06EBFE5F279C001DF78C1CE44B0C019B48D4088E2883F2AC299C1A7DBF7C10B166A41A5CE87408680ADC19431A8C1545D3941DDF881409C1435C15F1B3DC16F011F41BB649F4061110541BFE47B418AC982C09CEC4B3F5F5D0242C30E3F40B9ECB6C1D5C2B5C138ED86BF61104A41D5D1C8415C44F141A646BE40BEDE88C1E3B0A3C08AD481C084FA89428A6C1A41248511C21C5F02C2F1E85942C07D1241B0FBA93F72161440729238410C0377C00A470EC1A7682EC140687F4112BC2741863C0BC115ECDFC0766DE3C0541C483FAC189D41184BAD412B85B1C1B53110C196CA4041D52A71412CC52D4104C4C8C0D5DB46C080A9CABE6557EDC0399407C10A3F46419D0E1D4115ADA5C18D6437C05088BBC0EE9A03C1B8563641DCB0B9BE0E22ACC1D4E4E5C1A286DA406B8A8841304E99C1D25CC2C186D7A141D20A744104CFA7C18E07C1C1FCFE6F419695974100300C3B7E216B4042444CC1CF2BCDC17D4B1E41C9CDFA3F861BF7C0BBFB0441DCCE5EC0C77395BFFD049C40A27E7240A432953FC659CF3F061BB04039A04340DAABB3BF08F312BD7484BF3FC7A611C0C9936A3FFA50A33EE86686BE98D192BEBB48DB3FD6C59A3F63E7D1C0E2E738C1569762C005B199C038F2CDBFA4A3854125A10C3FEE04334034E65D41C187D440604F323DF8B00A401B725E4158A11641E82112BF03D409404E2CDF40323989C050E6623D847A31BE5032AEBF50CF79BED6F4C9BF69FEA1BF08F7A64066003C41E0AB3DBD275D0B40F9EE5B419CF5EF40CC851340F7727840D41D8E4009F711C16E0D28C0790C3AC03E7445C0181C6840D6E45C405AEB2B404DB4A940E2FAC0C02EA43CC1F8758BC16F318DC1199C8141A523B3405DE7E54026FB2241CE7E6FC03832B3C02E5CA3C07EB10A41468F2640CC55703F4883F83FEEA89940EAF020C03820C1BF7053F5BF0417BB400E70C93F28B695C036BD9DC0891CB5C14EFCC6BF2739854178F773413A62E3C098611EBFBCDD0CC12AF0DBC0DA7BF4412A0A53405809D3C0322B9AC0D84CDF4136734D404E1AC6C0B8437EC0BAE37241D1E4DDBFF33AFC3E1A489D3E6E88FBC05651A1BE4F9F9840B6F49B404EDF0841BCC2913F1E5BD2C0AA1797C0C7B1124233A541403E1852C1745F39C1F8F298409387273F0AD72541E4EA1D412810653F18EB1DC0A7F122C15EB027C160C9D540FA2E5841DB1EACC0D4CD93BF634DFA4060300C404A57D23F5366E83F8B86EAC05FCEAEC195E1E7407A80963FDEDC52C12C5D4FC0CDD3BAC0F0F7A8C0680A3240C60DA641921A02C01D82E73FBED49C41B00689416737D2C02AC312BFBE2F2A40E91747C1BB29F4BF0A3E63C01436A6C1981AACC100AA0841B3DD773F973300C160C22241253D86C0DE3DBCBF487E6941A31FB6416EA0BEC038C7953E522780C1D2524BC2BAFDCD408497A5C09499FEC10042033DCCCA7540EC09403F5E3124C1A34020C17478B63FE84794BF50E75E40DC979F4148E78DC04875D13ED436673F19B095C14A61DB40907AD73FE4B44240BD956741AFD08F407860C54039A75AC05763494057CBD540FCC81A4121788141062EDAC0F237CFC05866C5C0611F2641AE332EC0822DFBC0692D43C158D71BC20EE40541E4AB9B4150C49A4101BA07C181524BC0B3FA88C0A437A3BF27CB94416761BD3FC8EBB340BDA01F418EE6CBC03E5458C11F433E418F492541258A97C1801E05C14E8DFFC0FC6157C19C69B1C1C8F86841EA09DE40D2C00C419C1FD64000189BBE48B22840DE66E840071F89C1D5BAB5C182143E4150C03440EC214AC2AE610E41F27091C0E3CFD7C002AB4EC1DECD2F40E2CB2A408C20273FFC77CDC09025E340A4EAB03F6A8D9F403EBFA141366D2AC18A8312C12AB94CC16E1BD9413E5F734180D7AAC1EF189CC12FA93841C6769A41385AA6BE85BD70409EC60B417C0415C1FA376CC01EA961C0CF3839C06033FF3F28E00F4106D7CA40CC45623FF73603C10CD297C0316B85C09BE054C00921974004383E40CBD5184062F917C1F278ADC1E0E57D3ED4EB78C018969EC18CD5E8C096446F3F0ED7FBBF6CF2A33E8C238041A74A3F3FB8B74D40801AA8BEBA3581C1CCAEC8C0850AE3C00AB52EC1467FF140E60741BE24346DBDDABCEABF9C84FBBF80AD3BC0F60024C0D7420EC1A0DF24C1437EB940855CD33F3670EEC017E50EC1A03929410F0FBC4067208AC1B7A01AC2382062419EBA47402E0461C1F3EBCE3F4F10FF3FA6E2B53FB77619416E758541A381F7C0BCEBFFBF4211B54120FDBA40985E33C1AC99FAC0D980FE40BC1F55C0DEEF4D41BB484A41ED968D41380564C0C442C4C13CD9CEC1381818C0AE882641291C774165437741D06464C0F7ADADC03CF20FC1580813C161C66EC19C1AFDBF2A4C3A41346D03418A601EC29C1B18C05C2BAD40BE35454047072F40C65FC040C8F822C1F7D400C1E90D92C120308FC0CFBAC941C740BF41B03C00C2B4B1F9C088F4923E9534C13E277C54C1C1E3B4BFDE08184199521841485567C0F074D5C031EF06C1D41B35C1FBA4C041AA64F540DA8DC0C1238DD7C1014CAC419599D640598A8EC1F4DFCCC1FA6611C167B4AA41528CAFC05E7FB8C0772921C069C1D74084272A41477D6A41B624C83F2B098C4089467DC0602A00C0E8EBB93FE322AB40E8D9CAC0566E71C04AEA2640EA940F41CEC8EFBF50060BBDC7CAF0C0568CADC1C44AEB401D0E893F684067C16CD818C1AF05B9409008F53FC85C38C1610E5DC1FF5A20405CC27DBF51868AC1D2D780C104FB8B40D08322BF2A36FAC02DB4A740EC48C53EB0FA493F5E58703FCEAE48C07146EC3F4288663F20ADB74088AD554198B801C16A6946C0985CC740A25ABD40B5AA87C0935503C0544DA140C6BF1241A1683BC0583BECBEE31D13BFE9710EC12577454080410E3FC27567C146908FC146555D3F4BE64CC0A8750EC143C31241680948BF88D8A43E7C7D41401482FB3FCC9161C0754701C08A3116C1F6251D3F90920641A9671A41D285ACC10E8CAEC0B3F17241E0958541418CFDC0A541E6C0D5F69A3FAEDE23408EB9CC40DCF1FDC01301F3C09CBF41C1260A92C046240B41DE8D13C19A0A3EC1FA231DC1D624974068F8C23F48E492BFBD6DA0C1C29142BFD89029BF77228DC0517F38C16480F740CEA627C077A30FC0AEC90841009A723D2B9174C078AE8DC0722540C19382AB40151363414A8C8C41DAFB11C1B4102FC1C0A40B41C62222412E4867C0DE2E82C0FA5548400CC79C40FBCCBE406BCACBC0BE9360C00714AAC08C70C0C1D00161BF0B1A13411452BC404836AEC1EAEE5440A49003BF08D0A83E879BAFC07A9F8BBF0E5203412CD3114128382CC0E3B691C07E7C433EC7984DBF269AA8C0B64BA9C02740A94076B92240D65CE9BF6C410EC07489DEBDA0C791BE80A3CC3D5037E5BF9276F5401E42A640981A76C0DC2767C14AAAB3BFE9F84DC0545C48C142298BC0029F95BE0BA7F5BF5922B5C0EAF9C34087EB0EC12D70BAC04F0314C13CF59AC0E85A83C032AA9CC0D36E22C1CA336A40748797C02A0C71C035D9A8408A8695412EEA04C040D0D73FDE569EC05C62E9C1D032E640F036A4BD22223DC07011A841668588C062850A3FA4327F40E72016C15AAC4BC032626FC0ECF88AC05F84B24012561D40E6E20A40AC680A414FDEC6400E379440271CA34026DF70412F1E2741C584F3C0011718C05A249DC082B8ADBFDA951440AB5FC13F7AE2B740AAF804BFB65C2DC102A849C1C4A4D73F027CE640F4676D3FD304453F20F5C241103F273F3449A2C12EBBACC16F604AC09286E1401460294199E80E413A3BECC1A9E47AC033B2BF402E4E9340924A25C2689B01BF5C8CB7413235C5414E732AC2C2787DC17B258A417E9B814111D727C29D5ACCC0A67A634165E86841C52AE2BF84C9FFBF0C8278C0D89072BFBB1F3F41FEDA23C1035980C08AEB15C1468A5BC1C1707C4140EF613FC0218F40E60BA6C0000516C186865341D7054741C655B8C0CED63EC0968300C1C47600C17FCC0E4251EBD240F88591C16FBD8AC1F86154418F7B1341FB423B41FF177541AC5A82C0807766C000F8E0C05B42BDC09E30BBC023D50B41EF8AD5C06E5E85C0E7464BC122268EC122EA8A40968E8BBFE85E46C1809184BFCB2F7140D86BEC3F0C0968C16C1BBFC1C83C873EB80292C03F478CC19046EF3E07300040DD6F673E0B39ACC19D4E14C2D7C76341FBB82A4086DE84C12001CB3E568426409EDFBC3F35691DC082DC98C0A38260BFDDC9B8BF7C2F69C0CC41014054E55DC099F81DC02F5AFDC0B59325C12204884072CB143F2EEEC5BF637C03418F98C3BF0A5BB93E3E9F3E415A4D2A41360B8040937BAC4006C2C141042D9541289950BFFCB98E4058B4923F8A2A0AC2F0E52B4174B706406061B83FE83DD3412E36BAC046E3533F28CEF5C118C618C0F0AFB0410B90B241652229C280DB17C156A48441AE1490417A55A0C1C2626CC1B8EE3C3F666957C0EFE526C125E1C940727BFAC088ED10C14C26C6C13427CFBFB6CE5A4124C01A41F3D8FEC1C02DBD3D3C4DEFBF03E149C0AB223C4089B3BBC0DD0984C13202C6C1687B48C1EE26A941EC5EC0C0A933D6C050F69BC098891340DAA29C40F0B68A40BE27A0C18B82C0BF7F851841A25C2041F0B8DDC00C8EF6C040D088C06259DDC0D44186C06E480541507446BEEAC59D3FDD6210429648F23FF5A495C1EA3189C142525542611342418A9E50C17B730BC1143219427B8E0FC19FBE4BC1510B97C1407DB0C0273DB441D09A6E3F7EEDBC40802109C1596287C1AA9ABF40403E653F2C0AB5C0979AC7403D7287C0F39906C0525917C1B2A2A7C14B0435416A127040BF6E3FC132EFC8C0C07510C0D5AF39C0D8663AC185D430C16D08E240643011408A511CC115F918C1B4D56C40B34F413F094EDC4013BCAB418C9FCBC048D1B1BEB689AA40A4943FC16569A44040E6E23FF55F1CC192A7F9C08E2FE1C0C7C5D7C0E4BA44C0E6D8874143DD35C0D0C0F03DAB55A4400C0714C0457EE43FBBF58F3FCA0F2541D5AE884177D74BC09650AE3FF4F172405FD25EC1718C0D4068B513BF8C269BC170D3C8C1198D0941F662403F44A013C2D42F1EC2BD014E401F76CCC0A23D0AC2F001A1BFF35113C101B312C1C641BD3F3F8182C02C2BC8C00F9A1EC19EFA9CC144C31B41E60D0E4196C8234142353F418FC02AC1667D90C18205BAC11B64A2C14C736441F413224156E415413CB69BC07EBDB8C0A4DC30C1CEB365C14CA995BF83CB014163468FC0DA37D2C044DA29C00E012C41A8199A40994F13412C8BAE41E8213CC1BF9606C120632BC132D914C2CE817840F6CFC441AE31C1417BD9C6C14E8DCDC06679A93F76CF604089C05E4123D18BC0E4E08EC046DB9AC0A7CC51411452EB40BEAA0FC0B01C9E3F12D74E410CC601C1A0E4E13E2473D5BF92532EC1353345C02994EBC08CF150C1D3A167C250F6413FEAB88B41C1351C418CFCC9C2C0EBAE3F48F404426F6E01428FBDBD3F59D57440262242C031FAB7BF77E26241AB4DD441DC7EFDC0CC7FEEBE41F5A1408B6848C1671987C015B1A3C0F89405417027134261E6F8C0B6CE4E3F58139641D89252404920C5C026203AC0182413C0403586C06737F1BF6C5A22C0D6989AC0B2009F409022BEC0AEAC79C07E32B7C053C598C023302B40F797C63EA8D803C1628926C11B06D140E3F62040C4819B409AA36041BEAF0BC07940B83F7C27234178D7943F7304C7BFDA7693BE384C5FC13E63E8C1912ABE4061CBCBBF0052D2C198925DC1A0D624BE58257FC0501B9AC1968E10C1FD25AB4023FA6B3F282B8AC14E9794C1C5C742400226EABF336100C1AB55DE401EA75A40E95C4940179ED3C007561D3F5BD3C4403AD6E54010A1123FEFAD0840AD16C3401A9138413CF61DC1EEBC7DC1750690414EB5864112BB5EC1D4DF3E4040A409405FC108413CD24D41D4472FC1A9564741900069413A378BC1FC232DC15ADE0C41702A01415616FEC1809A2AC0806E754156A18341137824C1217320C1627B30C010D98CC0C419CA40D948ED3FC0C937C15F1463C15ADB1C4192B3584180AA44C0F0EF87BE820D6F41309630C02971E53FBD892C40027432C14E9720C120F7A73F48718CC08D7B49C27A1D764044E24241EF860F415A56C6C137D72CC0BB9FBEC027F411C18263A6C1595A2540EAB66F4000BAA8BC56E681C0F13ED74021ED38C1291D37C1166246C1D25BABC19C58ED3FE5C944C092357DC11C2B05C0B53E81400C8EBD3F54D13AC0FCC362C04412A140D8CE4140ADB54341A806AD411BE621C14E7222C08B425141E0EFE44034258DC0C6D6C9BFB857AB40BEF26E40D6100E40665B1640072613C1A218CEC122E1B04066CC4BBFBBDD88C1D3D50FC186D8064152846640C84A4DC01C4A30C00AB15C4006780F40CC2A78C0662435C1D07B61403C76143FAA7532C11D8839C1BB8DE63F99739DBF964A64C1893644C15E5EAD40354C6C3FC0D68FC122068AC1448A01C0192EA9C0C4AAD8C08A3961410271AA40F294AF407C7E203FF20586C1B8C87BBF5FC945C085E8D0BF1B054641F6317B407DA59440EC339CC111B2C6C04E970341E36289409FF09DC112F40B40B214DCC0E0CC09C18EF962417059B940118042C15E4C55C1B8A9A5BF012F4641B5D85A41F60598414A0C41408D5B55C16C6DEC40AE1115414C79584150589EC012F306C166B201C18FFDEC3FFFE354C080FA5ABFCCC3B2C08ED283C0B388CE40886F7EC167C398C19A7C5541C7D644415E5A0DC1A9FF17C1DBE1EA40D4EC1B4040D975C05A5FBEC07C7D5EC1DE80ED3FC37A2A40109A9F3EE82A33C106F7DBBEF00EC0C08B7813C1B34719C264240A4093C98941C0C764418EB0BFBF76F2C03FC9429EC15DF698C16B03B24069654A4071321F416C7E01413C88D440AE132540F33783C19B9676C1AC4B7240DAF5BB4083676A3F25EFF13F1A64C04000452ABF72534240B1B32340BC9D0C41AF86D54061142E40B52B764074D59840C367DEC00F842CC02E9623C0081D9EBFA0B88F3F9C6824417157E940DB66DEC0326ED5C1A8573E401A840AC0388C53C1F5A51D40AAE1BBBFEE67BBBFC0A993BFFD938640C82B48C01FEEDBBFD68F0BC191898DC153DE13413E913A40EBCB2AC1F04302C152656B40A8D4823FFD202641915EBC4175AD05C04687534028ECC9401598A0C11730A2404438363F88AB8FBE11905D414555AAC0AF19A6BF44EC26C003C445C1CE7302C076EE7CC0F11A71C1616DA9C09D69CDBF9D044FC00BECB6C067E30241F1F087C0B6F10DC079D62A41824BFB3FCAACC8C084BCABC0DC40BE41CD4BFC3FEBC918C1CA5C1AC11FB7F441EE72E8404B4B54C19EEE40C1DE33B240834CF13F227A1541481013412F4ED441306B01C08172E1C1CC38EDC19B89F640B159024121AB9940C0AC4E3F3A04F4C1ACCA8940CDCCA940C03DA5404E5765C1C12BCEBF80DBE140F495FD401FCDFF405ED906C161D464C13A5695C1586770BFD6A13B41B3BFA8C0B207E4C02800924152EB4241168B0CC1719E8FC0F623E94145B6F2C094F4A4C0DDA004C113D64EC167892841619AE240679F1E41ED9E87C1532D3EC1D3F75241D22B3641AA6A1FC2D319AFC02C122C41F2C013410BB0E2C116D08CBFEEC31341E62428410DA09B40FCF5E54072BEFC3F46313C40FD1D9C40EDB9A0C01624883F182FD33E923B7C40FE46D8401786A43F958E1740A2743540786310C137B3B540FCD937400858B5C15D141EC2125D7B40A6849FC04075B1C11F831641C7CA16C08B4CCABFA41193C0940955C0F05576C0BACE70C0267D88C1E4569BC1373BD240B06B8A3DED4FB3C1720486C1F664993F809E4AC053762EC115B80E41EA3BB6C0DF3157C0E00161BE7A6253408FF471BF92D1EEBEF2F85AC08AD9D1C04791E93FE81688BDA37C0C40ED7937416B694CC0C47D20BE96C3284043B2C7C0C3992C40E3106F3FBFED204076CE2A41FBCE05C11D487AC0327F1DC147F1AFC16E2B0541F23D983F660D824114BA2340814D21C1614411C1FC0985419E12FA3FDB8CF0BF815014C0827454412EE577401609FEC00708DDC003EDD141C8CB003FD80D41C1A4845DC101B7DDC12ABF36C0909E4C41269BB74096D051C2D9F2E34056E5C5400324D34093E6C3C1E238AAC061E95A414AF5554102949AC1960D2DC1EADF82C076DD0DC120AF12C2431B8C4016370E4118A4AB4032DF24C28AFE34401FF7584188156F41382D20C1B6F1F8C0BC86FC3F52D7114032CE0FC0887345C034AB60BFCCA111C06EFD85C00A80AF40AC48174014A592402C223441BC53BEC0C99E8DC04129B4C07FB495C1BE67B6408566864177809D41C8C230C0B0698DC1BE6F08C1B1845AC1E59543412A64BA41C2ABD5C040B8A6BD029B9140760E64C176849B3F5136BDBF97E7B2C080DB7F3ED34B0F410C24C3404BC149C1998C02C2840F3F40086F67C08F4DA5C18F6F03C0C811094094452BBE3BC3B7C0725947C0EC886B4093A7E83F13FB5440AFE9D54028F806C0C0E3D93C886E5B409E9D8AC01E42D340F2F28440EDA99BBF4C94BBC0633061C019B24CC07D1F00C1D0837CBF9880D7C0BD59B8C0304E39401733B94178F4CFC09FA184BF406E7041AF512B41763C08BF3C790740DA4056415A2EDC4074D88EBEE0BDF03F0FF12740A3DBEAC034854AC050C751C059E1ABC1AF7CAEC1FBFCCEC0FCF51EC119B143C19461AF41B44124408690844044697440E6D7BC40C23F864007A2104131E4F340581E59C102CE7040D83CD13F80E1894110164B403641BEC17C3CCAC1BC8AB3C0784A88402A25134104D07E40753B0CC2D4665640F86B42BF4A611EC0DB1FCF3F4AAD2D40E2F4F5C0C5040EC10EED84408A44E5402D4E953FED5D2F402C75D2411C9545C06BFC83C1A4178FC1F389BEC0FD1CF340156B3C41CA1C3B419F0C2AC2DCA3E1C05A91AB4105BAAC4121BABBC1848293C0737CDF4041652E41FA61B9417C7EC5C0F243C3C02D607CC0874BDA412B81D53F4F2AB1C03FB470C0D82A79C0980339C048EB3C411A623641321B8AC209214EC183C407422240F341748FDDC1C1186BC09D3561C1801548C1C095A63D2E2A313F68819EBF655744BFE4952E415B449C417D7288BF7ADA4940B601A2415CB74B419ADCD9C01EE0ADBF7C7D3EC1342708C28225F83F9DE3ACC0D48490C17EEB42414236DDBFB2F8F7BE8A3141C1D281CAC1FB14C540205033BFC2ACF3C010881E41FAFA9440DFDD96405877244005DD13C1C26487C05DB082C022435DC1BAAA04C1C8C48BC0EA3CB7C04E39BFC097E23A41F12C3B406FDC53400EF2D440B0BCBD3FC434A9C0EAD538C0B615AC409AF7124133B42F40DF3364400A4F1F412A727140C33E4BC0435645BF89E3653FA68693C01707D33F79C5A43E34AA59413B73E4418E8FBEC05FBEBD3F94F0B140238C9EC1802340BC785D49C0FA8671C0005F75BC5AA94340AEFC544095508C412067794037E30EC11B6CB0C0599BA5417C2AD83FEE4C0241024B4041E002C5C186229FC11EB4734183B71441128D2FC28CABA640205E1F4036DC5640E374DBC05B2512C15063C2BFF64BD4C06AD77A40432E4741A35B88C14A4584C154DBE1BF2C3B7240921D6E41A85D6941BAF73FC2582920C14D879F41A6FD9241BC0E1BC1150543C0913A3CC1A46F32C15047863F14EA8540151B3E41CCC455412AEC5C4136C894C0CFEA46C1A49A37C1AB8568419001A24070DE86405D09BD40292B81408E17B7C009A9F9BF474239C02CD02741EB5B2041B0E078BF88AE9440EABCE740464C63C1DCB6184198A6DD40D32D74402023984030D6604058546440ACB045BF78514DC1583EA4BE6D9D0BC00C2E90C1F8278AC19632833F83475BC0FA029DC145D008C175B65C4044D7A3BEC52994C0A258AF404239BB3E80BC7F3F08C92FBFBC0B55C09AB9DCC00927B0C05B2E03412126E9419523A4C0B98AA63FCE4206415A9F86C1FA4E464137EBCE408C460FC1243C8EC187F2444085E62CBF625A9E3FF4AE8241EC24A53EEF6E4940FEE4C440309A13C1C8350E3E51AF6DBF008C88C16CA3C7C1EA4CDC4058E5C7BEB0B9D2C1B2FF98C1DC4A5F3F2ADD81C0FF2BBFC1423402C16CFCA6C0B9CAD8C0ADA13FC1F70CAA405EDA784007511E40B22372C18619F6C1EA4FA140178613C0F706984106280640E3464EC141F947C19432104086C5CB3FD6AED940E6F4A6407E9C0CC2AB82BDC0537B1C415B4DC5400F5AF2C1B6A590BFF6DD88BF33E777C0F5C4B4C0D2ABD140BAA54FC04D7D2BC08E14B4C182A0CBBF8520A6411CF5A94184A703C1469D2DC0983469BFA6B87C4067715442D2371EC13672D7C17A34F5C1263DA740B8B95B41E018693EF26726C0CCCDB740D8711441F2B41BC1AAECEAC055B77041C4C8E5BF42DF2E40C373ED3F0FC457C19AB3CAC0E6CC38C0107304C1870037C23A4F7D40A0943C413036F840663486C2F2823AC019FBBC412472AE4178A9A1C1E55AC6C0B9C41CC1A27E29C143BD26C1576324C0A8358040982BD0BF67C90B414AF09741459B1FC1277E59C0CA85A1C0A3DBA4C10CA47640F4E5C1BFCF7CA2C12E0C20C159523AC0A700A0C0A34EABC129E16EC12E15A640185EEBBE649335C13053C1BEE34E4F40BC8CD93F9E7E30415153A2418679ADC03844D53ECE217FC19C9641C266635940E963DDC01A10B3C143AE99416DB456BFF511873F4AE60C41F4138A40FC9DCC3F3FD21C401C1A8DC09E3B9DC139E569408C6752BF0024C73E0D638E4148D9773ED9FB5240AA00E440263F1FC1C1E026402A35493FFFEDFF401AD5A241F07C02C146CAE4BF0017554080BDF1C03B3C89C063DA8FC0407E33BFC7FD8441B419B9C08E0ADCBF7FD4CA402236A6409FDFA9C08E2333C0C0405DC164CE7E408E9A8141BF9DA541E34903C1F80DA2C15A0A1440B8AFE4BF183342C2F0C6CA3F88078741D4896D41492502C2526609C16079D6BFEB14BCC064A60EC1640AF740E629E2C0CE8100C1C3AF0F41A03521413CB5F83FCFECC8408E3AD1C18D01AEC1E2B59741CC062B411A2046C2FC071541B8FB2CC0783A9ABF2737B84120681C3F8CF805C1341DF0C098FAA740B5482AC09022A93E80D742C0E6B08440CCFD2741CE2E22C1A4FEF1C01145C74158B0D3BF702A7BC030F8A5C0C4D1DEC0BAB9084144DB234135FA6B4162D168C1998D6EC1704E8141AB0B7941FCCFCEC1247C33C0701B0A41333B37416A001AC160EEFAC064FC394154155341"> : tensor<1x32x32x2xf32>
    return %0 : tensor<1x32x32x2xf32>
  }
}

