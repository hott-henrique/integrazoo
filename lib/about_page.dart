import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return IntegrazooBaseApp(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Sobre o INTEGRAZOO',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nisi elit, luctus in augue in, eleifend vulputate sapien. Proin eget vehicula sem. Nullam porta at mauris sit amet sodales. Duis pulvinar urna mauris, in dapibus tortor dictum quis. Cras ex massa, efficitur quis consectetur id, tincidunt in purus. Phasellus feugiat aliquet vestibulum. Quisque euismod massa egestas est tristique ultrices. Phasellus urna enim, maximus sit amet auctor vel, faucibus eu magna. Proin maximus semper risus nec maximus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris at elit massa.""",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nisi elit, luctus in augue in, eleifend vulputate sapien. Proin eget vehicula sem. Nullam porta at mauris sit amet sodales. Duis pulvinar urna mauris, in dapibus tortor dictum quis. Cras ex massa, efficitur quis consectetur id, tincidunt in purus. Phasellus feugiat aliquet vestibulum. Quisque euismod massa egestas est tristique ultrices. Phasellus urna enim, maximus sit amet auctor vel, faucibus eu magna. Proin maximus semper risus nec maximus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris at elit massa.""",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.justify,
          ),
        ),
      ])
    );
  }
}
