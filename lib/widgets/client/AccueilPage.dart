import 'package:flutter/material.dart';
import 'package:gas_leak_safety/services/calls_service.dart';
import 'package:gas_leak_safety/services/services_locator.dart';

import 'ObjectBox.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 160,
                        height: 140,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 1,
                          decoration: BoxDecoration(color: Colors.grey),
                        ),
                      ),
                      const Text(
                        'Solution innovante \net affordable ',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Sfpro',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff04346c)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.56,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    ObjectBox(
                      title: 'Maintenance',
                      assetPath: 'assets/images/maintenance.png',
                      item: "Maintenance",
                    ),
                    ObjectBox(
                      title: 'Consultation',
                      assetPath: 'assets/images/consulter.jpg',
                      item: "Consultation",
                    ),
                    ObjectBox(
                      title: 'Nos services',
                      assetPath: 'assets/images/serv.jpg',
                      item: "Services",
                    ),
                    ObjectBox(
                      title: "Conseils d'utilisation",
                      assetPath: 'assets/images/conseils.jpg',
                      item: "Conseils",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 13, right: 13),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.855,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  colors: [Color(0xff00366f), Color(0xffd51b33)],
                  stops: [0.1, 0.9])),
          child: TextButton(
            onPressed: () {
              _service.call('0697545209');
            },
            child: const Text(
              'Contactez Nous!',
              style: TextStyle(
                  fontFamily: 'Sfpro',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
