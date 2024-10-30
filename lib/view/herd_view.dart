import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/view/bovine_create_form.dart';
import 'package:integrazoo/view/bovine_list_tile.dart';

import 'package:integrazoo/model/bovine.dart';


class HerdView extends StatefulWidget {
  const HerdView({ super.key });

  @override
  State<HerdView> createState() => _HerdView();
}

class _HerdView extends State<HerdView> {
  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }
    return FutureBuilder<List<Bovine>?>(
      future: BovineController.readHerd(),
      builder: (context, AsyncSnapshot<List<Bovine>?> snapshot) {
        if (snapshot.hasData) {
          final cattle = snapshot.data!;

          ListView body = ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: cattle.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return ListTile(
                  leading: const Icon(Icons.add, weight: 200),
                  title: const Text("ADICIONAR ANIMAL"),
                  onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) => const BovineCreateForm()))
                                        .then((value) => setState(() { }))
                );
              }

              return BovineListTile(cattle: cattle[index - 1]);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );

          return IntegrazooBaseApp(body: Scrollbar(thickness: 15, thumbVisibility: true, child: body));
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
  /* Icons:
   *   Cow <a href="https://www.flaticon.com/free-icons/cow" title="cow icons">Cow icons created by kerismaker - Flaticon</a>
   *   Bull <a href="https://www.flaticon.com/free-icons/thorn" title="thorn icons">Thorn icons created by berkahicon - Flaticon</a>
   */
}
