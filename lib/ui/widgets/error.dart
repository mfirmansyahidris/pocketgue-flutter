import 'package:flutter/material.dart';
import 'package:pocketgue/ui/ui.dart';
import 'package:pocketgue/utils/utils.dart';

class Error extends StatelessWidget {
  final String? errorMessage;

  const Error({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(Dimens.space20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
            size: context.widthInPercent(10),
            color: Palette.borderGrey,),
          SpacerV(value: Dimens.space10,),
          Text(errorMessage ?? "", style: TextStyles.body1.copyWith(color: Palette.borderGreyDark),)
        ],
      ),
    );
  }
}
