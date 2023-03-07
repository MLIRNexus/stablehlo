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
    %0 = stablehlo.constant dense<"0xC99F47BF4477BA3ECB89F9C0323D02C08230B13FC00B8E3FB332993F39895AC0FD54EB3FB8D646BE0C5DF5BF66648640879C9740F091B440E9FB99BFF1D77E405FF684C0D39C1DBFA973C13F4A49C040516EDFBFA0711BC0BBD17B40B96DC9BF10E8E0BF48E16E3F94DC293F9B56124077379E3F610E7EBE528D5D403FEF623FCE578CC0339D1BC0A8B28B40DA6E4140CAD068C0C17E9540DA66B4BEC522EE3DB3240C4006004340692A374050BF99C03C1D18400AA191C02DA6DEBF0DFB40BE01E6174057595A405ADDD9BF332F4A40EE1D5EC05C177F3EFDCD4040F3DDCE3F06583C40250A90BF9286B0C041FD2EC0DF0B863F1DCB14C09F1933C0DC8625C0A0DC31C0F666D9BDEE5BCC4018CC98C00E4F23BFD536B43EDF8D36C0027F56C0F774DC3FB67169BF268254BF463267C08301623ED5241DC0D2B389C0F0AE19408E636BC0F7D31F4085A2DA3FCB43F5BFAAE804C07390863FDAC74040142443C0AF75D240E8A6F9C0DB1C683DDB022740D76A3DC0EA1578C0508AC6BEA536923F921CE5C02C6C05C03CF95FC0E00C8140D79704C0DDAFE1BE67638AC0C8D39640559F15C011BC5A3FB3C39FC086918A3FE0E2AFC077537FC0FF87D93F1924853F1C1A8EBF9622B9C07B52174098232840445911C02896FFBFCA7F1741A6296C3E265E10C0BF048E40D855F2BF0ED623BFC521923E274DCCBE9240CB3FEB8C003FB53C85C0C1BA833F01C544C01F25BB3F58B0883F5DD43EBF5A473EC0EF5543C066144BC0ED10653FF6E3D1C0654CCA3FBD1496BE364898BF1178D13F55F780BFA97C42C05420B0C01B19253E039295BF9A9FE4BEC01C82BE1A436D4081AB5FBF79EBE5C05C35D9407243CC3F7682EBC0353AB840FBB75CC08B4155BF92B142BE5952D83FAE0A044023EB7BC009EFABBDC548B2BF252DEF3F50A2FE3FE24D80C05EF68C40FBFFF3BF6B5E3CC0C5A9F540B9DBB1BE359C2CC05F2F90C0B6C31CC03480A340A1B3E9BEF4C062402E51CF3F53A9E83FE5FCCFC01E0CB7C0779183BFB46F82C0739A10BF54E72240E58B2240DEE409BF7EB28DC052F856BEFDFE4D3FAAD29840A0641FC06DA8003FAC031F4064B45F3FEE4968BF014C89405799024010A0C140ED35BBC08E2FF2BF03404340D2E6C0BF8F274240EC188040C2E4BBC04F3B5C40DF7AFF3F54D760C0334F0B3F027B7DBE119B1440DE0626C0184153C060A5094029DACE3F433663BFFF60B63FA856973F28AB67404BAD0E400E2C65C0167FFEBFB3CBA64028CA8040792C093F781F23C0ACFD8740E0179BBF518AB13F1E82593F890E6DBF83B85FC02BF399C059E265C0FD2195BF67854840F7861F40CCC54340379E9F4086ABA2C07B869E3E5C698B4075572140D7970A4055EB46C0DA34D3BF32FB6A3FB11D01C04AB42F40E21C81405FB01E3F52CA3CC05EB91DBFF43DB2C0A76B563F4FAD9F3F3E5EE13F0DA7163FBA2F4CC0E549DC40DB82C7C092F795C0CB23DD40DA682540EBE330BF0691B7C05922FD3FCB6FC5C0997F34401AD51040603204C0A5B47AC0CDCB64403D082EC028F07C40E2C808C06A68413F60D49040A719BC3F1BBC0FC015428F3DF8ACF940564975C0BF62D3BEC49C1BC018E1DF3F2EEF8EC0C7FD57BFD1F87B3F8C37B23F0BAA74C0E92367C035EE573EA6A325407ED183BF8E78A4BFAF468FBC176AC13F31799E40624F61C01E87C1BFA91566C0F23F6EBF4820B940526447409AA456C001D90ABF611101417111E2BFE89E543FC2296CC0B0FC4ABFBA780440E07F373EE7B90FC022444CBDCABBD8BD11E060C074A92840AAB1ED3FDDFEEC3F5ED2EA3F407CABBEEB5585400F890DC09644F93E6AD78240A7585BC061EF4D4078BB0841989AF2BF6AB50B419C50D13FC09CD3BF602948BFF1B615406CB75EC0FCAE6140B3EC2C40263F253F6E6B3340D1786D40A282BEC02A574B40CF3D694097BB59BF7A57B4BE07C1E13F4896384047D95D40585643404FBC123E344BCDC0C7EDB53F892D3B40B90AAABF8CB8254015DEFFBE121FE8BF55B30AC160FE28C02BDF96BFE446D6BFF53FBB402BB8C8BEDF03AE3FB315863F1AB425404594EBBFF489A94037BAD0C0AC78823F1D1652BFCDEE6240027E92BFCDC317C0334D0EC0816EB6BDF7CCE3C0AC319F40C8EB6BC0EA94E93F7BF83DC07789A3BEA7319A3FC3688DBF6E36C9BF4B779FBF95291C3E32709DC0FEC4D43FBE4818C080E2CDBF64C85240CE6F7BBF67699D3FC554D3BFDD14B7BF51790F40455D85C0BB01C2BE16F25ABF9F1A063F11EDA03F6C33DD3FDA4F7CC034390E40B03C5ABED9EB17BF2FBC7C3FD87515BEF53A0CC05E74C3BF0AABA13F785310BF154C9AC0507D2E40EDE4983FD283123E01F95D3FEB13933F7D94B540557FA8BD7CAC3EC0B1EBC8BF917603404B19D3BDE35740BF87DD4EBF79FD1B3FDA936A40C3D70DBE44DC853D537B7C405173A3C0DF47F5BFCD389A3FE83FDD3FA7010441D8C984C01F82E23F96E72C40B8E092C03A8FB740B1243A4022CEAD4021EDF6404D00F83F761799BF84A06740BC569CBF0201ED3F5DB96C40803F0B40FA57F5BE32C0223F49CCA53F80CDC93F13190741D4160E4058C62CC0530F423F7152164083C09CBFC1F369C094E979C0152C0EBDEDFDB9C0122A13BFF8A990405880AAC0109A5C400BBF1CC0102A2140A725D940C9B359403453BA40BBF0273F66B7A9400D7B13C0481537C0017D9E3F54ECDA3D3CF0EB3E7CB0AFC0FD9B81C0F897F4BEFC3C88C0481F4D40CC8B93BF859E9640EC79B940B243D53EDF1025C01E729DBF458EFABF6C6C03C061C9533FB4D73340D42EB3C058B19640CE832140E424A3C05E31584058B5A1BC9025BDBEC1660C408D5E1B403C30EA406C02BE405B579BC08773784030906CBD1701E0BF067B0740D213F0BFF63C46C0406BB14088F2094074D659403155A33FE08995BF75112E3E839AE93FE0838D40AC6991BF9A1FF03F0D91C9BE20DDF040B1FBF63F7AE667400EAB693F9ECB87BFD9F6A7BF581AAB3C3B81534074294FBF4132BD3FCDB8D5406FE0763FB1D55D407C426F3F700A21C0862F113F8AF40540145615C01C1901C04DD62040CE268A40016614C02E6215BFB89892C0C91F8A408EB04D40764A22C08E29CA3E0255BCBFBD2300C1AD818E3F886E89C0A58DADBF6ED27040DD3A42C015E8903F8ACD5D402F3692C0433165C01D6C0E40F3C9B6BEF00E0EC0DB41B0C05AFA963F499132414191143F3EAD4D3FEAAC4BBFD41EAC3F284B46C08E37BF40480B13C0451BE4BFA88BEB3E16C35040935B99BF96D09D3EDCE6AEBFAD5C91BFBBAA46C03D484B40EA99DABF20504B40FAD0433E7B8A5940C3BA85BD1A3657C0F88031BF14C6333F0E7ED9BEE9AEB7BF57539640C13FE2BFE7E9DDBFBA740FC07B8BEE3F1CA27E3E19D8AF40DD1C31C052FDF8BE18E91B4058D2113F780921407258743F8429EC3E529A33C054AAA63FB3121B40F5205A3F4358603FBEF1CA40EEEFDA3EC3B2E1BF1C0C99406F3500C066728BBF47A0753FCD94693F119A7CBE6422BFBEE69881C09F07FA3F0DE731C09E93F43CFBF1E73FA01F35BE06755B4063394DBFB03690BFE13C9A407E89613F8DF35ABFB430474095DBC1BDDBE9113F8C871EC0BFC56EC08E7A98C04DC6BFC0FE5FBE3FAEAACDBF23DC45BF61B2C84085BC24406946A2BDE275FF3E6AF1553D250F8CBF03584BC0090611C096B967C023637840F71EC0BFC435C1C0AF5531BF44C5253DB9F990BE2C8B4D3EE128834085A957C05D6BCFBF6E7596BFF8289C3F31C9A2BFA90273C0B76CEC3EB6BAB0402F93E1BF796610406B3D97C086E222C02616AF40F56A933FDDA94CC01E063840EFACFC3FB49022C0463A673FE67F4A409825993FC840B2C06FF92CC024DFF5BFE0B7A0C0757041400CF8FDBF6E5665C0C107AA40739D15C0445E0241E87D58C0905EACC004F0CB4010CE0D4088531BC05821AC3F39DA313F8D97544031DE094098DB0140209760C08B83384076FD933F79628B3FB21FEABFB02C9CBFF618423F251F9C3E033DCD3E0F3984C02FE9BDBF566A5BBFFFD785BFA6A681C07D15C2BF845FAB40DD39AD40D7EEFA3FEDCC9EBE72750440298715C05C71A43F09CA2C401FA06040BC7D42C0EB3C3C3F1A3B824094E6F33FE4DB1D4084AD89C08266A0C082D0583FEB6DDD3F79A14BBF736DA8BD75A600C028BBA03DF7A885BF512D7FC049DB8DBF3D8147408E0093C039865D3FC985AD40C031DE3F8F47CE3E303B0EC073F365C023E52BBF523C47C034A367BEB4F71A40A98C863F7A0DE040236A684054B18F408D5F7040A9111EBFC4F8B03D6D565040CEAF174066264CBD39D5553F433C38BF3BDEF53F931824414F33304073CF02BF43A4F1BF1C9598C03993B1C002D57EC0ACFF01C00C9285BECFC48DC0909E1B3F6E90A03F2C6EBBC0DBA322C08EE6863F40CAC53FC5EE29BF909A0AC01AB5193FDC620A3F30598BBEEF8E9740BD222ABFCC194CC01B70F63F477206BF63E7BB3F959432BFAC905B3FD506523E44C4353F92811A406F36DB3F2BB0DCBF8A7912C0FAF3F6BFAB3CD83FE808B540378D34BEB4BC353FBD81EDBE33EDCC3E5BCF01C0AD36CD40B8C399BE408791403031C6BFB7B93E40137D3C40E592C5BFECF199BFA18084BF10256BC0F973893F9A873B3FA0509E3F1E202440B4955CBF8A6BC1C0565A303EF868F43ED88B8BBFD8ACA13EDBFD5140391134C0D2804040151814BFEC4392C0615FEBC08F488E3E8541EF40CF9573C09AD42140102825C0A1A6F1BF40EB883FC61CCD3FEAE1AC3FF7385640D3617A3F767585404D593640FF7C23C07F4D2FC0CD5105C0E6489BBF04DE444059A094BF73260240DDCD23BFF1F3503FF295D23F29AE02C0924877C075017E40BA2E37BFC0AACDBFA3C901C08AC3ED3F6FC686C0D17BFEBFBA79F03FC12067C0E88C40C0E6D64A401AC36540BEFE3E40D1FEEFBE05CD9F3FA96726403B1CDBBE8E150E3D9BB31140F630C2C0766321C09367DD3FFA8230C0A8F20DC0F7834F40E6854E4036CFEDBF40E4553F8F9462BECC668D3E966DC9C00407E73F7D057640F8F23440F8467BC019B38BBF580A1DC05FA3BFBFBBC003C05838833EE8B78640F4940240EC0E74C0A2BC434003D680C08C3044BF477751C07ABB48C09E3C23BFE5A750C0362C603E747C1EBCB6AFAD401EC29540E9278B3FAB56DABFB7C5DA3FCCBB9040579C04C096CE29409230A23E73FADEBFD729B9C023B2A640BA5BD9409FB2DA3EEEECD43F92E625400383BFC0BA0917C0E800114067918A3FF681E9BF1415D1BEE05069BFB8D370C08E077FC0720CC8403F77DEBF3F21304080488440EFB553C02F7AB6BFAABFBB3E206C0BC092B95E40E829474056457A3E85C33240D99108406385633C88D42CC047A6863F6B52913FDA811A40B7313DC0B184673F163A18C0DE1208C0DFC2E63FF6B97E40D08A89C0553BD83FF9C5764072B24240592E0740FF1C913E730D15404718D8BE132EB93FD816E6BF71BB56BF4F19B0BF90F00E3D670D43C0BDB7BDBFA07D863FB1958E3FEE753940AB8A49408B82933FD7C09D406F6434403DCEC7BFC8B886403E2956BEBA8E5E3F7C8C6E40C5C9B8BF289D51C013B41FBFE2680EC10F420BBF1CB7A83F3C0FC740F02A2C40D9EFADBD799DB9C0F6C22040E68BB3BFA321A33F6B44384046EC523F405E5DC0DDEDFEBF6F18EABF9C2F8F40EFC41640435EC14022479CBF653A41C0597027C0B04C31C034F541C0706BCC3FBB120FC0379E5CC084234440B2D03840DF36843EE69DF33ED3EC76BFBF1C90C0272D1140753A453F88F9603F8B5D44BD8B96494090A7C1C077A284BE4126FDC085B001404C6C63BF1F9646C0F5D1083FA05AAE402E8F913E526225C0E0FD2CC0B2C0274079244E3E4BB356BF66303E3FC78668C0F1941CBF6EF2013F05E826BF636AFE3F1688103FB51F93C0F7B41EBF540D17C0FDCBD9BF530B5FC0E284E4BE4EACE93D1F7A2D40C913BB3FC24DB13E7690B23FEE67D33FD74A6740934B86C072D283C0B2504CBFE55719BFD2F8C53FDC66C73E41E998C04FF15B40582E14C0FB5359C0EF4D7740BA12B240327C0740729CAC3FED1899C0845CD2BFB782A0C0B86695C0861A843FF0F4B840AE7C9DC0424E62C0984E6340B26D583E6814523DF336E33FC75178BF46E035BF8FCF8FBF2287034042AE3640C3E3C0BF1DB8D63E69A39FBFB08AAF3D261F96405ECEAAC00B060841D2B765C09A8176407936B13FD7B07B402079803FA7184640A052A64052EAC23F95FF89C06093573FD5F8974064840BC0C24807BFE83F89C0F5BB0940AF6DE83FFCA728C0DC3C2E3FC76723409C757940AA7F5540687B5440458A533F2C35E6C0E5BE15BF178A6F40C8EEA03F336882C0B3218CBF78B9C33F4D34E23F44BD40400387163F7BE62B3EE9AE3340B2FB34BF28F01840614BB7BF590FCEBE7688B5BF14B374BF1AB3D1BE0A0CCABFF31C3A402ED052408D4B7E4010F5263F5BA516402027CBBE0E26AD3F05C91240C642A7C02D5331C0825440C0605B5ABEEF01823FF75E33BF79D101C00CBEDEBE4197E03FF04582C0162186BF19A365BD505F0B400735C4BE3F1CBD3FC3139EBFAB9488BF808FA7BB47BFDE3F7161953FF64C41C014434840A2C44EBF652AA6C0669A2AC0A4FA243FF9FCB53FDF58BF3F6E27124039733440D054AE40EC6436C0B32D0AC0DEA9613F4C8A9CBF68A37F3FE05B00BF6CEDF9BED71D2640"> : tensor<20x30xcomplex<f32>>
    return %0 : tensor<20x30xcomplex<f32>>
  }
  func.func private @expected() -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x8BC7C5BD8C410ABFD1C0094585D16045FE870FC168A58640BB251742E72F27435F992A4166BD98C0358880C267D3E0432A2C2DC51E267BC4DDA3E742A30A8A431C798143F5C82C4351874B44969599C4FA0C7FC21E7941C2817F7C419F0DA1C3F6DCBAC08D9868C1607B5B411B74E8C1510EE33FA13BE6BF2B73AF42DF730943C0AF8AC346110E449F7915C480EE0244FA2D87C48F0312445006B53BCA8494BC9DE81DC3B892EFC235A005C4FCCA4C44AD2271C334EA2244DD2D084101EF7A40D53062C33E8D42C33CF682C22258184346990C4351C225C28F2954C29BC2FB4226E52C411DE5C3C28587BFC3C91DAD44B3C2A4C063D62742873C50C33740044217836C42E49B1141704054C5871909C554EDF8BD352A82BEEEFCB1C3B2CDECC2FDE4A9C0129656C10DA2E942DE4314C381590A42E0684F41884184C33EC303C48E268EC35DEE85C30F1E29C267F01D4187700CC13D15E0C1ABAEA8C3F26403415FB31FC647E5614542F7384246D680C0269BF3C321C98FC34C470C3F3BE90240E5BDA3443C112F45492643C4C4BE62430950574132826F418033CEC456398F434DDBCE40495917C286B6DF43C76300C470DFD6C4E6BA9C4432CA13C1B2584C419A965A4470114FC4019F18C35F5B02C26CC6A1C2F1E1A941134DFA458CAB43442E7F3BC3B33E1244659F8640E630764147BD3BBDB218113D4AD12640949CE740B47E3F431F7E8BC3C287DAC1928703C33B560CC0C24EEEBF5092A4C3573E8AC14F9A56422284D2C2538A9744780AD2C4DCF8A33F3361EDBFB1BF01C1577A2FC1B7E128C4881CB0C4D878D33FDA33813FA98708BD31A27A3D2809FD421F2C28C30C2D14C6C95887C41F0B0445298F17450AA88CC41FF6D2C46329AA3E7A5ED53E94AC3AC2C7419CC1B8676F431AC4A341C27FC5C167378141183CD7C2C452C143C05005C24D6E04C41598F2430DFE8D45B9A23E420176D6C198568DC384D91D448E3B22446C9771C3C57D04C275ED634383876F444007E644D91658446B2D3A445259744381141643252B27C344DC3B3FE433AF43C74C38C361FA7F3EF9C2D03E331391C3527F45C4DC89E641BC93ECC156B820C015FB413E416DCFC2236EF9439D759CC563E6A8C3CDF3C8C24E3D04436A390EC2FF88FD42F1ABE9C409DBD844EAE6FDC2DBDE5743D57C0243FB3BB8C258B8D841C5134441A1F889C36CB00EC3150E31C23100E041814E9BC00D1CC940BAF97E42966248C3DA3D41C306BC7A43F6B5DA4251987044CF8D6A435F4009432BCAA7C33582FA43BE7131C15D1244401B4A1DC0617ADA3E82FA7CC42BBD37C4B7E27C423841414339FB66C3D022E14259912CC4E1DC6CC4E93A23442B1622C3A98DA1C30CA80A447E7F1CC383D40543AB81B4C01D3F36C1D45EDDC22C9F994285A2634311051F43C82C6042B6FE7142131F50441A790DC40E4F87C14F0459C10427A54221AF934280FFE3C596CBB6C453A35CC548D7504596B1CD41F13831C20DFDA243CB78A4C4C72A98C3360003C51457ADC208AA7FC1CF7742C466AC0FC3542AC5C39CCAB043D287B1402D88CEC1D9D71E437AC0F3432B57CA413AA74AC02970B4C4AFA5ACC5CC77E7413D6FB8C1A2D1244263F8034434522CC0887A5A3F3D6A3D424FF0864319A72643CA641EC2759B5740736C70C22E442E4033F3173E455B8743AB7026C4808A32C10C3457435F41C9425261214339B237C41F24D6440F80D54280669F4211243D45D0A95CC5E6860143FF771E43FBB2254010FEBF41FAB5C341A41001415AEB14B892DA40B999E69CC3140B48C3EF243DC2CC7D8E3E2F30114141E0FFC0D81D38C357D5E5C3C1C77F43843B03C3BC44F2C342B375C289C36B4544968CC514A88F45E24F8345E79C0BC037882F41A7045DC3082458437A61A8C334AD43433A2C29423D7D57C29942B9C43F69EF44728803C4929C13C368E14839D9D9373F8CC398C2ECEDD3C23839DCC30A8CE442751CD34468451743FD74D3C10545D9C27668B7C1BAF28742C761BE40214130C1D4801F456F11C345F83959C1557332C10D9C8E44F2639CC36B8EF1C094E0884009A99FC2A3D67CC2B6BB8EC5B322FA4411942AC02F8C9CBFCCEF734283D336C3AE79DDC28F426541C05B20459B8500C3CC9498C451A94CC491A6AEC21D7FED422E2E9D3F62E4044052FF27C1EDFF0AC10E590C40D9B794BFDC4140432A5D2FC4788E44C20D463C421D395F42C1BCFFC2324770C121B11D41DDFC00C224DF18427D5F8F43039FD942011018BFD4AE51BFC93E87C13F7A43C1F09142C3EDCCB9C36CAFF63C67E91EBE4F69533FCCAB0CBF55B81AC2F72E04428DF0CABE66DB68C0C38FDCC38BEC4FC45E32EE3FFD1E763F2B6F69C060FE10C0076E81443D7670C2737539C2F2E4EF422B468C41042064C055BABBBF10FC5BBE3FB016438C65E9C2C214DDB83E990DBA9A2BBDC4141E5444FF2383C15E0BA4C17AE15545C00768C5DFBB89C1EFE6CEC384BFD4C34BBC2A4442F500C402EBCB44C55CBFC5D5649DC59FA680C1404BACC1F5346242AD394DC31CFFA4C2E16F8CC32D0C7F418E4696C1CA908BBF183F86C09B9D7B4584FF64C5E91F0AC31134624277E83B4164CA0CC2C5477242A76C54C3F264684335420441A74B8644458ADF43E0180DC5088C3F44C2767AC33AA646C3B64BCC4360A029C59ECD85C48229DDC43FB133444EBDC0C3379125C3D08697C295B50F409D3D4E3F92905944B67397434FB576433767FA42F6C52AC41454D6C319FB9D43F4FBE14327B68844D060A143C5945DC1756D8242ACF680C20B2BC6C0B527F3412A2086C20A9028C5B80272C4158C8AC3A87A7C44022F024386C842C0E4E999411A8B724169597C4406B653C54C2B47C56682A8C420D062431A3358C19A8953C2652BA841222BC4C212350DC3D846DB429AEA9B44DD7CBD41CDFB2C438942D03FE4D687BF8D4A2F404AF602C4653553C11DFD97412A5345451C6D2744CA1CD6C2588783C35D956AC0C2F4903F09793D401C4241BE67979942E2A5DBC20D39B0445664D1C4A8569C42223414C3F562F540C05F4D4211752D41A3309AC12772ADC28C35CF418B7F9FC3E1B205C43F4E90418D0BDA4198CFC2C411543AC39F797AC3C233FEC295E42B4000649540CB666345D9350CC574220C436867C1434592F8C3EB0C62C3FA2C5642BA6128C359867BC4AFC103448F06A641805175C1DC663F4243579BC4AD316246B7AACAC5BB3846BF046313BF919E4CC0BAEEA040E2602CC48BADF144B68A7AC2CCC40942C27CC7425F637AC2A32AA03FA273FDBF73C614C1F06165406F53C2C395E58E41498284C225B61B4377F40243158EEFC11E25FF42E6D71EC1ECBC72BF0872C53C29CC0240C99992C00B28A642AC4C1DC4F85361C2DD05FBC117722C41A559CA409788D0C3945EABC49FD5D6412B04D84115EBDE4107C009C2845093BE90659D3FE37373C18CA6B4C225BD16417BF42942B41FB344BE455BC4533FC94066350D41A6EC36C161B634C4019689C0617F8EBF8E21C93EF0DA31BFFA527F4396B1C4C20944CDC252E6A942693B2C41C4DB35BF530C08433A9AE34116B337C080E910C01910D843B4B5BE43CB684F4266B4BE42608BB43D06A08B3D89838CC37ADB8FC3DDF440C59C9FBCC43AA8B5C11B2362401BD4AF4401C73B445E972E4252CDACC00F306D3D7043D23CE390F6414077F7C25CA84DC38CDB82C328D7E2414F3D95C3130899444977164483E9B83B05F06B3BAC158B43199D5CC2F6482CC271A93E43856F03C1DAAE1C3FE3228D42663E77C348D65E44C77B9AC3FF336DC28790FC417E9BA3C349C63E440EEE2444B04934442C2EA7C3161390C21A14BCC2AEFF4C42288B4F423E3CD2C216972E446A434544157CBDC2B023964212B925C4593E74C42FD9F5C21A3A7DC31E99C5C25C678DC467A39BC12C4FBDC5121A8FC5381FC7445C69E5C218C9A84103ECDDBFF8899E4000F023C3C8FF3643DE9707C3107B6943B4B286400A00BA42BB4333C161A8894173A225C0716958C0EE0162BD479707BD83AD8D420558B6433D6245C08AA2A4BF133A41425A71AD438F1652C5CB9D90C256FB48411FD011C1D64BB8C27FD5B541C29F82C1C9759CC240C5DEC3248D03C3B5E15C43E8C73FC34EAEA4C2ED7638C2C813E3C443A50EC404315AC0045A55C11ED8BF3E6CB8273E2A6D8141BBF122C036E815434C9776C37498C241AA9EEA42D68BAF43EDD2A1C3BB08AB436E6B78441DDF9C4172DB8841C4EF03436875F042E1E3B542023BD941F48C51C0D2C4414217BAA2C464CA63456EA189C45A51CC439B68033EC960A3BDC34F55C3F2AB1943CEE9F33EF019ED3D679F1A40D24D8C413A0EC64523402C4629F6E54044E74BC1D8F82AC5513755C4A231F8C243B7BD436B9CBC431DD9B4C2505060BFFA086BC0C84CDDC26B42CF44FFA40FC17D1905C1C6AC1C418F7DC3C1165CD5BED990B53D0E9BF643268EE642175A99429FF3A4C208D2F5404D065EC1579FB4BFD9B0DAC033E5B63EA1DCF93E5BBD84410E0412C2FE7D0BC25F92EF3E316297C25B2BD641A939F243D74D8BC497CF243EE672723E151A0ABEF54427BD4A472D449AB5F0447348D04370FEE042FA862CC2F554EF4253542CC279CCE4C2F7E7C1C000F8EE3FB951B44272D842C36A0513C0C95A66C0E7126841EA424EC29908A644170018C3795324BE4FFAFF3FCFF0DA428BD030C2EC988EC33D2A19425B52C543036E59C3155F354574DBDCC3D47ABEC4EA5193C5813E2AC3F1C4DD40D74D27C1D7619CC18B7991C1E4FECD40D78C7842953006431362EFC38172DC4354E142C33ECDDAC156958AC1D1E6E741C0E16C4103D8E7C2498EE34093269BC18F2A43C0D55C2FC1613305C39DC6A9C38AFC4743451E2DC31C8120C25B9D9FC113AE22C28490DF430C825EC26853CAC09324E4C3636C2D438DE1FEC3AB6901C3EB3F87425C6A42C2B66B71C1061587C2F2F8033DD50031BC16DA6D43A095DA440D8881C232FB6AC2AB730EC3AE81834254F2DAC3345B8640119203C07EC888C1E78268BC4DC3DA3B4D854944A192CEC4143ED5C33F72934379DF004371CD73433DCD1EC249265E427E5B8241B9E20CC1ED7BDEC21DF7E843114B01C4930B72C334FA4D4369CF4043915ED2C36CA70F42266EAE423703AAC256C3143B316CD4B99DBC1DC5E2FB3F4493542CC1380E4D4185EC8842AB8E07C4ABB4E2C29D917142A98AEC40CE42CF406DA060C587463FC4E1E20145D354054415056BC2715788C2A3FDE942339BD544E9F005C190751B4238C0F840ABB81641869D024398D836C3B2FDF2C45F80104507908DC2A137AE42CB8D31C4CA16A8C3789020401CFD7DC0EEA72FC36D595F434CA1B442D13DEA41858D03C3FEE39A42F9B0544237048C3FD582B5C0F0085FBFE64143C3A62DA642F1379D40D9902642BD9F64C2C6D19BC1507691C45E313443CA13CBC1CD819CC3F92D0EC33665F642B87ED64157BE61C1E4380B40F0A89540F1182DC05DEB73411F656440B9FCB9BEBCA2FAC1032300439ABFAEC0DF0D24BF3065A5C38CD75DC2225EC743298602C414623CC2DEDFC1C261C19A434D1679C27595024363472AC3D3A26BC1F07623C3CB58BE45E1DBDAC4E5F1AE3CB34A8440EC7202C3789C034500528D44339284C2EC71F6C1E1C874C208E416C112AAC3C2D9BABD422BA4004336BB52C2E8F510417E036BC3E98C18446A3E7C44203381C4ED6974C3217F8F429ED58BC300D34AC2DAFC33C245C80B42611CDCC37B80D2C2316A84422766C54103A6B1BEC76AA53F16573CC3F79F1AC4A49CE6BF5ADBF7BE7D97C4427CB8BF4060D0A544843C6543DB7815459C5A6AC50CED3E42D6EAC2C2B6A04F449A3BABC3A370254201169B41289848C3AC9E45C1C093A63EB131E53EB8D60243279008436B79BEBE051714BE6ECBB64005339241663FCB43FF295843CAA89241D7D3F2C16D595CC2766B5BC3C401C73CFF581BBDD37C0EC20828A542C0B11940A1D961C0F0F60EC2A5B276C3756395C4E1C831425D3856BF682D083F2860644052BEAC40054B6FC49F0635C42C3051C38A0D42C3A70CC7C48567ACC4E60ECCC12245F3414A492043B6BC1E44396608C5EF799D434AEB614452ED40C4AD4286C43EE94B4450BE1B4378F816427F111E41CDC292BF33CEDABF29E4993FC7E748C102CCDA418EE51DC2EC38CAC241184F3F14B83840AFB2F143748C0DC2887DC5C51F5BF845282D3EC4DDE0D7421A008242898A93C3E1920B421313D5C226A9B3439C764344DF9D8543AAEB81C3D3A2DFC2444D38C42BD59943314024C348396DC2DBD8A641D51DE94175FF39C23B76A0C344A5ACC33D52F5C3BFE29540C92D1A4522CC974429992743C95CEF427794F14212FC994355921EC10930F4409BE09BC2312DFDC2006D7D3D6564003E5CF91A4266736AC241C705C21D6248C26E7E0740D61D87C0841B68BD8083953F4FCF42C2A50BDB42053425C4563E81C310EA8541CE47FBC11B84D23FA0CC6540EB62B0C2AC3A8444A7BD89C36E6834C28BEB483F5BB55A3FAE9AA140E1CBA4C16793C04061280D41ABB02643D00884430734B341991F1440EE373740588B9340967DD9C07E6B0240CCB91241D4C1DC3DC6692841EAD4DA4299E067428FC6B8C28B07BAC3FA6F89443F4947BF735FBCC037F016C2A4CA22C238CDEBC3BBE2A6C433770BC3DF57AA42003C84C0F3524640B0A8E4BEBA2EBFBF8F3F0F42F0BD0342"> : tensor<20x30xcomplex<f32>>
    return %0 : tensor<20x30xcomplex<f32>>
  }
  func.func private @integer_pow(%arg0: tensor<20x30xcomplex<f32>>) -> tensor<20x30xcomplex<f32>> {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<20x30xcomplex<f32>>
    %1 = stablehlo.multiply %0, %0 : tensor<20x30xcomplex<f32>>
    return %1 : tensor<20x30xcomplex<f32>>
  }
}
