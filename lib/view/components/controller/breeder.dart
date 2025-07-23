import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/domain/bovine/sex.dart';


class BreederController with ChangeNotifier {
  int? _id;
  int? get id => _id;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  Sex? sex;
  Breeder? breeder;

  BreederController({ this.sex });

  void setBreeder(String? value) {
    if (value != null) {
      final isar = GetIt.I<Isar>();

      var b = isar.breeders.filter().identifierEqualTo(value).findFirstSync();

      b ??= isar.breeders.filter().nameEqualTo(value).findFirstSync();

      if (b != null) {
        if (sex != null && b.sex != sex) {
          b = null;
        }

        _id = b?.id;
        breeder = b;
        queryController.text = b?.name ?? "";
        notifyListeners();
        return;
      }
    }
  }

  void clear() {
    page = 0;
    _id = null;
    queryController.text = "";
    notifyListeners();
  }
}
