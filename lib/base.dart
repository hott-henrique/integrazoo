import 'package:flutter/material.dart';

import 'package:integrazoo/about_page.dart';
import 'package:integrazoo/dairy_cattle_subsystem/dairy_cattle_subsystem.dart';


enum Culture {
    dairyCattle,
    beekeeping;

    @override
    String toString() {
        switch (this) {
            case Culture.dairyCattle:
                return "Bovinocultura (Leite)";

            case Culture.beekeeping:
                return "Apicultura";
        }
    }
}

class IntegrazooBaseApp extends StatefulWidget {
    final Widget body;

    const IntegrazooBaseApp({ super.key, required this.body });

    @override
    State<IntegrazooBaseApp> createState() => _IntegrazooBaseAppState();
}

class _IntegrazooBaseAppState extends State<IntegrazooBaseApp> {
    Culture currentCulture = Culture.dairyCattle;

    @override
    Widget build(BuildContext context) {

        Builder leadingBuilder = Builder(builder: (BuildContext context) {
            return IconButton(
                    icon: const Icon(Icons.view_list, color: Colors.white),
                    onPressed: () => { Scaffold.of(context).openDrawer() }
            );
        });

        return Scaffold(
                appBar: AppBar(
                    title: const Text('INTEGRAZOO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    backgroundColor: Colors.green,
                    centerTitle: true,
                    leading: leadingBuilder,
                ),
                body: widget.body,
                drawer: Drawer(child: _createDrawerItems())
        );
    }

    Widget _createDrawerHeader() {
        return Container(
            decoration: const BoxDecoration(color: Colors.green),
            child: ListTile(
                title: const Text('CULTURA', style: TextStyle(color: Colors.white)),
                subtitle: DropdownButton(
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: Colors.green,
                    value: currentCulture,
                    isExpanded: true,
                    items: Culture.values.map((c) {
                        return DropdownMenuItem(value: c, child: Text(c.toString()));
                    }).toList(),
                    onChanged: (value) { setState(() { currentCulture = value!; });},
                ),
                dense: true,
                leading: const CircleAvatar(backgroundColor: Colors.white,
                                            foregroundColor: Colors.green,
                                            child: Icon(Icons.source)),
            )
        );
    }

    ListView _createDrawerItems() {
        switch (currentCulture) {
            case Culture.dairyCattle:
                DairyCattleSubsystem dairyCattleSubsystem = DairyCattleSubsystem();
                List<Widget> tiles = [
                    _createDrawerHeader(),
                    ListTile(title: const Text("Inicio"), onTap: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                    })
                ];
               tiles.addAll(dairyCattleSubsystem.createSubsystemTiles(context));
               tiles.add(
                    ListTile(title: const Text("Sobre"), onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AboutPage())
                        );
                    }),
               );

              return ListView(children: tiles);

            case Culture.beekeeping:
              return ListView(children: <Widget>[
                        _createDrawerHeader(),
                        ListTile(title: const Text("Inicio"), onTap: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                        }),
                        ListTile(title: const Text("Sobre"), onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const AboutPage())
                            );
                        }),
              ]);
        }
    }
}
