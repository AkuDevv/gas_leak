import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/pompier/AccueilPompier.dart';

class LoginPompier extends StatefulWidget {
  const LoginPompier({Key? key}) : super(key: key);

  @override
  State<LoginPompier> createState() => _LoginPompierState();
}

class _LoginPompierState extends State<LoginPompier> {
  TextEditingController matriculeController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool sended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 140, left: 30, right: 30),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // LOGO
              SizedBox(
                width: 180,
                height: 180,
                child: Image.asset("assets/images/login.png"),
              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: matriculeController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 16, fontFamily: 'Sfpro'),
                decoration: InputDecoration(
                    labelText: "  Matricule  ",
                    labelStyle:
                        const TextStyle(fontSize: 16, fontFamily: 'Sfpro'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(Icons.password)),
              ),
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 10, 45, 161),
                        Colors.cyan
                      ], stops: [
                        0.1,
                        0.9
                      ])),
                  child: TextButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      if (matriculeController.text == 'siham0000') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccueilPompier()));
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'Attention!',
                              style: TextStyle(fontFamily: 'Sfpro'),
                            ),
                            content: const Text(
                              'Votre matricule est incorrect',
                              style: TextStyle(fontFamily: 'Sfpro'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Se Connecter",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Sfpro',
                          color: Colors.white),
                    ),
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