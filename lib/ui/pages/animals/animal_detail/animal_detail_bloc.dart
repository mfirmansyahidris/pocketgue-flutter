import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';

class AnimalDetailBloc extends Cubit<Result<AnimalDetailResponse>> {
  late AnimalRepository? _repository;

  AnimalDetailBloc({AnimalRepository? repository}) : super(Result.idle()) {
    _repository = repository ?? sl<AnimalRepository>();
  }

  Future<void> getAnimal(String url) async {
    emit(Result.isLoading());
    emit(await _repository!.getAnimalDetail(url));
  }
}