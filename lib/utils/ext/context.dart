import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketgue/ui/ui.dart';

extension ContextExtensions on BuildContext {
  bool isMobile() {
    final shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide < 600;
  }

  void logs(dynamic message) {
    if (kDebugMode) {
      debugPrint(
        "========================================================================================",
      );
      debugPrint("| Message Log : $message");
      debugPrint("| Widget Name : $widget");
      debugPrint(
        "========================================================================================",
      );
    }
  }

  Future<dynamic> goTo(String routeName, {Object? args}) =>
      Navigator.pushNamed(this, routeName, arguments: args);

  Future<dynamic> goToReplace(String routeName, {Object? args}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: args);

  Future<dynamic> goToClearStack(String routeName, {Object? args}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (Route<dynamic> route) => false,
        arguments: args,
      );

  void back() => Navigator.pop(this);

  PreferredSize noAppBarPrimary() => PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      );

  PreferredSize noAppBarDark() => PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      );

  PreferredSize noAppBarLight() => PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      );

  double widthInPercent(double percent) {
    final toDouble = percent / 100;
    return MediaQuery.of(this).size.width * toDouble;
  }

  double heightInPercent(double percent) {
    final toDouble = percent / 100;
    return MediaQuery.of(this).size.height * toDouble;
  }

  // Handle dialog
  Future<void> dialog({
    required Widget child,
    String? title,
    bool showClose = true,
  }) async {
    await showDialog(
      context: this,
      barrierDismissible: true,
      builder: (c) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecorations.dialogAlt,
          margin: EdgeInsets.symmetric(horizontal: Dimens.space16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: showClose,
                child: Row(
                  children: [
                    SpacerH(
                      value: Dimens.space16,
                    ),
                    Text(
                      title ?? "",
                      style:
                          TextStyles.h6.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(c);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Palette.divider,
              ),
              Visibility(
                visible: !showClose,
                child: SpacerV(value: Dimens.space24),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: Dimens.space16,
                  left: Dimens.space16,
                  right: Dimens.space16,
                ),
                child: child,
              )
            ],
          ),
        ),
      ),
    );
  }

  //Start Loading Dialog
  static late BuildContext ctx;

  Future<void> show() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          ctx = c;
          return WillPopScope(
            onWillPop: () async => false,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  ),
                  padding: EdgeInsets.all(Dimens.space24),
                  child: Wrap(children: const [Loading()]),
                ),
              ),
            ),
          );
        },
      );

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }

  Future<void> dialogConfirm(
      {required String title,
      required String message,
      Color? color,
      VoidCallback? onActionYes,
      VoidCallback? onActionNo}) async {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.report, color: color ?? Palette.primary),
              SpacerH(
                value: Dimens.space8,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyles.body1
                      .copyWith(color: color ?? Palette.primary),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyles.body1,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dimens.space30,
            vertical: Dimens.space24,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onActionYes?.call();
                  },
                  child: Text(
                    Strings.get.yes,
                    style: TextStyles.body1.copyWith(
                      color: color ?? Palette.primary,
                    ),
                  ),
                ),
                const SpacerH(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onActionNo?.call();
                  },
                  child: Text(
                    Strings.get.cancel,
                    style: TextStyles.body1
                        .copyWith(color: color ?? Palette.primary),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future bottomSheet(
          {required String title,
          required List<Widget> children,
          bool isDismissible = true,
          bool centerTitle = false}) =>
      showModalBottomSheet(
        context: this,
        enableDrag: true,
        isDismissible: isDismissible,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.space30),
            topRight: Radius.circular(Dimens.space30),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: Dimens.space16,
        builder: (context) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
              left: Dimens.space16,
              right: Dimens.space16,
              top: Dimens.space16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            duration: const Duration(milliseconds: 300),
            child: Wrap(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: Dimens.bottomBar,
                    height: Dimens.space8,
                    margin: EdgeInsets.only(bottom: Dimens.space24),
                    decoration: const BoxDecoration(
                      color: Palette.disable,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                Align(
                  alignment:
                      centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyles.h6.copyWith(fontWeight: FontWeight.w500),
                    textAlign: centerTitle ? TextAlign.center : TextAlign.left,
                  ),
                ),
                SpacerV(value: Dimens.space16),
                const Divider(
                  height: 0,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: heightInPercent(80)),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SpacerV(value: Dimens.space16),
                        for (final child in children) child,
                        SpacerV(value: Dimens.space16),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
}
