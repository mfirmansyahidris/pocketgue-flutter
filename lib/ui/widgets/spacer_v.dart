import 'package:flutter/material.dart';
import 'package:pocketgue/ui/ui.dart';

class SpacerV extends StatelessWidget {
  const SpacerV({Key? key, this.value}) : super(key: key);
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: value ?? Dimens.space8,
    );
  }
}
