import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';


class EarringController with ChangeNotifier {
  int? _earring;
  int? get earring => _earring;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  Bovine? bovine;
  Sex? sex;
  bool? isReproducing;
  bool? isPregnant;
  bool? isBreeder;

  EarringController({ this.sex, this.isReproducing, this.isPregnant, this.isBreeder });

  void setEarring(int? value) {
    if (value != null) {
      final isar = GetIt.I<Isar>();

      isar.bovines.get(value).then((b) {
        if (b == null || (sex != null && b.sex != sex)
                      || (isReproducing != null && b.isReproducing() != isReproducing)
                      || (isPregnant != null && b.isPregnant() != isPregnant)
                      || (isBreeder != null && b.isBreeder != isBreeder)) {
          clear();
          notifyListeners();
          return;
        }

        bovine = b;
      });
    }

    _earring = value;
    notifyListeners();
  }

  void clear() {
    page = 0;
    _earring = null;
    bovine = null;
    queryController.text = "";
    notifyListeners();
  }
}
