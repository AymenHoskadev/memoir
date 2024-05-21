// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/models/ModulePost.dart';
import 'package:memoir/models/module.dart';

class ModuleController extends GetxController {
  List<Module> modules;

  ModuleController({required this.modules});

  List<Module> getSemestreModule(int semestre) {
    return modules.where((x) => x.semestre == semestre).toList();
  }

  String getFirstLetters(String input) {
    List<String> words = input.split(" ");

    if (words.length <= 2) {
      return input.substring(0, 3).toUpperCase() + " " + words[1];
    }

    String firstLetters = '';

    for (String word in words) {
      if (word.length > 3 || RegExp(r'[0-9]').hasMatch(word)) {
        if (RegExp(r'[0-9]').hasMatch(word)) {
          firstLetters += " " + word[0].toUpperCase();
        } else {
          firstLetters += word[0].toUpperCase();
        }
      }
    }

    return firstLetters;
  }
}
