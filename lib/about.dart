import 'package:ervadi/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'module/assets.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: Text(
          'About Page',
          style: TextStyle(
            fontFamily: 'lpmq',
            fontSize: 22,
          ),
          textDirection: TextDirection.ltr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: SvgPicture.asset(
                sulthaniyyalogo,
                color: darkMode ? white : white,
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   'About',
                  //   style: TextStyle(
                  //     fontSize: 30.0,
                  //     fontWeight: FontWeight.bold,
                  //     color: darkMode ? white : ltWhite,
                  //   ),
                  // ),
                  SizedBox(height: 20.0),
                  Text(
                    '''ഏര്‍വാടി ശുഹദാക്കള്‍

ദക്ഷിണ ഇന്ത്യയിലെ പ്രധാന മുസ്ലിം തീര്‍ത്ഥാടന കേന്ദ്രങ്ങളില്‍ ഒന്നാണ് തമിഴ്നാട്ടിലെ രാമനാഥപുരം ജില്ലയിലെ ഏര്‍വാടി ദര്‍ഗ്ഗാ ശരീഫ്. മദീനയില്‍ നിന്നും ലോക നേതാവ് സയ്യിദുനാ മുഹമ്മദ് മുസ്തഫ  തങ്ങളുടെ നിര്‍ദ്ദേശപ്രകാരം ദീനീ ദഅ്വത്തിനായി ഇന്ത്യയിലെത്തുകയും ഇവിടെ ഭരണം നടത്തി അവസാനം ദീനിനും രാജ്യത്തിനും വേണ്ടി എതിരാളികളോട് യുദ്ധം ചെയ്ത് ശഹീദാവുകയും ചെയ്ത ഖുത്ബുസ്സുല്‍താന്‍ സയ്യിദ് ഇബ്രാഹീം ബാദ്ഷാ رضي الله عنه വും അനുയായികളായ മറ്റ് അനേകം ശുഹദാക്കളുമാണ് ഏര്‍വാടിയിലുള്ളത്.
''അള്ളാഹുവിന്റെ വഴിയില്‍ ജീവന്‍ ത്യജിച്ചവരെ മരിച്ചവരെന്ന് നിങ്ങള്‍ പറയരുത്.  അവര്‍ ജീവിച്ചിരിക്കുന്നവരാണ്'' എന്ന ഖുര്‍ആന്‍ വാചകം അക്ഷരാര്‍ത്ഥത്തില്‍ പുലരുന്നതാണ് ഏര്‍വാടിയിലെ കാഴ്ചകള്‍. അഭയം തേടിയെത്തുന്നവരുടെ വിഷയങ്ങളില്‍ ശുഹദാക്കള്‍ ഇടപെടുന്ന രീതി ഏതു നിഷേധിയേയും അത്ഭുതപ്പെടുത്തും.
ഏര്‍വാടി ദര്‍ഗ്ഗാ ശരീഫിന്റെ ചാരത്ത് കഞ്ഞിപ്പള്ളി റോഡില്‍ സാറാ ഉമ്മ മഖാമിന്റെ സമീപം സ്ഥിതി ചെയ്യുന്ന സ്ഥാപനമാണ് മര്‍കസു സുല്‍താനിയ്യ എന്ന ' ഏര്‍വാടി മര്‍കസ് '. മഹാന്മാരായ സാദാത്തിന്റെയും പണ്ഡിതരുടെയും അനുഗ്രഹ-ആശീര്‍വാദങ്ങളോടെ സ്ഥാപിക്കുകയും പരിപാലിക്കുകയും ചെയ്യുന്ന ഈ മഹത് സ്ഥാപനത്തിനു കീഴില്‍ ദര്‍ഗ്ഗയിലെത്തുന്ന നിരവധി ജനങ്ങള്‍ക്ക് വിജ്ഞാനവും ഭക്ഷണവും മറ്റ് സൗകര്യങ്ങളും ദൈനംദിനം ചെയ്തു വരുന്നു.
മഹാന്‍മാരുടെ ബറകതിനാല്‍ അല്ലാഹു ഈ സ്ഥാപനത്തെ ഉന്നതിയില്‍ നിലനിര്‍ത്തട്ടെ, ആമീന്‍...''',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      color: darkMode ? white : ltWhite,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
