import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/AccueilPage.dart';
import 'package:gas_leak_safety/widgets/HistoriquePage.dart';
import 'package:gas_leak_safety/widgets/ProfilePage.dart';
import 'package:gas_leak_safety/widgets/profil_view.dart';

import 'TabBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      title: 'Gas Leak Safety',
      tabs: const [
        Tab(icon: Icon(Icons.home), text: 'Accueil'),
        Tab(icon: Icon(Icons.history), text: 'Historique'),
        Tab(icon: Icon(Icons.person), text: 'Profil'),
      ],
      children: [
        const AccueilPage(),
        HistoriquePage(),
        const ProfileView(),
      ],
    );
  }
}
