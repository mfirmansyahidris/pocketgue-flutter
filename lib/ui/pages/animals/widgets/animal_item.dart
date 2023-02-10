import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketgue/ui/ui.dart';

class AnimalItem extends StatelessWidget {
  final String fullName;
  final Color? color;
  final VoidCallback? onTap;
  final bool showFullName;

  const AnimalItem({
    Key? key,
    required this.fullName,
    this.color,
    this.onTap,
    this.showFullName = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Hero(
        tag: "item $fullName",
        child: Container(
          color: color,
          child: Stack(
            children: [
              Text(
                _alias,
                style: TextStyle(
                    fontSize: 100.h,
                    color: Palette.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              if(showFullName) Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Palette.black20,
                  padding: EdgeInsets.all(Dimens.space4),
                  child: Text(
                    fullName,
                    style: TextStyles.body1.copyWith(
                      color: Palette.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _alias {
    final words = fullName.split(" ");
    if(words.length < 2){
      return words[0].toString();
    }
    return "${words[0].toUpperCase()}${words[1].toUpperCase()}";
  }
}
