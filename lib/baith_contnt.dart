import 'dart:async';
import 'package:ervadi/module/translations.dart';
import 'package:flutter/material.dart';
import 'package:ervadi/tab_bar_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'module/assets.dart';

class BaithContnt extends StatefulWidget {
  bool isDarkTheme;
  bool transbutton;
  List<String> baithTxt;
  List<String> baithTxtTrans;
  final String selectedLanguage;
  final ValueNotifier<bool> showTranslationNotifier;

  final int baithIndex;
  Function(double) onChanged;
  BaithContnt(
      {Key? key,
      this.isDarkTheme = true,
      required this.baithTxt,
      required this.baithTxtTrans,
      required this.selectedLanguage,
      required this.transbutton,
      required this.showTranslationNotifier,
      required this.baithIndex,
      required this.onChanged})
      : super(key: key);

  @override
  State<BaithContnt> createState() => _BaithContntState();
}

class _BaithContntState extends State<BaithContnt> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  Timer? _resumeTimer;
  double _scrollSpeed = 0.0; // pixels per tick; 0 = stopped
  bool _userInteracting = false; // true while the user is dragging manually

  @override
  void initState() {
    _loadSpeed();
    _restoreScrollPosition();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      tabsBarPage.saveScrollPosition(
          widget.baithIndex, _scrollController.offset);
    }
  }

  Future<void> _restoreScrollPosition() async {
    final offset = await tabsBarPage.loadScrollPosition(widget.baithIndex);
    if (offset > 0 && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(offset);
        }
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Pauses auto-scroll while the user drags, and resumes it after they let go.
  bool _handleUserScroll(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      // User physically grabbed the list.
      _userInteracting = true;
      _resumeTimer?.cancel();
    } else if (notification is ScrollEndNotification && _userInteracting) {
      // User released; resume after a short pause (also lets any fling settle).
      _scheduleResume();
    }
    return false;
  }

  void _scheduleResume() {
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      // If the list is still coasting from a fling, wait a bit more.
      if (_scrollController.hasClients &&
          _scrollController.position.isScrollingNotifier.value) {
        _scheduleResume();
        return;
      }
      _userInteracting = false;
      if (_scrollSpeed > 0) _startAutoScroll();
    });
  }

  Future<void> _loadSpeed() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSpeed = prefs.getDouble('scroll_speed') ?? 0.0;
    setState(() => _scrollSpeed = savedSpeed);

    if (savedSpeed > 0) {
      _startAutoScroll();
    }
  }

  Future<void> _saveSpeed(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('scroll_speed', value);
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_scrollSpeed <= 0) return;
    // ~60fps ticks with tiny jumpTo steps: smooth, and never fights a manual
    // drag (jumpTo has no running animation to collide with the gesture).
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 16), (t) {
      if (!_scrollController.hasClients) return;
      // Don't fight the user while they're dragging manually or flinging.
      if (_userInteracting) return;
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      if (current >= max) {
        t.cancel();
        return;
      }
      final step = _scrollSpeed * 0.32; // pixels per frame; matches old speed
      _scrollController.jumpTo((current + step).clamp(0.0, max));
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  // Safe translation lookup: prevents RangeError when the selected
  // language list is shorter than the baith text (some baiths have more
  // lines than there are translations). Returns '' when out of range.
  String _trans(int index) {
    // Only the first baith (Muraadi) has translations; the rest have none,
    // so we never show another baith's translation, and blanks are hidden.
    if (widget.baithIndex != 0) return '';
    final list = TranslationData.getTranslation(widget.selectedLanguage);
    if (index < 0 || index >= list.length) return '';
    final t = list[index];
    return t.trim().isEmpty ? '' : t;
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSize>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Row(
        children: [
          // Original ListView but using _scrollController
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleUserScroll,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 6, bottom: 75),
                physics: const BouncingScrollPhysics(),
                itemCount: widget.baithTxt.length,
                itemBuilder: (context, index) {
                  int indexPlus = index + 1;

                  // First two lines are the green "header" couplet; the rest are
                  // white content tiles. Both are now rounded cards with margin.
                  if (index < 2) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: white.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                          title: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 8),
                        child: indexPlus.isOdd
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Expanded(
                                        child: Consumer<FontSize>(
                                          builder:
                                              (context, fontSize, child) {
                                            return Text(
                                              widget.baithTxt[index],
                                              style: TextStyle(
                                                fontFamily: 'Amiri',
                                                fontWeight: FontWeight.bold,
                                                color: white, // <- unchanged
                                                fontSize: fontSize.fontSize,
                                              ),
                                              textDirection:
                                                  TextDirection.rtl,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Translation, only if toggled ON
                                  ValueListenableBuilder<bool>(
                                    valueListenable:
                                        widget.showTranslationNotifier,
                                    builder:
                                        (context, showTranslation, child) {
                                      if (!showTranslation || _trans(index).isEmpty)
                                        return const SizedBox();
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          _trans(index),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                          textDirection: TextDirection.ltr,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      Expanded(
                                        child: Consumer<FontSize>(
                                          builder:
                                              (context, fontSize, child) {
                                            return Text(
                                              widget.baithTxt[index],
                                              style: TextStyle(
                                                fontFamily: 'Amiri',
                                                fontWeight: FontWeight.bold,
                                                color: white, // <- unchanged
                                                fontSize: fontSize.fontSize,
                                              ),
                                              textDirection:
                                                  TextDirection.ltr,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Translation, only if toggled ON
                                  ValueListenableBuilder<bool>(
                                    valueListenable:
                                        widget.showTranslationNotifier,
                                    builder:
                                        (context, showTranslation, child) {
                                      if (!showTranslation || _trans(index).isEmpty)
                                        return const SizedBox();
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            _trans(index),
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      )),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 8),
                          child: indexPlus.isOdd
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Expanded(
                                              child: Consumer<FontSize>(
                                            builder:
                                                (context, provider, child) {
                                              return Text(
                                                widget.baithTxt[index],
                                                style: TextStyle(
                                                  fontFamily: 'Amiri',
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColorDark, // <- unchanged
                                                  fontSize: fontSize.fontSize,
                                                ),
                                                textDirection:
                                                    TextDirection.rtl,
                                              );
                                            },
                                          ))
                                        ]),

                                    // Translation, only if toggled ON
                                    ValueListenableBuilder<bool>(
                                      valueListenable:
                                          widget.showTranslationNotifier,
                                      builder:
                                          (context, showTranslation, child) {
                                        if (!showTranslation || _trans(index).isEmpty)
                                          return const SizedBox();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            _trans(index),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark, // <- unchanged
                                              fontSize: 16,
                                            ),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                        textDirection: TextDirection.ltr,
                                        children: [
                                          Consumer<FontSize>(
                                            builder:
                                                (context, provider, child) {
                                              return Text(
                                                widget.baithTxt[index],
                                                style: TextStyle(
                                                  fontFamily: 'Amiri',
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColorDark, // <- unchanged
                                                  fontSize: fontSize.fontSize,
                                                ),
                                                textDirection:
                                                    TextDirection.ltr,
                                              );
                                            },
                                          ),
                                        ]),
                                    // Translation, only if toggled ON
                                    ValueListenableBuilder<bool>(
                                      valueListenable:
                                          widget.showTranslationNotifier,
                                      builder:
                                          (context, showTranslation, child) {
                                        if (!showTranslation || _trans(index).isEmpty)
                                          return const SizedBox();
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              _trans(index),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorDark, // <- unchanged
                                                fontSize: 16,
                                              ),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          // Right-side vertical slider with fixed width
          Container(
            width: 40, // adjust width as needed
            color: Colors.transparent, // optional
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_upward,
                  size: 14,
                  color: white,
                ),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _scrollSpeed,
                      min: 0,
                      max: 12,
                      divisions: 24,
                      onChanged: (val) {
                        setState(() => _scrollSpeed = val);
                        _saveSpeed(val);
                        if (val > 0) {
                          _startAutoScroll();
                        } else {
                          _stopAutoScroll();
                        }
                        try {
                          widget.onChanged(val);
                        } catch (_) {}
                      },
                    ),
                  ),
                ),
                const Icon(Icons.arrow_downward, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
