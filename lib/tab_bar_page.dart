import 'package:ervadi/module/assets.dart';
import 'package:ervadi/module/sidedrawer.dart';
import 'package:ervadi/module/string.dart';
import 'package:ervadi/module/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'baith_contnt.dart';
import 'module/radio_btn.dart';
import 'module/audio_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';

class FontSize with ChangeNotifier {
  double _fontSize = 25;

  double get fontSize => _fontSize;

  set fontSize(double value) {
    _fontSize = value;
    notifyListeners();
    saveFontSize(value);
  }

  void saveFontSize(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', value);
  }

  Future<void> loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 25;
    notifyListeners();
  }

  @override
  void dispose() {
    saveFontSize(_fontSize);
    super.dispose();
  }
}

class tabsBarPage extends StatefulWidget {
  bool isDarkTheme;
  int selectedpage;
  double textSize;
  bool transbutton;

  final ValueNotifier<bool> showTranslationNotifier;

  tabsBarPage({
    required this.selectedpage,
    required this.showTranslationNotifier,
    this.textSize = 15,
    this.isDarkTheme = false,
    this.transbutton = false,
  });

  @override
  State<tabsBarPage> createState() => _tabsBarPageState();
}

class _tabsBarPageState extends State<tabsBarPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int currentTabIndex = 0;

  // Add the selectedLanguage variable
  String selectedLanguage = '';
  bool _showAudioPlayer = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.selectedpage,
      length: 9,
      vsync: this,
    );

    // Load initial audio
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAudioWithFeedback(widget.selectedpage, showLoading: false);
    });

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          currentTabIndex = _tabController.index;
        });
        // Switch audio on tab change
        _loadAudioWithFeedback(_tabController.index);
      }
    });
    _loadTranslationToggle();
    _loadLanguagePreference();
  }

  Future<void> _loadAudioWithFeedback(int index,
      {bool showLoading = true}) async {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    if (showLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Loading audio...'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    try {
      await audioProvider.loadAudio(index);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading audio: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _saveTranslationToggle(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showTranslation', value);
  }

  Future<void> _loadTranslationToggle() async {
    final prefs = await SharedPreferences.getInstance();
    bool show = prefs.getBool('showTranslation') ??
        false; // Default to false (no translation)
    widget.showTranslationNotifier.value = show;
  }

  void _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('selectedLanguage') ?? '';
    print('Loaded language preference: $language');
    setState(() {
      selectedLanguage = language;
    });
  }

  void _saveLanguagePreference(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    print('Saved language preference: $language');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabBar get _tabBar => TabBar(
        tabAlignment: TabAlignment.start,
        indicatorColor: blk,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
        controller: _tabController,
        labelStyle: TextStyle(fontSize: 22),
        isScrollable: true,
        tabs: [
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '١',
            img: nmbrborder,
            tabtext: 'مُرَادِي بَيت',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٢',
            img: nmbrborder,
            tabtext: 'أَيَا مَحْبُوب',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٣',
            img: nmbrborder,
            tabtext: 'يٰا وَلِي سَلَامْ عَلَيْكُم',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٤',
            img: nmbrborder,
            tabtext: 'أَيٰا سٰامِي لَدَى الْقٰادِرْ',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٥',
            img: nmbrborder,
            tabtext: 'عَبَّاسْ مَنْترِي بَيت',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٦',
            img: nmbrborder,
            tabtext: 'صَلٰوةٌ وَتَسْلِيمٌ',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٧',
            img: nmbrborder,
            tabtext: 'دُعــــآء',
          )),
          Tab(
              child: IconWithText(
            isDarkTheme: widget.isDarkTheme,
            no: '٨',
            img: nmbrborder,
            tabtext: 'يَا أَكْرَمَ الْخَلْقِ',
          )),
          Tab(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconWithText(
              isDarkTheme: widget.isDarkTheme,
              line: false,
              no: '٩',
              img: nmbrborder,
              tabtext: 'وَاهًا لِلْقُبَّةِ الْخَضْرَاءِ',
            ),
          )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSize>(context);
    final ValueNotifier<bool> showTranslationNotifier = ValueNotifier(false);
    return DefaultTabController(
      initialIndex: widget.selectedpage,
      length: 9,
      child: Scaffold(
        extendBody: true,
        key: _scaffoldKey,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          padding: EdgeInsets.zero,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: _showAudioPlayer ? 150 : 100,
            padding: const EdgeInsets.only(top: 2, bottom: 12),
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                if (_showAudioPlayer) ...[
                  // Audio Player Progress Bar
                  Consumer<AudioProvider>(
                    builder: (context, audioProvider, child) {
                      return StreamBuilder<Duration?>(
                        stream: audioProvider.player.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          return StreamBuilder<Duration?>(
                            stream: audioProvider.player.durationStream,
                            builder: (context, snapshot) {
                              final duration = snapshot.data ?? Duration.zero;
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: ProgressBar(
                                  progress: position,
                                  total: duration,
                                  barHeight: 4.0,
                                  thumbRadius: 7.0,
                                  progressBarColor: Colors.amber,
                                  bufferedBarColor:
                                      Colors.amber.withOpacity(0.3),
                                  baseBarColor: Colors.white.withOpacity(0.2),
                                  thumbColor: Colors.amber,
                                  timeLabelLocation: TimeLabelLocation.sides,
                                  timeLabelTextStyle: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onSeek: (duration) {
                                    audioProvider.player.seek(duration);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            // Home button
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: SvgPicture.asset(
                                  home,
                                  height: 20,
                                  color: white,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            // SINGLE Translation button
                            PopupMenuButton<String>(
                              icon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.translate,
                                      color: white, size: 23),
                                  const SizedBox(width: 4),
                                  Text(
                                    selectedLanguage.isNotEmpty
                                        ? selectedLanguage
                                            .substring(0, 2)
                                            .toUpperCase()
                                        : 'Lang',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              onSelected: (String language) async {
                                setState(() {
                                  selectedLanguage = language;
                                });
                                if (language.isEmpty) {
                                  widget.showTranslationNotifier.value = false;
                                  _saveTranslationToggle(false);
                                  _saveLanguagePreference('');
                                } else {
                                  widget.showTranslationNotifier.value = true;
                                  _saveTranslationToggle(true);
                                  _saveLanguagePreference(language);
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem<String>(
                                  value: 'Malayalam',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.language, size: 20),
                                      const SizedBox(width: 8),
                                      const Text('Malayalam'),
                                      if (selectedLanguage == 'Malayalam')
                                        const Spacer(),
                                      if (selectedLanguage == 'Malayalam')
                                        const Icon(Icons.check,
                                            color: Colors.green),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: '',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.translate, size: 20),
                                      const SizedBox(width: 8),
                                      const Text('No Translation'),
                                      if (selectedLanguage.isEmpty)
                                        const Spacer(),
                                      if (selectedLanguage.isEmpty)
                                        const Icon(Icons.check,
                                            color: Colors.green),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Audio Toggle/Controls
                            Consumer<AudioProvider>(
                              builder: (context, audioProvider, child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (_showAudioPlayer) ...[
                                      StreamBuilder<PlayerState>(
                                        stream: audioProvider
                                            .player.playerStateStream,
                                        builder: (context, snapshot) {
                                          final playerState = snapshot.data;
                                          final processingState =
                                              playerState?.processingState;
                                          final playing = playerState?.playing;

                                          if (processingState ==
                                                  ProcessingState.loading ||
                                              processingState ==
                                                  ProcessingState.buffering) {
                                            return const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(white),
                                              ),
                                            );
                                          } else if (playing != true) {
                                            return IconButton(
                                              icon: const Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: white,
                                                  size: 30),
                                              onPressed: audioProvider.play,
                                            );
                                          } else {
                                            return IconButton(
                                              icon: const Icon(
                                                  Icons.pause_rounded,
                                                  color: white,
                                                  size: 30),
                                              onPressed: audioProvider.pause,
                                            );
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.stop_rounded,
                                            color: white, size: 28),
                                        onPressed: () {
                                          audioProvider.stop();
                                          setState(
                                              () => _showAudioPlayer = false);
                                        },
                                      ),
                                    ] else
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(
                                            Icons.music_note_rounded,
                                            color: white,
                                            size: 28),
                                        onPressed: () {
                                          setState(
                                              () => _showAudioPlayer = true);
                                        },
                                      ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              iconSize: 28,
                              icon: SvgPicture.asset(
                                fontsz,
                                height: 24,
                                color: widget.isDarkTheme ? white : ltWhite,
                                fit: BoxFit.fitHeight,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: trsnprnt,
                                  useRootNavigator: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BottomModalSheet(
                                      radiobtndark: widget.isDarkTheme,
                                      isDarkTheme: widget.isDarkTheme,
                                      fontsize: fontSize.fontSize,
                                      onChanged: (double newValue) {
                                        setState(() {
                                          widget.textSize = newValue;
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 28,
                      padding: const EdgeInsets.only(right: 28.0),
                      icon: SvgPicture.asset(
                        menu,
                        height: 20,
                        color: white,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        endDrawer: Sidedrawer(
          currentTabIndex,
          onTabSelected: (int index) {
            _tabController.animateTo(index);
            setState(() => currentTabIndex = index);
          },
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 95,
                    titleSpacing: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    flexibleSpace: Container(
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
                    ),
                    centerTitle: true,
                    title: SvgPicture.asset(
                      ervadi,
                      height: 55,
                      width: 55,
                      color: white,
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.menu,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                    pinned: true,
                    bottom: PreferredSize(
                        preferredSize: _tabBar.preferredSize,
                        child: ColoredBox(
                          color: widget.isDarkTheme ? white : ltWhite,
                          child: _tabBar,
                        )),
                  ),
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                // FIXED: Pass the correct selectedLanguage to BaithContnt
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: first, // Make sure 'first' is defined
                  baithTxtTrans:
                      TranslationData.getTranslation(selectedLanguage),
                  transbutton: true,
                  showTranslationNotifier: widget.showTranslationNotifier,
                  onChanged: (double value) {
                    // Handle font size change if needed
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: scnd,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: thrd,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: frth,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: fifth,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: sixth,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: aameen,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: yaAkrama,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
                BaithContnt(
                  selectedLanguage: selectedLanguage,
                  isDarkTheme: widget.isDarkTheme,
                  baithTxt: kundoor,
                  baithTxtTrans: firsttrans,
                  showTranslationNotifier: showTranslationNotifier,
                  transbutton: false,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.textSize = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomModalSheet extends StatefulWidget {
  final bool isDarkTheme;
  final bool radiobtndark;
  final double fontsize;
  final ValueChanged<double> onChanged;

  BottomModalSheet({
    required this.radiobtndark,
    required this.fontsize,
    required this.isDarkTheme,
    required this.onChanged,
  });

  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSize>(context);

    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RadioBtn(
                isDarkTheme: widget.radiobtndark,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Text Size',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 20.0),
                        ),
                        child: Consumer<FontSize>(
                          builder: (context, provider, child) {
                            return Slider(
                              value: fontSize._fontSize,
                              activeColor: white,
                              min: 15,
                              max: 32,
                              divisions: 10,
                              onChanged: (double value) {
                                setState(() {
                                  fontSize._fontSize = value;
                                });
                                widget.onChanged(value);
                              },
                            );
                          },
                        ),
                      )),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      '${fontSize._fontSize.toInt()}  px',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class IconWithText extends StatelessWidget {
  final String img;
  final String no;
  final String tabtext;
  bool isDarkTheme;
  bool line;

  IconWithText(
      {this.line = true,
      required this.tabtext,
      required this.img,
      required this.no,
      required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return line
        ? Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: SvgPicture.asset(
                      img,
                      width: 30,
                      color: Theme.of(context).primaryColor,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      no,
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'lpmq',
                        color: isDarkTheme ? white : ltWhite,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                '${(tabtext)}',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'lpmq',
                  color: blk,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 6, bottom: 6),
                child: VerticalDivider(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        : Row(children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: SvgPicture.asset(
                    img,
                    width: 30,
                    color: Theme.of(context).primaryColor,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    no,
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'lpmq',
                      color: isDarkTheme ? white : ltWhite,
                    ),
                  ),
                )
              ],
            ),
            Text(
              '${(tabtext)}',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'lpmq',
                color: blk,
              ),
            ),
          ]);
  }
}

// Widget _individualTab(String imagePath) {
//   return Container(
//       height: 50,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border(
//           right: BorderSide(color: white, width: 0, style: BorderStyle.solid),
//         ),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Tab(
//             icon: IconWithText(isDarkTheme: ,),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               color: mainColor,
//               width: 1,
//               height: 25,
//             ),
//           )
//         ],
//       ));
// }
