import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';


import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/treatment.dart';


class BovineDetailedView extends StatefulWidget {
    final Bovine cattle;

    const BovineDetailedView({ super.key, required this.cattle });


    @override
    State<BovineDetailedView> createState() => _BovineDetailedView();

}

class _BovineDetailedView extends State<BovineDetailedView> {
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

      const textStyle = TextStyle(fontSize: 30);

      return FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData){
            return const CircularProgressIndicator();
          }

          final List<Treatment> treatments = snapshot.data[0];

          return IntegrazooBaseApp(body:
            Column(children: treatments.map((t) => Row(children: [ Expanded(child: Center(child: Text(t.reason, style: textStyle))) ])).toList())
          );
        }
      );
    }

    Future<dynamic> fetchData() async {
      return [
          await widget.cattle.treatments,
      ];
    }
}

