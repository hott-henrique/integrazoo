import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';


class MultiEarringController with ChangeNotifier {
  List<int> earrings = List<int>.empty(growable: true);

  final queryController = TextEditingController();

  List<Bovine> bovines = List.empty(growable: true);

  Sex? sex;
  bool? isReproducing;
  bool? isPregnant;
  bool? isBreeder;

  MultiEarringController({ this.sex, this.isReproducing, this.isPregnant, this.isBreeder });

  void addEarring(int value) {
    if (earrings.contains(value)) return;

    earrings.add(value);

    final isar = GetIt.I<Isar>();

    isar.bovines.get(value).then((b) {
      if (b == null || (sex != null && b.sex != sex)
                    || (isReproducing != null && b.isReproducing() != isReproducing)
                    || (isPregnant != null && b.isPregnant() != isPregnant)
                    || (isBreeder != null && b.isBreeder != isBreeder)) {
        removeEarring(value);
        notifyListeners();
        return;
      }

      bovines.add(b);
    });

    notifyListeners();
  }

  void removeEarring(int value) {
    earrings.remove(value);
    notifyListeners();
  }

  void clear({ bool shouldClearQuery = true }) {
    if (shouldClearQuery) {
      queryController.text = "";
    }
    bovines.clear();
    earrings.clear();
    notifyListeners();
  }
}
