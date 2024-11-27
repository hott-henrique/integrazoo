

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:integrazoo/app_styles.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentListTile extends StatelessWidget {
  final Treatment treatment;

  const TreatmentListTile({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    
    return  ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      shape: const Border(bottom: BorderSide(width: 2, color: AppStyles.secondaryBlueColor)),
      leading: SvgPicture.asset("assets/icons/vaccine.svg", width: 30, colorFilter: const ColorFilter.mode( AppStyles.secondaryBlueColor, BlendMode.srcIn)),
      title: Text(treatment.medicine, maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: true,),
      subtitle: Text(treatment.reason, maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true,),
      titleTextStyle: AppStyles.tileTitleTextStyle,
      subtitleTextStyle: AppStyles.tileSubtitleTextStyle,
      trailing: Text('${formatter.format(treatment.startingDate)} - ${formatter.format(treatment.endingDate)}', style: AppStyles.tileTrailingTextStyle,),
      
      onTap: () {},
      );
  }
}
