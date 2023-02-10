import 'package:pocketgue/config/config.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/ui.dart';

class AnimalRepository{
  final _restApi = sl<RestApi>();

  Future<Result<AnimalsResponse>> getAnimals(AnimalsRequest animalsRequest) async {
    try {
      final response = await _restApi.getAnimals(animalsRequest);
      final animalsResponse = AnimalsResponse.fromJson(response.data);

      if (response.statusCode == 200) {
        if(animalsResponse.results?.isEmpty ?? true){
          return Result.isEmpty(message: Strings.get.dataEmpty);
        }
        return Result.isSuccess(data: animalsResponse);
      } else {
        return Result.isError(Strings.get.somethingWrong);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<AnimalDetailResponse>> getAnimalDetail(String url) async {
    try {
      final path = url.replaceFirst(baseUrl, "");
      final response = await _restApi.getAnimalDetail(path);
      final animalDetailResponse = AnimalDetailResponse.fromJson(response.data);

      if (response.statusCode == 200) {
        return Result.isSuccess(data: animalDetailResponse);
      } else {
        return Result.isError(Strings.get.somethingWrong);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}