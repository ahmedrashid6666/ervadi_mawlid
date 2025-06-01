import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'assets.dart';

class Sidedrawer extends StatefulWidget {
  int selectedpage;
  final Function(int) onTabSelected;
  Sidedrawer(this.selectedpage, {required this.onTabSelected, super.key});

  @override
  State<Sidedrawer> createState() => _SidedrawerState();
}

class _SidedrawerState extends State<Sidedrawer>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.selectedpage,
      length: 9,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 112,
              child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ervadi,
                          height: 55,
                          width: 55,
                          color: white,
                        ),
                      ))),
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'مُرَادِي بَيت',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(0); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'أَيَا مَحْبُوب',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(1); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'يٰا وَلِي سَلَامْ عَلَيْكُم',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(2); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'أَيٰا سٰامِي لَدَى الْقٰادِرْ',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(3); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'عَبَّاسْ مَنْترِي بَيت',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(4); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'صَلٰوةٌ وَتَسْلِيمٌ',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(5); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'دُعــــآء',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(6); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'يَا أَكْرَمَ الْخَلْقِ',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(7); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            ListTile(
              trailing: Text(
                '؟',
                style: TextStyle(
                  fontFamily: 'Uthmanic',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'وَاهًا لِلْقُبَّةِ الْخَضْرَاءِ',
                style: TextStyle(
                  fontFamily: 'lpmq',
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                widget.onTabSelected(8); // notify parent to switch to tab 0
                Navigator.of(context).pop(); // or Get.back();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Divider(
                height: 4,
                thickness: 0.1,
                color: Theme.of(context).hintColor,
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: ListTile(
            //     title: Center(
            //         child: Text('CONVO CREATIVES',
            //             style: TextStyle(
            //               fontFamily: 'Uthmanic',
            //               fontSize: 17,
            //               color: widget.darkMode ? myColor : white,
            //             ))),
            //     onTap: () => {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
