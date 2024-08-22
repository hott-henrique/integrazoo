import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/bovine_create_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/bovine_list_tile.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';


class HerdView extends StatefulWidget {
    final CentralController controller;

    const HerdView({ super.key, required this.controller });


    @override
    State<HerdView> createState() => _HerdView();

}

class _HerdView extends State<HerdView> {
  Exception? exception;

    @override
    Widget build(BuildContext context) {
      if (exception != null) {
        return AlertDialog(
          title: const Text('Falha ao procurar animais.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[ const Text('Algo falhou ao procurar por animais.'),
                                  const Text('Por favor, contate a equipe INTEGRAZOO.'),
                                  Text(exception.toString()) ],
            ),
          ),
          actions: <Widget>[ TextButton(child: const Text('Fechar'), onPressed: () => setState(() => exception = null)) ],
        );
      }
      return FutureBuilder<List<Bovine>?>(
        future: widget.controller.bovineController.readHerd(),
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
                                          .push(MaterialPageRoute(builder: (context) => BovineCreateForm(controller: widget.controller)))
                                          .then((value) => setState(() { }))
                  );
                }

                return BovineListTile(cattle: cattle[index - 1], controller: widget.controller,);
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
     * Cow <a href="https://www.flaticon.com/free-icons/cow" title="cow icons">Cow icons created by kerismaker - Flaticon</a>
     * Bull <a href="https://www.flaticon.com/free-icons/thorn" title="thorn icons">Thorn icons created by berkahicon - Flaticon</a>
     */
}

