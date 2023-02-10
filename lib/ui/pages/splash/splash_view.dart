import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/ui.dart';
import 'package:pocketgue/utils/utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashBloc _splashBloc;

  bool _showCredit = false;

  @override
  void initState() {
    super.initState();
    _splashBloc = BlocProvider.of(context);
    _splashBloc.runSplash();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, Result>(
      listener: (context, state){
        switch (state.status) {
          case Status.loading:
            setState(() {
              _showCredit = true;
            });
            break;
          case Status.success:
            context.goToReplace(AppRoute.mainPage);
            break;
          default:
        }
      },
      child: Scaffold(
        backgroundColor: Palette.white,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Images.logoSvg,
                    width: context.widthInPercent(30),
                  ),
                  SpacerV(value: Dimens.space10,),
                  Hero(
                    tag: "title",
                    child: Text(
                      Strings.get.appName,
                      style: TextStyles.h1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Palette.primaryDark
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: Dimens.space16,
              left: Dimens.space16,
              right: Dimens.space16,
              child: Visibility(
                visible: _showCredit,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "${Strings.get.createdBy} ",
                      style: TextStyles.body2,
                      children: [
                        TextSpan(
                            text: "${Strings.get.creator} ",
                            style: TextStyles.body2.copyWith(
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
