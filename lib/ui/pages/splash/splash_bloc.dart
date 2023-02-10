import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../utils/utils.dart';

class SplashBloc extends Cubit<Result> {

  SplashBloc() : super(Result.idle());

  Future<Timer> runSplash() async {
    var duration = const Duration(seconds: 2);
    await setLocale(sl<PrefManager>().locale);
    emit(Result.isLoading());

    return Timer(duration, () async {
      emit(Result.isSuccess());
    });
  }
}