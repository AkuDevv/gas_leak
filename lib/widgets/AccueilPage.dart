import 'package:flutter/material.dart';
import 'package:gas_leak_safety/services/calls_service.dart';
import 'package:gas_leak_safety/services/services_locator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';



import 'ObjectBox.dart';
import 'navBar.dart';

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
          drawer: const NavBar(currentPage: 'Accueil'),
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
                      height: MediaQuery.of(context).size.height * 0.15,
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
                          GradientText(
                            'Solution innovante \net affordable ',
                            colors: const[
                                Colors.blue,Colors.purple
                            ],
                            style: const TextStyle(
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
                    height: MediaQuery.of(context).size.height * 0.52,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: const [
                        ObjectBox(
                          title: 'Maintenance',
                          assetPath: 'assets/images/maintenance.png',
                        ),
                        ObjectBox(
                          title: 'Consultation',
                          assetPath: 'assets/images/consulter.jpg',
                        ),
                        ObjectBox(
                          title: 'Nos services',
                          assetPath: 'assets/images/serv.jpg',
                        ),
                        ObjectBox(
                          title: "Conseils d'utilisation",
                          assetPath: 'assets/images/conseils.jpg',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5.0, left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [Colors.blue,Colors.purple],
                          stops: [0.1,0.9]
                        )
                      ),
                      child: FloatingActionButton.extended(
                        elevation: 0,
                        onPressed: () {
                          _service.call('0697545209');
                        },
                        label: const Text(
                          'Contactez Nous!',
                          style: TextStyle(
                              fontFamily: 'Sfpro', fontWeight: FontWeight.bold),
                        ),
                        icon: const Icon(Icons.call),
                        backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}