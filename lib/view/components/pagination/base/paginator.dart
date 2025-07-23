import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/pagination/base/data_loader.dart';


class Paginator extends StatefulWidget {
  final DataLoader loader;
  final Widget Function(BuildContext) pageBuilder;

  const Paginator({
    super.key,
    required this.loader,
    required this.pageBuilder,
  });

  @override
  State<Paginator> createState() => _Paginator();
}

class _Paginator extends State<Paginator> {

  @override
  void initState() {
    super.initState();
    widget.loader.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.loader,
      builder: (BuildContext context, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Container(
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.circular(4.0), // Apply rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Padding(padding: EdgeInsets.only(top: 2.0, bottom: 2.0), child: Divider(color: Colors.transparent, height: 1)),
              Card(child: Row(children: [
                IconButton(onPressed: widget.loader.previousPage, icon: const Icon(Icons.arrow_left)),
                Text("${widget.loader.page + 1} / ${widget.loader.maxPages}"),
                IconButton(onPressed: widget.loader.nextPage, icon: const Icon(Icons.arrow_right)),
              ])),
            ])),
          ),
            Expanded(child: widget.pageBuilder(context)),
          ]
        );
      }
    );
  }
}
