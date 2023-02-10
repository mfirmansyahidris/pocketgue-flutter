import 'dart:ui';
import 'dart:math' as math;

import 'package:pocketgue/ui/resources/resources.dart';

class AnimalsResponse {
  int? count;
  String? next;
  String? previous;
  List<AnimalData>? results;

  AnimalsResponse({this.count, this.next, this.previous, this.results});

  AnimalsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <AnimalData>[];
      json['results'].forEach((v) {
        results!.add(AnimalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimalData {
  String? name;
  String? url;
  Color color = Palette.white;
  bool? canDelete;

  AnimalData({this.name, this.url, this.canDelete = false});

  AnimalData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    canDelete = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['colors'] = color;
    return data;
  }
}
