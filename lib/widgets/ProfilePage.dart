import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/navBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(currentPage: 'Profil',),
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
                    "Profil",
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