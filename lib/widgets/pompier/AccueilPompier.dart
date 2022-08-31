import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/HomePage.dart';
import 'package:gas_leak_safety/widgets/pompier/HomePompier.dart';

import '../TabBar.dart';

class AccueilPompier extends StatefulWidget {
  const AccueilPompier({Key? key}) : super(key: key);

  @override
  State<AccueilPompier> createState() => _AccueilPompierState();
}

class _AccueilPompierState extends State<AccueilPompier> {
  @override
  Widget build(BuildContext context) {
    return const TabBarWidget(
      title: 'Espace Pompier',
      tabs: [
        Tab(icon: Icon(Icons.home), text: 'Accueil'),
      ],
      children: [
        HomePompier(),
      ],
    );
  }
}
