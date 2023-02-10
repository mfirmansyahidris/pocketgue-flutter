
import 'package:pocketgue/utils/ext/string.dart';

class Strings {
  Strings._();

  static Strings get = Strings._();

  /// Clear strings after change language
  static void clear() {
    get = Strings._();
  }

  String appName = "PocketGue";
  String pleaseWait = "pleaseWait".toLocale();
  String cancel = "cancel".toLocale();
  String yes = "yes".toLocale();
  String save = "save".toLocale();
  String no = "no".toLocale();
  String close = "close".toLocale();
  String dataEmpty = "dataEmpty".toLocale();


  String animals = "animals".toLocale();
  String saved = "saved".toLocale();
  String somethingWrong = "somethingWrong".toLocale();
  String abilities = "abilities".toLocale();
  String baseExperience = "baseExperience".toLocale();
  String forms = "forms".toLocale();
  String gameIndices = "gameIndices".toLocale();
  String moves = "moves".toLocale();
  String name = "name".toLocale();
  String species = "species".toLocale();
  String stats = "stats".toLocale();
  String types = "types".toLocale();
  String catchAnimal = "catch".toLocale();
  String catchNewAnimal = "catchNewAnimal".toLocale();
  String deleteConfirm = "deleteConfirm".toLocale();
  String delete = "delete".toLocale();
  String congratulation = "congratulation".toLocale();

  String createdBy = "createdBy".toLocale();
  String creator = "creator".toLocale();

}
