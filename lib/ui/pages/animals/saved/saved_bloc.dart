import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketgue/config/config.dart';
import 'package:pocketgue/core/core.dart';

class SavedBloc extends Cubit<Result<List<AnimalData>>> {
  late SavedAnimalRepository? _repository;

  SavedBloc({SavedAnimalRepository? repository}) : super(Result.idle()) {
    _repository = repository ?? sl<SavedAnimalRepository>();
  }

  Future<void> getSavedData() async {
    emit(Result.isLoading());
    await _repository?.open();
    final listData = await _repository?.getAnimals();
    emit(Result.isSuccess(data: listData));
  }
}