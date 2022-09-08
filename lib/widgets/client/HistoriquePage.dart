import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/client/navBar.dart';

class HistoriquePage extends StatefulWidget {
  HistoriquePage({Key? key}) : super(key: key);

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(
        currentPage: 'Historique',
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff00366f), Color(0xffd41d35)],
                      stops: [0.2, 0.9])),
              child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    "Historique",
                    style: TextStyle(
                        fontFamily: 'Sfpro',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            //more code here...
          ],
        ),
      ),
    );
  }
}
