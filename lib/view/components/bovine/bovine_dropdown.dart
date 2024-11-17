import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';


class BovineDropdown extends StatelessWidget {
  final String label;
  final Future<List<Bovine>> future;
  final Function(Bovine?) onSelected;

  const BovineDropdown({ super.key, required this.label, required this.future, required this.onSelected });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bovine>>(
      future: future,
      builder: (context, AsyncSnapshot<List<Bovine>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final cows = snapshot.data!;

        if (cows.isEmpty) {
          return  DropdownMenu<Bovine>(
            dropdownMenuEntries: const [],
            label: Text(label),
            expandedInsets: EdgeInsets.zero,
            menuHeight: 300,
            initialSelection: null,
          );
        }

        onSelected(cows[0]);

        return  DropdownMenu<Bovine>(
          dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
          onSelected: (value) => onSelected(value),
          label: Text(label),
          expandedInsets: EdgeInsets.zero,
          menuHeight: 300,
          initialSelection: cows[0],
        );
      }
    );
  }
}
