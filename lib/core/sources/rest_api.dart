import 'package:dio/dio.dart';
import 'package:pocketgue/config/config.dart';
import 'package:pocketgue/core/core.dart';

class RestApi{
  Future<Response> getAnimals(AnimalsRequest animalsRequest) =>
      dio.get("/pokemon", queryParameters: animalsRequest.toJson());

  Future<Response> getAnimalDetail(String path) => dio.get(path);
}