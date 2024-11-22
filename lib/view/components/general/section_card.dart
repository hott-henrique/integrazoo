import 'package:flutter/material.dart';
import 'package:integrazoo/app_styles.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/screens/bovine_detailed.dart';

import 'package:integrazoo/database/database.dart';



class SectionCard extends StatelessWidget {
  final String? sectionTitle;
  final List<Widget>? children;

  const SectionCard({super.key, this.sectionTitle, this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppStyles.backgroundColor,
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 25),
        child: Column(children: [
          if (sectionTitle != null && sectionTitle!.isNotEmpty)
            SizedBox(
                width: double.infinity,
                child: Text(sectionTitle!,
                    style: const TextStyle(
                      color: AppStyles.secondaryBlueColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24
                    ))),
        
          if (children != null) ...children!
        ]),
      ),

    );
  }
}