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

  Function(double) onChanged;
  BaithContnt(
      {Key? key,
      this.isDarkTheme = true,
      required this.baithTxt,
      required this.baithTxtTrans,
      required this.selectedLanguage,
      required this.transbutton,
      required this.showTranslationNotifier,
      required this.onChanged})
      : super(key: key);

  @override
  State<BaithContnt> createState() => _BaithContntState();
}

class _BaithContntState extends State<BaithContnt> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  double _scrollSpeed = 0.0; // pixels per tick; 0 = stopped

  @override
  void initState() {
    _loadSpeed();
    super.initState();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
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
    // smaller duration for smoother movement; adjust if needed
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      if (!_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      final next = (current + _scrollSpeed).clamp(0.0, max);
      // use animateTo for smoothness (catch exceptions when disposed)
      _scrollController.animateTo(next,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      if (next >= max) {
        t.cancel();
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
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
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 75),
              physics: const BouncingScrollPhysics(),
              itemCount: widget.baithTxt.length,
              itemBuilder: (context, index) {
                int indexPlus = index + 1;

                // Keep your original color logic and structure intact:
                if (index < 2) {
                  return Container(
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
                    child: Column(
                      children: [
                        ListTile(
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
                                                  fontFamily: 'lpmq',
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
                                        if (!showTranslation)
                                          return const SizedBox();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            TranslationData.getTranslation(
                                                widget.selectedLanguage)[index],
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
                                                  fontFamily: 'lpmq',
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
                                        if (!showTranslation)
                                          return const SizedBox();
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              TranslationData.getTranslation(
                                                  widget
                                                      .selectedLanguage)[index],
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
                        Divider(
                          height: 1,
                          thickness: 0.1,
                          color:
                              widget.isDarkTheme ? white : ltWhite, // <- unchanged
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Column(
                      children: [
                        ListTile(
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
                                            Expanded(child: Consumer<FontSize>(
                                              builder:
                                                  (context, provider, child) {
                                                return Text(
                                                  widget.baithTxt[index],
                                                  style: TextStyle(
                                                    fontFamily: 'lpmq',
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
                                          if (!showTranslation)
                                            return const SizedBox();
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              TranslationData.getTranslation(
                                                  widget
                                                      .selectedLanguage)[index],
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
                                                    fontFamily: 'lpmq',
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
                                          if (!showTranslation)
                                            return const SizedBox();
                                          return Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                TranslationData.getTranslation(
                                                        widget
                                                            .selectedLanguage)[
                                                    index],
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorDark, // <- unchanged
                                                  fontSize: 16,
                                                ),
                                                textDirection:
                                                    TextDirection.ltr,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 0.1,
                          color: widget.isDarkTheme ? blk : blk, // <- unchanged
                        )
                      ],
                    ),
                  );
                }
              },
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
