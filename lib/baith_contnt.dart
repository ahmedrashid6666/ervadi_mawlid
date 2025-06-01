import 'package:flutter/material.dart';
import 'package:ervadi/tab_bar_page.dart';
import 'package:provider/provider.dart';
import 'module/assets.dart';

class BaithContnt extends StatefulWidget {
  bool darkMode;
  bool transbutton;
  List<String> baithTxt;
  List<String> baithTxtTrans;
  final ValueNotifier<bool> showTranslationNotifier;

  Function(double) onChanged;
  BaithContnt(
      {Key? key,
      this.darkMode = true,
      required this.baithTxt,
      required this.baithTxtTrans,
      required this.transbutton,
      required this.showTranslationNotifier,
      required this.onChanged})
      : super(key: key);

  @override
  State<BaithContnt> createState() => _BaithContntState();
}

class _BaithContntState extends State<BaithContnt> {
  // Generate a dummy list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: widget.darkMode ? white : Color(0xFF282828),
          // Use ListView.builder
          child: numbrlist()),
    );
  }

  ListView numbrlist() {
    final fontSize = Provider.of<FontSize>(context);
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        // the number of items in the list
        itemCount: widget.baithTxt.length,

        // display each item of the product list
        itemBuilder: (context, index) {
          int indexPlus = index + 1;

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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                    child: indexPlus.isOdd
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Expanded(
                                    child: Consumer<FontSize>(
                                      builder: (context, fontSize, child) {
                                        return Text(
                                          widget.baithTxt[index],
                                          style: TextStyle(
                                            fontFamily: 'lpmq',
                                            color: white,
                                            fontSize: fontSize.fontSize,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // Translation, only if toggled ON
                              ValueListenableBuilder<bool>(
                                valueListenable: widget.showTranslationNotifier,
                                builder: (context, showTranslation, child) {
                                  if (!showTranslation) return SizedBox();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      widget.baithTxtTrans[index],
                                      style: TextStyle(
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
                                      builder: (context, fontSize, child) {
                                        return Text(
                                          widget.baithTxt[index],
                                          style: TextStyle(
                                            fontFamily: 'lpmq',
                                            color: white,
                                            fontSize: fontSize.fontSize,
                                          ),
                                          textDirection: TextDirection.ltr,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // Translation, only if toggled ON
                              ValueListenableBuilder<bool>(
                                valueListenable: widget.showTranslationNotifier,
                                builder: (context, showTranslation, child) {
                                  if (!showTranslation) return SizedBox();
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        widget.baithTxtTrans[index],
                                        style: TextStyle(
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
                    color: widget.darkMode ? white : ltWhite,
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
                                        builder: (context, provider, child) {
                                          return Text(
                                            widget.baithTxt[index],
                                            style: TextStyle(
                                              fontFamily: 'lpmq',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontSize: fontSize.fontSize,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          );
                                        },
                                      ))
                                    ]),

                                // Translation, only if toggled ON
                                ValueListenableBuilder<bool>(
                                  valueListenable:
                                      widget.showTranslationNotifier,
                                  builder: (context, showTranslation, child) {
                                    if (!showTranslation) return SizedBox();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        widget.baithTxtTrans[index],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
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
                                        builder: (context, provider, child) {
                                          return Text(
                                            widget.baithTxt[index],
                                            style: TextStyle(
                                              fontFamily: 'lpmq',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontSize: fontSize.fontSize,
                                            ),
                                            textDirection: TextDirection.ltr,
                                          );
                                        },
                                      ),
                                    ]),
                                // Translation, only if toggled ON
                                ValueListenableBuilder<bool>(
                                  valueListenable:
                                      widget.showTranslationNotifier,
                                  builder: (context, showTranslation, child) {
                                    if (!showTranslation) return SizedBox();
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          widget.baithTxtTrans[index],
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
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
                  Divider(
                    height: 1,
                    thickness: 0.1,
                    color: widget.darkMode ? blk : blk,
                  )
                ],
              ),
            );
          }
        });
  }
}
