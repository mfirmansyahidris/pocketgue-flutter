import 'package:flutter/material.dart';

class DataHelper {
  final String? title;
  final String? desc;
  bool isSelected;
  final String? iconPath;
  final IconData? icon;
  final String? url;
  final String? type;
  final String? id;
  final Color? descColor;
  final bool isDescBold;
  final VoidCallback? action;

  DataHelper({
    this.title,
    this.desc,
    this.isSelected = false,
    this.iconPath,
    this.icon,
    this.url,
    this.type,
    this.id,
    this.descColor,
    this.isDescBold = false,
    this.action
  });
}
