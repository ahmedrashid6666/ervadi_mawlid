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
                  _profileSection(context, isDarkTheme),
                  SizedBox(height: 28.0),
                  Text(
                    '''ഏര്‍വാടി ശുഹദാക്കള്‍

ദക്ഷിണ ഇന്ത്യയിലെ പ്രധാന മുസ്ലിം തീര്‍ത്ഥാടന കേന്ദ്രങ്ങളില്‍ ഒന്നാണ് തമിഴ്നാട്ടിലെ രാമനാഥപുരം ജില്ലയിലെ ഏര്‍വാടി ദര്‍ഗ്ഗാ ശരീഫ്. മദീനയില്‍ നിന്നും ലോക നേതാവ് സയ്യിദുനാ മുഹമ്മദ് മുസ്തഫ  തങ്ങളുടെ നിര്‍ദ്ദേശപ്രകാരം ദീനീ ദഅ്വത്തിനായി ഇന്ത്യയിലെത്തുകയും ഇവിടെ ഭരണം നടത്തി അവസാനം ദീനിനും രാജ്യത്തിനും വേണ്ടി എതിരാളികളോട് യുദ്ധം ചെയ്ത് ശഹീദാവുകയും ചെയ്ത ഖുത്ബുസ്സുല്‍താന്‍ സയ്യിദ് ഇബ്രാഹീം ബാദ്ഷാ رضي الله عنه വും അനുയായികളായ മറ്റ് അനേകം ശുഹദാക്കളുമാണ് ഏര്‍വാടിയിലുള്ളത്.
''അള്ളാഹുവിന്റെ വഴിയില്‍ ജീവന്‍ ത്യജിച്ചവരെ മരിച്ചവരെന്ന് നിങ്ങള്‍ പറയരുത്.  അവര്‍ ജീവിച്ചിരിക്കുന്നവരാണ്'' എന്ന ഖുര്‍ആന്‍ വാചകം അക്ഷരാര്‍ത്ഥത്തില്‍ പുലരുന്നതാണ് ഏര്‍വാടിയിലെ കാഴ്ചകള്‍. അഭയം തേടിയെത്തുന്നവരുടെ വിഷയങ്ങളില്‍ ശുഹദാക്കള്‍ ഇടപെടുന്ന രീതി ഏതു നിഷേധിയേയും അത്ഭുതപ്പെടുത്തും.
ഏര്‍വാടി ദര്‍ഗ്ഗാ ശരീഫിന്റെ ചാരത്ത് കഞ്ഞിപ്പള്ളി റോഡില്‍ സാറാ ഉമ്മ മഖാമിന്റെ സമീപം സ്ഥിതി ചെയ്യുന്ന സ്ഥാപനമാണ് മര്‍കസു സുല്‍താനിയ്യ എന്ന ' ഏര്‍വാടി മര്‍കസ് '. മഹാന്മാരായ സാദാത്തിന്റെയും പണ്ഡിതരുടെയും അനുഗ്രഹ-ആശീര്‍വാദങ്ങളോടെ സ്ഥാപിക്കുകയും പരിപാലിക്കുകയും ചെയ്യുന്ന ഈ മഹത് സ്ഥാപനത്തിനു കീഴില്‍ ദര്‍ഗ്ഗയിലെത്തുന്ന നിരവധി ജനങ്ങള്‍ക്ക് വിജ്ഞാനവും ഭക്ഷണവും മറ്റ് സൗകര്യങ്ങളും ദൈനംദിനം ചെയ്തു വരുന്നു.
മഹാന്‍മാരുടെ ബറകതിനാല്‍ അല്ലാഹു ഈ സ്ഥാപനത്തെ ഉന്നതിയില്‍ നിലനിര്‍ത്തട്ടെ, ആമീന്‍...''',
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

  // Biographical profile of Qutub Sultan Sayyed Ibrahim Badusha Shaheed (R).
  Widget _profileSection(BuildContext context, bool isDarkTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: amber.withOpacity(0.30), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Arabic title couplet
          Text(
            'أَنَا السُّلْطَانُ إِبْرَاهِيمُ اسْمِي\nإِلَى خَيْرِ الْبَرِيَّةِ انْتِمَائِي',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              height: 1.6,
              color: amber,
            ),
          ),
          const SizedBox(height: 14),
          // Full name / heading
          Text(
            'ഖുത്ബുസ്സുൽത്താൻ സയ്യിദ് ഇബ്രാഹീം ബാദ്ഷാ ശഹീദ് ബ്‌റുവാദി رضي الله عنه',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.5,
              color: isDarkTheme ? white : white,
            ),
          ),
          const SizedBox(height: 12),
          // Urus badge
          Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: amber.withOpacity(0.90),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'അറൂസ് മുബാറക് 851  •  عروس مبارك ٨٥١',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blk,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: amber.withOpacity(0.25), thickness: 1),
          const SizedBox(height: 8),
          // Detail rows
          _detailRow(context, 'ജനനം', '541 ഹിജ്‌റ'),
          _detailRow(context, 'പിതാവ്', 'സയ്യിദ് അഹ്മദ് (റ)'),
          _detailRow(context, 'മാതാവ്', 'സയ്യിദത്ത് ഫാത്തിമ (റ)'),
          _detailRow(context, 'ഭാര്യ', 'സയ്യിദത്ത് അലി ഫാത്തിമ (റ)'),
          _detailRow(
            context,
            'സന്താനങ്ങൾ',
            'ഖുതുബ് സയ്യിദ് അബൂ താഹിർ ശഹീദ് (റ)\nസൈനുൽ ആബിദീൻ (റ)',
          ),
          _detailRow(context, 'സഹോദരി', 'സയ്യിദത്ത് റാബിഅ (റ)'),
          _detailRow(context, 'സ്വദേശം', 'ഉർവ, മദീന'),
          _detailRow(
            context,
            'പരമ്പര',
            'മുത്ത് നബി ﷺ തങ്ങളുടെ 17-ാം പേരമകൻ',
          ),
          _detailRow(
            context,
            'ഇന്ത്യയിൽ ആദ്യം വന്ന സ്ഥലം',
            'സിസ് (ഗുജറാത്ത്)',
          ),
          _detailRow(
            context,
            'മഖാം',
            'ഏർവാടി (ഭൂത്രമാണിക്ക പട്ടണം), രാമനാഥപുരം ജില്ല, തമിഴ്‌നാട്',
          ),
          _detailRow(context, 'കൊടി മരം വന്ന രാജ്യം', 'ഭർമ (ബർമ)'),
          _detailRow(
            context,
            'ചരിത്ര കൃതി',
            'ശഹാദത്തേ നാമാ (ഫാരിസി)\nരചയിതാവ്: അബ്ബാസ് (തുർക്കി)',
          ),
          _detailRow(
            context,
            'വഫാത്ത്',
            '23 ദുൽ ഖഅ്ദ ഹിജ്‌റ 596 (തിങ്കൾ ശഹീദായ ദിനം)',
          ),
        ],
      ),
    );
  }

  // A single "label : value" row in the profile section.
  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                height: 1.4,
                color: amber,
              ),
            ),
          ),
          const Text(
            ':  ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: amber,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                height: 1.45,
                color: white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
