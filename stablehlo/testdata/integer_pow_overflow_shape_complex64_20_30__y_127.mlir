// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x30xcomplex<f32>>
    %1 = call @expected() : () -> tensor<20x30xcomplex<f32>>
    %2 = call @integer_pow(%0) : (tensor<20x30xcomplex<f32>>) -> tensor<20x30xcomplex<f32>>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x30xcomplex<f32>>, tensor<20x30xcomplex<f32>>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x2D277540663A54C0F7EE923F227B12C0CAF389BF161FDDBFF95593C0786B41401CEB2240C0273EC0C29898BF488EA640BD617CBF14E2FCBC9C409E402C406840784D34403614D2C0D1D9A0C04D878340FD54AF3FEA5D8DC0F16328C06180BD3F5A22A04099E92BC0834C30C009181D408FEF3140D8D5B2C03A4F3AC02F6C7740DF93DB3F948D99401886763FEF1A14403F66034073263840589212C04E2758BEC9BC81408292C33F7FBDDE3D5CBB13403DFDA4401C6BCCBFEDEF6C40D1AA933B72749AC0A2B2FABF84DD80C0C1A2B53F7B0B393E557A98409F74274020B298C040256FC0B1CF083F2736103F350B5DC010241EC0AA8723BF6252FC3FFC3027C0EDBAEF3FFA9FD1BF97E890BF031304BF2CB63BC0D3F4F83E020D5DBF0607B9BF5936E1C0314FDF3EBA5A1E408B7882401397D13E527B01BF0E6687BF31D70E3FA6AD80409E1D9BBF45B31C3E028DA9C0DE69D93FD04DD0BF825FF2BF50E63C408BEBE2401F0E0AC0C2F214BB9AF767C0F25530BFB20C34BEC0401A4090A05B40CBFA03C062BC5C3FD96CCCBFA3860DC0A21205BF2D81943F43764EC0826EFF3F04D480BEB52C85C0F68D5940CADAC53FFF13E5BE536AB03E397A513FFB12D93F5764733F5E3B10404E5B53C06CBF943E68A3AC3FC4D32AC0D32925BEBB800FC0BD3B603F6D426CC0F0CCDE3F3A498D40487ADF3FD72AB5C0B8D2B53F01C6E74062DDF13EFA002440B4266340F7BBF13F3F2692C081DE47C07CD9663E81A53DC07CE47DC0BE6C89404E88A3BFD8F527409C8F1AC0B3FCD63FC04F2FC0FC6134C07CE6183F8AB1C73F5D0327BFB39DEF40E9948C3ED2157B403DBE0CC0669C5740193C1840ECD73DC0BBDFE0BD87C5F74072AF85C0DB7B84C0D3E6FF3E2CE97F3FEBD24B40FF3765C024E4AFBFB22E86409360583EBE0A16BE117153C04030853D1CA8BE3FA76FF640E813B2BF407F68C0281486408ED7CABFD3E49ABFDCF8363E04A096402B2C01BFA96146C0E48113C0C0D8EFBEA595A74078BF6F3FC1D3BF40CAAE8EC048DD5BC086F443C02885703E6B86C1409E53B44083989DBE8C35523F3607E2BEEFFB37C0FA6ED5BFC7DF72BEE79CDA3EED99AE3F5261374047E6A2409340ECBF81D1163FF631983FFB8FA9C0E51300409D230D40820C6BC0886917400AB5A03EEA3FF6BFE2DDD6BFCE04D440F778B03FD67D2C402134643F9F8E26C04157883F03D20B3F2E12993CBB0D18BF50A01140D31C3140C41681C0B935C0C001B430BF93AA803FECD060C017D4EBBF7C6C8AC0DD3A803E506D8ABF5A3A88C032B62C3FE9B3C6BFB0B7C33F88110A4095B47DC05236CC4087972EBFDECBECBDD85548BF812C3C40000C82C0CB3C73BE30CA343F0CF6C43F0A3E80C0AC89A7C075D898BFFFEA1240D46FA43FA251F2BEF37629407E122140903130BD80F43C407350663F6C671BC001D5943FAD777A40015DBABFDF2B134062A99D3FD720B23F9F0F36BF9DC523BFF08B4240EF15913F4C5F5BC08F2473C0E6B37D3FD2A998BF745FA33E2C70813F540284BFC0EDD640B8276AC0126E493FD37262C09611CBBFE078BEC06AA40A3F308CBA3F8D8FB5BD1DD97840130A48402D0F0FC078FAA83F48006F3F0960A6C08A122A409B1868402E96A63F3B8D66C062145BBD7CA62CBEDC6928C0E277A8BE068E0B4018F75CC0678F07400A15FEBE4C5E41C0D0BE76BF778C6ABF673F4AC02402B23FDE1A19408862AAC02DC5B7BFBB4728C0F222E93FF15B303F3069DEBFC856003FEB7862BF151B36C00971C4C06DFA72C03FC58CBF4DE39CBF8DE73F40D3E28FC0F1F5753FA12D19407C43AC3FE49EFE3E15E033C0EDE682C0587795405A1493C05685FCBEC50632C09151BA3F39585D3F110C33BE96BA80C0401B8B402C8B81BF1854543E2DC3F2BF17791D3F09A858C0C83A9F3F2FC849C04161633FC720BF3F50104DBE8ECCC03DDA7A8B3D32508940B270B840FBF0234086B280BF0BE53BC0207F4340779248C07E00AD3F1F3C333FE113BDC06A8CDE3F9D2102C075AB73C0459921C097E49DC0E5D34C40B4BBAD3EDF9E9D3F9F0D34C016FE813E94871F3F24868AC0F18B79C0A67FACC09713CBBFECB2CF3C47BF2040D7CFD840AB0F3EC0AA2103C01F7730C015617EC022C5D7BF3FC652C02C732C4034C3074054A3B0C05C8DD73FE123633F47659840CA9A2CC0A872B740E724B24031861FC0F451BCC0F4D2C53D0038A53F3950B0C013567CC09F387AC0D5584D405461FD3EE999CDBEB3F937C06F941A40A593D7BEA5999840BE555AC07C6AC7BF713A9EC089F413419E676840B9FF38C02DF22F40C7F829C0BD7267BF89761D409C788E401A8A153E79A2E9BF68F9A13F5D3EB6BFEF929D3FD326F63FDE9073BFE3C6BA3FB96991C0CE510D3FC7C5893EF5A66CBC87003F40E7B4DB3F0DDA91BFA1EC17404B4D01405ED7B1401D609540AE9FAAC051930DC0E0E55EBF1D34D1C0A4A4E53F7C75A13F20641BBF3D761740DCCF1E40F474783E144A123F78AC1CC0882B66BE8ABE12BD539DB03F7D6756BF048D18403D6B84BC3DAF43C0AB6DF1BF053297C0497A8440E66801BFC60CFABE0F728440BD95A4C097D889BFEF0D394004F2E03E3E7700BF720A78C05AAB85BF25A6ED3F78A9F3BF2E5F98401560B23FD58A263F8F03783D775255408E4B42C0CF17D83ED9B138BF0C0FBF40D9F7D0BF96E143C0B1AECFBF0798833EB88318C08BC15E3FF8CBE63F8043603F592A313F270624400D894C3F511D67C0A48EAA402CBC42C0049719C0AE3E5F3FA434353FB855544002AE2F3F34A63EBF9BAABCC0DB3C233F35A79BC059A070C029E04AC0880CBAC088194EBEAA31B6C08C1988408DFEF4403D50D33F30175F40BDB540C08CAC873F29AA95C0B0AFA4C05AA18CBE4FFFF13E05245EBFF7A47B4065999C3FF0A3843F8384CCC039F9C3C07A9873C00D330E3DDD3B683E98EB2740B336F5400333FF3F3826F2406FEBB5BF080AF8BD51DE6DC00020443F8B773FC016F69B408F9159BF24875DBF3623BE3E703312BF0F8ACEBD1F72A8C076519FBE02BFCD40723A83BF981D95401E6EBCC0FAE2AC3EE01651401BE95ABE2843F53F0E9EF63E3682D73F676B0FBF8D66C3C09C0843408DD118C05D4320C06FDCE03F7C0235BF2882C33EC543B1C02716E3BF29820FC055175DBD538B1840BF0FB8BFF2F282C0A0828540B18201C04B3A6A40C2944040A3490C401D59EF3EE0053CC060B5AEBEA3FE6FC04C6268C02F0102BF35BD41BF1460F23E4EB4913E158DA5BD4EDC13C197F86B404C8BAC4097C8AAC06FF7273F3E5E1E40ABFC49C078811140D302B23F4AEFE5BDF2969240B35903C0A14BE8BFF2071E4058A21440F029BBBFE4BD35409608E03F9933893FB3D8C43E2198B3C04263703FFAEF453F6A7781BFAD5DB1BF99C9A03FF159364025AF16BF0ACFBEBF76AA94C0CEECFD3F57693A40F4DF8FC098B2CABFEB05CCBFC09415403AF6B840694A44BFB4100B402D9240C00B6A16404A1320405A48ECC0F03DCD3F3DCC5A3F28CC6740AD863AC02CFDA3C009011FC09292853E4627CF3F721F05C093F398402F7A39BF395FC8BFA5949F40F7DC783EA8D378402EF8853FA35577BFDFED1440154EFBBF2F4896BFAF2DD7C088C853BFEB88A0C075923D3E71DD03C0BE0E3640AD4B4B3F2C44C8C00F91B3C0B09024402CA7664035F8163CD188C1C040DD423F373C72C05C0D513FCDC257C06D7C62C0F5B9B53EDA202EC045D102C0DA807AC0CF5BC33EDDAE6A4035A5373DB0261D404855BB3FB40CB8BF998A36C08FE1B640F179A840770F76408F83A940E40AFA3F1CC3F23F047B86C0960EBBC0D905BB3FF7E902C0F55E164078F38E3DB06CD5C05C75B2BFC97AE2C0F7B2A63FA9022C40203BE23D5B39D9BDACBA68400AF308C1DE173FBFE75001C06A24D93FE3F93AC0E605F3BF9BA0943F68710A3F28F81C400307593FBF4A9240DB9B45408FA89F40DED7F4BF9C92A83FD93CDBC06B1A2BBFDB6903408BFB9EBF2644B1406171023FDDFFCDBF22CE59BFD15639BF2F47F5C0725C00BFE9AAE0BF63E3E33E54A3ED3F493C913D71D2C73F90718AC0B1507140688EDCBF9582F5BEB10F854058DF1DC0CAA70A40C5E296C0FFA3F7BF293615408180AD3FE293F6BF9DE46B40841062403F00B2BFEC72DEBFEE92A53E7CD498BFD0AA1A40E3D901BF3B0E7140D11C8240AA311EC00E53ED3F4C13ECC05850A7C08A34FEBE469576BFFFF275C04C1292BFF483A5BF7867BBBE26B55E405C312BC07CE50B4095A2803FA4556DC0A25D6A3F3E880EC0CAEB4FBF6357773F7B6E09403AEC86C03475F6BF355ABE40E1ACBC3F74A35D40AEFB173F31F2B43FF4B234C03A58BCBFD06196C09325DDC01F08443FB22C05C0CE940EC063CD8440EC2022C0F2D2874053340B405064F13FC616DABFC2BE923F62083E404996BD3E5029CE3FD2B362BF5685104049A89A3F28FC684028B08AC0CD7B8AC0DCFA0AC0BC408F40F6C62CC02AC9E6BF69870DC0A32D3F3FB62882BEF4968EC07E2E62C0A012C9BED3529F3F07C933C0798138405B9C1CC0DB97BA3F9983BCC05241533FC04DE340213FAF3FE14098BF4358AAC088E5AE3EEDBBB83F3B18903FE8BAB240EE6A143E5188CC409F6C2DC07FBDDF3E932AA13EE64305BFFEC66640B708A33BD58FE93EF9274C4006D3834029A658C0DB87A4C01E98B3BF6422B24003D1753FBE1204C08C4198BFC0EA8B3F99D8F93F5329863D2A1C484046CFD7BF6AC6E3BFA1FF41401729A9403B95F03FD6E288BF863EDB3F2FA8D2BF7DD40540B827DFC096D199BF297A92BDF9A7923FB30BBEC0A563C53F30E2643FA3B88E3F5CD207404AF128C0B0440A3F6F37FC3F6415323F91E3843FE1504840365915BF81CC69BF3B62EBBF9972AB3E8EA185BF4CDA8140AB70C3BE5B3CF640861F3D40D83CD7C05849BEC04F306B3E39CB0041D291964085118A4093F2FB3FAEE0DB3FDA6090C015FD17403A3390BF1BCEA9BF12EA9EC053A816BF93B986BF4B328ABF592067BE526B86C0788B3DC06171573F8091883FAF20DDBD796CE73F13F5EB3F79F2F53E5593E9BF4B6B9240055CDCBF5CCDFDBF68CD24C01893A6BFD262BA3FDEF71A3FF914353F86FE1440C98EFCBE062950C0ACDA3440032D073FA9AAA53E6A7D5C3F6E1E2EC0BBD49540A38CFE3F7BCAB93EAE9D53C022717BC0C20AFFBFF55663402B3BDF3F44475BC01536CE40A70D443F68B317C04E0A943F15BA35C0BD9A1BC05394A4402D3D33C026F7A9BF78A830BF9F496FBFAEF5D6BC6A22053EC510363FCDEE76BF5BE166C0B8E80840CC5A56C0EF5C4840231DD33E8543C1C0FE760D4002C303C09015A7BFC9B704BFAD2F103FC415DD3E1C90A53F651B0040CE137C40B2385CBDD9F0623E07DAD7BF0219934062C2A73FCCD6D8BF7E86C3C0B985823F423F8A3FEDC8D2C0E33827C03F078540B90D70C0668E8CBF25CF1A40B6E601BEB415A03EAE01BDC05D634340135010C0F7ED9BBEAFD425BF54C80B4013F45B405D70DFBF9AE50A40A6E43BBED4C4CBBFB831B23E2E0E40C05B1105C0B8140140A7785CC031228D40F17639C05F602340C560C0BFE6C20AC06C07863F817804C06D230FC0AA610340555A6B3F37D3614032DD98408650553FF48E23C088F091BEA1E3A3BFEE42B3C0C47D92BDF07BD6BE943F124003B21B3F6DD1FD3E1BD5C1BFF2179DBF6DD5BDC0F7F221C053F16240985A8C4042C136C088945B4051816CC096A64BC0D46D6B4008539140F29F763FD7103BC05226764015F47C40BA5F62C008B7D5BF194FCFBE4B779D400C445CBF1B16AC3DD96EBFBFB9937E40F1CF983FE2893AC0CF860A4068538E402DFB2DBF1B51F7BF9C392A40014E533F9B1082C07EC47640EC862C40340867403D383D404426273FBFFA40C0B80E1540C76D1A4027629AC06F9D514070721D4187FB9F3F6D88D1BF5874243FF75990BF3DC75F3F197D253F7C6D9B3FAA348F40B7EE8CC0BC48554012ABE03F7877CDBC8D848A3E26AF72C0A1F342BE81C2A2BF765D48BEDAC6C53F4D8D7D3F3DDBA8403390513F9A416E3FAEF297BFC69FCABF78FAF53EEF2B50BE134ED83FB152514019021540282443BF21DB0F3E5AEE8D4098CC053FA1D37840A4823C3F099FE73EF7DD4A4088CBFF3FF30B0CC0029F7FC026268B408C257F3FBA1B8CBFD8706940543201C014D26D4020ECAC3F77FCCF3E1EBD8540E2BF693F05D958C002E70D4095038CBFA4082D3F0D8CA5C0F5A3523FFBBAA1BEAAB514C0C1E0CEC0852E483FBDBCBABF57EF24C02988F0BE9CA6D7BF10B99040620744C0D195E93F60F49240E84EB4409D0268C0928B1D40C231B7BF91F6E9BF400A22C0D5D6C6BFB7DD0940D92352408241153F507AB93F4A3E1240E78AF73FE581014040538840E6BCDB3F9D729CBF71300D402B77134033D9E7BFA08541C04CF982C09E5406C0836A5BC06612B73FD4AA44C021466DBF38CA8BC0922C1CC0DB184FC0CB512E40F9D02C40B244ED4089E414403CDFFEBE724D2EC0E5D47FC091D7273F006DA23F4A850E403AB136BF820C6A4069FC1FBFC0F360C0603B9640852EC53EBCFDAE4018CE3740CBBE5740A0855DC0879F27C09BC83FC0BCD3DC3FE62F64408B111BC0A2602D40277AD9C0D76A7640C02E31407C1768BF072C00BFEA35D33FA80B68402A2B70C076F6CBC0A59D783FA6C909C044B343BDD39557BFAA6F8D3FC5B0BC40ED109640ACE40BBF"> : tensor<20x30xcomplex<f32>>
    return %0 : tensor<20x30xcomplex<f32>>
  }
  func.func private @expected() -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x0000C0FF0000807F000080FF0000807F0000807F0000807F0000C0FF0000807F000080FF0000807F0000C0FF0000807F8143F03DDE58043E0000C0FF000080FF0000C0FF000080FF0000C0FF0000807F0000C0FF000080FF0000807F0000807F0000C0FF000080FF0000807F000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF0000807F000080FF000080FF000080FF0000807F0000807F0000807F0000C0FF0000807F0000807F000080FF0000C0FF000080FF000080FF0000807F0000C0FF000080FF0000C0FF000080FF0000C0FF0000C0FF0000C0FF000080FF0000807F000080FF000080FF000080FF0000807F000080FF000080FF0000807F000080FF0000807F79C8215391EF4A530000807F0000807F63FFEBEE67E2036F0000C0FF0000807F0000C0FF000080FFB4BB19189AF43515530625CF227DCCCF0000C0FF0000807F0000C0FF000080FF000080FF0000807F0000807F0000807F0000C0FF000080FF0000807F0000807F7B2E29A05FFA639F0000C0FF0000807F000080FF000080FF000080FF0000807F4EF6B2D3411A7C550000807F0000807F0000807F0000C0FF000080FF000080FF68F96509EE101D0B405B00F9E30554F9000080FF0000807F0000807F000080FF000080FF000080FF0000807F000080FF0000807F0000807F0000C0FF0000807F0000C0FF000080FF0000C0FF0000807F0000807F000080FF0000C0FF000080FF0000C0FF000080FF0000807F0000807F0000C0FF000080FF0000807F000080FF0000807F0000807F0000807F000080FF9CF824EE4009486E0000C0FF0000807F000080FF000080FF000080FF000080FF0000807F0000807F0000C0FF0000807F0000C0FF000080FF2A9270C9FD8C65490000C0FF000080FF0000C0FF0000807F00000000000000800000807F0000807F0000C0FF0000C0FF0000807F000080FF0000C0FF000080FFFF72EBD15BDEDDD00000C0FF0000807F000080FF000080FF0000C0FF0000807F0000C0FF0000807F0000C0FF000080FF0000807F000080FF0000C0FF0000807F2A017533199EA9AF0000807F0000807F8606E2EE18EF0F6F499800E05694ECDF0000C0FF0000807FCD0390F996E2107C0000C0FF000080FF000080FF000080FF0000C0FF0000807F50989BFC9F3C15FB0000C0FF000080FF000080FF0000807F0000807F0000807FDB2DDBCF7AC865CF6662960F0279838F000080FF000080FF0000C0FF000080FFF6258A51C56029D10000807F0000807F0000C0FF0000807F0000C0FF0000807FF989A7EF030B9DEE000080FF0000807F0000C0FF000080FF5EF08B1D5E875A9D0000807F000080FF0000C0FF000080FF1B23A86F7A0DE96E0000C0FF0000807F000080FF000080FF9084F95BFDDB0CDC000080FF0000807F0000807F000080FF000080FF0000807F0000807F0000C0FF0000807F000080FFC5B013788679E67752A2A3BA70545A3B000080FF0000807F0000C0FF000080FF0D61E5E5B1D7A56754ABC0C4D3033BC40000C0FF0000807F0000807F0000807F0000807F0000807F0000C0FF0000807F13CAB360539B21E20000C0FF0000807F0000807F000080FF0000C0FF0000C0FF0000C0FF0000C0FF000080FF0000807F00000000000000000000807F000080FF000080FF0000C0FF000080FF0000807F0000807F000080FF000080FF0000807F0000807F000080FF0000C0FF000080FF0000807F0000807FFD6D8D789FA885F8F8077EC0C84FEAC00000C0FF000080FF0000807F0000807F000080FF000080FF0000C0FF000080FF000080FF0000807F0000807F0000807F0000C0FF0000807F0000C0FF0000807F0000807F000080FFF424FE3385DBD6B20000C0FF000080FF3E1657C29F34FD413830387EEA7E927E0000807F0000807F0000807F000080FFE66639E4BE0C006500000000000000000000C0FF000080FF000080FF0000807F0000C0FF0000C0FF0000807F0000807F0000C0FF0000C0FF000080FF0000807F0000C0FF000080FF0000C0FF0000807FD7F236D505D4D2550000807F000080FF0000C0FF000080FF0000C0FF000080FFBE972A6959C7AC690000C0FF0000807F0000807F000080FF0000C0FF000080FF0000807F000080FF000080FF000080FF0000C0FF0000807F0000C0FF0000807F0000C0FF0000807F0000C0FF0000807F0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF000080FF0000807F000080FF0000807F000080FF0000807F0000C0FF0000807F0000C0FF0000C0FF0000C0FF0000807F0000807F0000807F0000807F0000807F0000C0FF0000807F03939576F06EACF6092B777A8FB6D1F9000080FF0000807F26653AF2A9D3B2710000C0FF000080FF0000000000000080000080FF000080FF0000807F000080FF0000C0FF000080FF0000C0FF000080FF0000807F0000807F0000C0FF0000807FB876355EF83B9EDD000080FF0000807F854886938E6496930000807F0000807F27A9A3DB3FC2025D000080FF000080FF0000807F0000807F0000C0FF000080FF0000C0FF0000807F0000C0FF0000807F0000C0FF0000807F000080FF0000807F000080FF0000807F0000807F0000807F0000C0FF0000C0FF06E75B6634ADCDE6000080FF0000807F0000807F000080FF0000C0FF0000C0FF000080FF0000807F94AF5EEC7814DC6C0000807F0000807F79B9D87E305E057F000080FF000080FF000080FF0000807F0000C0FF0000807F000080FF000080FF000080FF000080FF8169C2BF9C3597400000C0FF000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF0000807F000080FF000080FF0000807F000080FF0000C0FF0000807F1EAFFB87070CCF070000807F0000C0FF9D3BCB69DDEFAC6A0000C0FF000080FF0000807F0000807F0000807F000080FF0000C0FF0000807F0000C0FF000080FF000080FF000080FF000080FF000080FF0000C0FF000080FF185E2FB9D50CEE3958378D0D9FF56C0C0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF000080FF000080FFB39F9B7BCE6D02F95E569572F37988720000C0FF000080FF000080FF0000807F0000807F0000807F0F7774AB9A2257290000C0FF0000807F0000807F000080FF0000807F0000807F0000C0FF0000807F0000C0FF0000807F000080FF000080FF000080FF0000807F000080FF0000807F0000807F0000807F29352F346CBE0B3500000000000000000000C0FF0000807F0000C0FF000080FF000080FF0000807F0000807F000080FF0B57B4DD3EDBBB5D0000C0FF0000807F000080FF0000807F000080FF000080FF000080FF0000807F3731594B054759CA0000C0FF0000807FCED48DD55617D75445709DF8A0158BF8000080FF000080FF0000C0FF000080FF000080FF000080FF0000C0FF0000807F0000807F000080FF0000C0FF0000807F0000807F0000807F000080FF000080FF0000C0FF000080FF0000807F000080FF0000C0FF000080FF0000807F0000807F000080FF0000807F0000C0FF000080FF0000C0FF0000807F000080FF000080FF504ACD5F6E6438DF000080FF000080FF0000C0FF000080FF0000C0FF0000C0FF0000807F000080FF000080FF0000807F0000C0FF0000807F0000C0FF0000C0FF0000C0FF0000C0FF000080FF0000807F0000807F0000807F0000807F0000807F000080FF0000807F0000807F000080FF000080FF0000807F000080FF000080FF0000807F000080FF0000C0FF0000807F0000C0FF0000807F000080FF000080FF0000C0FF000080FF000080FF000080FF000080FF000080FF0000C0FF0000807F0000C0FF0000807F000080FF000080FF000080FF000080FF0000C0FF000080FF0000807F0000807F0000807F0000807FACF27155F4C918D6000080FF000080FF0000C0FF0000807F0000C0FF000080FF0000C0FF0000C0FF0000807F0000807F0000C0FF0000C0FF04E767EFEE219E6EA0E7B945FC369DC90000C0FF000080FF616ADBF5056F5B743462C47679E832F80000C0FF0000807F0000C0FF0000807F0000C0FF0000807F0000807F000080FF0000C0FF000080FF000080FF000080FF0000C0FF0000807F000080FF0000807F1D4C82729E48A3F30000807F000080FF000080FF000080FF0000C0FF000080FF0000C0FF0000807F0000C0FF000080FF0000807F0000807F39E719F19CE72DF10000807F000080FF0000807F000080FF000080FF0000807F0000807F0000807F5832935477AA8BD40000C0FF0000C0FF0000C0FF0000C0FF000080FF0000807F684590E5592A9AE60000807F0000807F0000C0FF000080FF000080FF0000807F0000C0FF0000807F0000C0FF0000807F000080FF000080FF000080FF000080FF000080FF000080FFC2A7C37620461CF70000807F000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF000080FF0000807F2D087DA9B6138A290000C0FF000080FF5E73C857356944D70000C0FF0000807F0000807F000080FF0000C0FF000080FF0000C0FF0000807F0000C0FF000080FFF2A38C630219C0620000C0FF0000807F0000C0FF0000807F0000807F0000807FCD98B10F6B51F411000080FF0000807F0000807F0000807F0000C0FF0000C0FF0000C0FF000080FF0000C0FF0000807F0000807F0000807F000080FF000080FF000080FF000080FF0000807F0000807F0000C0FF0000807F000080FF0000807F000080FF0000807F0000C0FF000080FF895098CF458E72D00000C0FF000080FFDD392FF471B924F40000807F000080FF0000807F0000807F000080FF000080FF000080FF0000807FE54FD5444AB6D3C6DAD67678C58E96F80000807F0000C0FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FF0000807F000080FF0000C0FF0000C0FF05949450CDBDD5CF2B46FCC7661857C80000C0FF0000807F78BDBDD727FD915B1362DB759E06FBF492B11B7A18985D7A0000C0FF0000807F0000807F000080FF0000807F0000807F72172B6944FC1FE8000080FF000080FF0000807F0000807F000080FF000080FFA83FD4B7BEEB12360000C0FF0000807F000080FF000080FF0000C0FF000080FF0000C0FF0000807F000080FF000080FF0000C0FF000080FF0000807F0000807F0000807F000080FF0000C0FF000080FF5DBFB1638636566417F93D39E4EAAA3850B69C2103BC55210000807F0000807F000080FF000080FF000080FF000080FF0000C0FF0000C0FF0000807F000080FF3500FB25F963FFA67EF40F5A5D58E25B0000C0FF0000C0FF00000000000000000000C0FF000080FF000080FF0000807F0000C0FF0000807F0000C0FF000080FF0000C0FF0000807F0000807F0000807F000080FF000080FF0000C0FF000080FF000080FF0000807FD7188FA0ED6D9E20000080FF0000C0FF000080FF000080FFB5FA986A28CE0EEA000080FF0000807F0000807F000080FF0000C0FF0000807F0000807F000080FF0000807F0000807F000080FF000080FF000080FF000080FF000080FF000080FF0000C0FF0000807F0000807F000080FF0000C0FF0000C0FF0000000000000000000080FF0000807FF76FC9E9156301EA0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000080FF0000C0FF0000807F0000C0FF0000807F0000C0FF000080FF0000C0FF000080FF0000C0FF0000807F87674EF0991505710000C0FF000080FF266744E4CE682E640000C0FF000080FF000080FF000080FF0000C0FF000080FF000080FF000080FF000080FF0000C0FF0000C0FF000080FF0000C0FF0000807F000080FF0000807F000080FF0000807F0000C0FF0000807F0000C0FF000080FFE50B2073190378F263C2835FAA61F75F753E5F5C92B783DC0000C0FF000080FF000080FF000080FF00000080000000800000807F000080FFD78775D6C59613D6066B17F7069DA6F50000C0FF0000807FD5296CE48A2E14E5105A90ED6E9FA4ECC80AA86FB5B91870000080FF0000C0FFFF6E8127F68512A80000C0FF000080FF000080FF000080FF0000807F000080FF000080FF0000807F0000C0FF000080FFC347CA624B115463000080FF0000C0FF0000807F000080FF0000807F0000C0FF000080FF0000807F000080FF000080FF0000C0FF000080FFD1A1C3B362C97BB30000C0FF0000807F0EA6D96C19DB976D0000807F0000807F0000C0FF0000807F0000807F000080FF0000C0FF0000807F0000C0FF0000C0FF0000807F000080FF0000807F000080FF0000807F0000807F5E334F688CAABB66000080FF0000807F0000C0FF000080FF000080FF0000807F000080FF0000807F000080FF0000807F0000C0FF000080FF000080FF000080FF0000807F0000807F0000C0FF0000807F0000C0FF0000807F0000C0FF000080FF000080FF000080FF0000C0FF000080FFB720F55F9E71CC5F000080FF000080FF000080FF000080FF0000C0FF000080FF0000C0FF0000807F0000C0FF0000807F0000C0FF000080FF0000807F000080FF0000C0FF000080FF0000C0FF000080FF0000C0FF000080FFCE73D9C19697A2C20000807F0000807F0000C0FF0000C0FF000080FF000080FF2A27B22F8A38892F0000C0FF0000C0FF0000C0FF0000807F"> : tensor<20x30xcomplex<f32>>
    return %0 : tensor<20x30xcomplex<f32>>
  }
  func.func private @integer_pow(%arg0: tensor<20x30xcomplex<f32>>) -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<20x30xcomplex<f32>>
    %1 = stablehlo.multiply %arg0, %0 : tensor<20x30xcomplex<f32>>
    %2 = stablehlo.multiply %0, %0 : tensor<20x30xcomplex<f32>>
    %3 = stablehlo.multiply %1, %2 : tensor<20x30xcomplex<f32>>
    %4 = stablehlo.multiply %2, %2 : tensor<20x30xcomplex<f32>>
    %5 = stablehlo.multiply %3, %4 : tensor<20x30xcomplex<f32>>
    %6 = stablehlo.multiply %4, %4 : tensor<20x30xcomplex<f32>>
    %7 = stablehlo.multiply %5, %6 : tensor<20x30xcomplex<f32>>
    %8 = stablehlo.multiply %6, %6 : tensor<20x30xcomplex<f32>>
    %9 = stablehlo.multiply %7, %8 : tensor<20x30xcomplex<f32>>
    %10 = stablehlo.multiply %8, %8 : tensor<20x30xcomplex<f32>>
    %11 = stablehlo.multiply %9, %10 : tensor<20x30xcomplex<f32>>
    return %11 : tensor<20x30xcomplex<f32>>
  }
}
