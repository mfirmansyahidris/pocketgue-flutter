import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/ui.dart';


class AppRoute {
  AppRoute._();

  //define page route name
  static const String splashPage = "splash";
  static const String mainPage = "main";
  static const String animalDetail = "animalDetail";

  //define page route
  static Map<String, WidgetBuilder> getRoutes({RouteSettings? settings}) => {
    splashPage: (_) => BlocProvider(create: (context) => SplashBloc(), child: const SplashView()),
    mainPage: (_) {
      return const MainView();
    },
    animalDetail: (_){
      AnimalData animalData = AnimalData();
      if(settings != null){
        if(settings.arguments != null){
          animalData = settings.arguments! as AnimalData;
        }
      }
      return BlocProvider(create: (context) => AnimalDetailBloc(), child: AnimalDetailView(
        animalData: animalData,
      ));
    },
  };
}
