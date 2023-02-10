import 'package:flutter/material.dart';
import 'package:pocketgue/ui/ui.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
    this.showMessage = true,
  }): super(key: key);

  final bool showMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ColorLoader(),
        Visibility(
          visible: showMessage,
          child: Text(
            Strings.get.pleaseWait,
            style: TextStyles.body2,
          ),
        )
      ],
    );
  }
}
