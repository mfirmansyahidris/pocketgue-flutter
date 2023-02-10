import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketgue/config/config.dart';
import 'package:pocketgue/core/core.dart';

class AnimalsBloc extends Cubit<Result<AnimalsResponse>> {
  late AnimalRepository? _repository;

  AnimalsBloc({AnimalRepository? repository}) : super(Result.idle()) {
    _repository = repository ?? sl<AnimalRepository>();
  }

  Future<void> getAnimals(AnimalsRequest animalsRequest) async {
    emit(Result.isLoading());
    emit(await _repository!.getAnimals(animalsRequest));
  }
}