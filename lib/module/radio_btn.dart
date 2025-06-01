import 'package:flutter/material.dart';
import 'package:ervadi/module/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'assets.dart';

class RadioBtn extends StatefulWidget {
  bool darkMode;
  RadioBtn({@required this.darkMode = false}) : super();
  @override
  _RadioBtnState createState() => _RadioBtnState();
}

class _RadioBtnState extends State<RadioBtn> {
  late SharedPreferences _prefs;
  late ThemeProvider _themeProvider;
  late bool _darkThemeSelected;
  void initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _darkThemeSelected = _themeProvider.getTheme() == _themeProvider.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Styles",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
      Container(
        child: Consumer<ThemeProvider>(builder: (context, value, child) {
          return Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  tileColor: Theme.of(context).primaryColorDark,
                  selectedTileColor: Theme.of(context).primaryColorDark,
                  title: const Text(
                    'Light',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  value: false,
                  groupValue: _darkThemeSelected,
                  onChanged: (value) {
                    setState(() {
                      _darkThemeSelected = value!;
                      _themeProvider.selectedTheme = _themeProvider.light;
                      _themeProvider.notifyListeners();
                      _themeProvider.prefs.setBool("darkTheme", false);
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  tileColor: Theme.of(context).primaryColorDark,
                  selectedTileColor: Theme.of(context).primaryColorDark,
                  title: const Text(
                    'Dark',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  value: true,
                  groupValue: _darkThemeSelected,
                  onChanged: (value) {
                    setState(() {
                      _darkThemeSelected = value!;
                      _themeProvider.selectedTheme = _themeProvider.dark;
                      _themeProvider.notifyListeners();
                      _themeProvider.prefs.setBool("darkTheme", true);
                    });
                  },
                ),
              ),
            ],
          );
        }),
      )
    ]);
  }
}
