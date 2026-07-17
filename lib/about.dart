import 'package:ervadi/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'module/assets.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
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
                color: isDarkTheme ? white : white,
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
                    '''ഏൽവാടി ശുഹദാക്കൾ

ദക്ഷിണ ഇന്ത്യയിലെ പ്രധാന മുസ്ലിം തീൽത്ഥാടന കേന്ദ്രങ്ങളിർ ഒന്നാണ് തമിഴ്നാട്ടിലെ രാമനാഥപുരം ജില്ലയിലെ ഏൽവാടി ദൽഗ്ഗാ ശരീഫ്. മദീനയിർ നിന്നും ലോക നേതാവ് സയ്യിദുനാ മുഹമ്മദ് മുസ്തഫ  തങ്ങളുടെ നിൽദ്ദേശപ്രകാരം ദീനീ ദഅ്വത്തിനായി ഇന്ത്യയിലെത്തുകയും ഇവിടെ ഭരണം നടത്തി അവസാനം ദീനിനും രാജ്യത്തിനും വേണ്ടി എതിരാളികളോട് യുദ്ധം ചെയ്ത് ശഹീദാവുകയും ചെയ്ത ഖുത്ബുസ്സുർതാൻ സയ്യിദ് ഇബ്രാഹീം ബാദ്ഷാ رضي الله عنه വും അനുയായികളായ മറ്റ് അനേകം ശുഹദാക്കളുമാണ് ഏൽവാടിയിലുള്ളത്.
''അള്ളാഹുവിന്റെ വഴിയിർ ജീവൻ ത്യജിച്ചവരെ മരിച്ചവരെന്ന് നിങ്ങൾ പറയരുത്.  അവൽ ജീവിച്ചിരിക്കുന്നവരാണ്'' എന്ന ഖുൽആൻ വാചകം അക്ഷരാൽത്ഥത്തിർ പുലരുന്നതാണ് ഏൽവാടിയിലെ കാഴ്ചകൾ. അഭയം തേടിയെത്തുന്നവരുടെ വിഷയങ്ങളിർ ശുഹദാക്കൾ ഇടപെടുന്ന രീതി ഏതു നിഷേധിയേയും അത്ഭുതപ്പെടുത്തും.
ഏൽവാടി ദൽഗ്ഗാ ശരീഫിന്റെ ചാരത്ത് കഞ്ഞിപ്പള്ളി റോഡിർ സാറാ ഉമ്മ മഖാമിന്റെ സമീപം സ്ഥിതി ചെയ്യുന്ന സ്ഥാപനമാണ് മൽകസു സുർതാനിയ്യ എന്ന ' ഏൽവാടി മൽകസ് '. മഹാന്മാരായ സാദാത്തിന്റെയും പണ്ഡിതരുടെയും അനുഗ്രഹ-ആശീൽവാദങ്ങളോടെ സ്ഥാപിക്കുകയും പരിപാലിക്കുകയും ചെയ്യുന്ന ഈ മഹത് സ്ഥാപനത്തിനു കീഴിർ ദൽഗ്ഗയിലെത്തുന്ന നിരവധി ജനങ്ങൾക്ക് വിജ്ഞാനവും ഭക്ഷണവും മറ്റ് സൗകര്യങ്ങളും ദൈനംദിനം ചെയ്തു വരുന്നു.
മഹാൻമാരുടെ ബറകതിനാർ അല്ലാഹു ഈ സ്ഥാപനത്തെ ഉന്നതിയിർ നിലനിൽത്തട്ടെ, ആമീൻ...''',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      color: isDarkTheme ? white : ltWhite,
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
