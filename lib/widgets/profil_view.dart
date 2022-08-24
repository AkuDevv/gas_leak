// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/widgets/changePassword.dart';
import 'package:gas_leak_safety/widgets/HomePage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? fname = "";
  String? cin = "";
  String? tel = "";
  String? adresse = "";
  String? email = "";

  User? user = FirebaseAuth.instance.currentUser;

  final _formkey = GlobalKey<FormState>();

  bool showPassword = true;

  Future _getUserFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          fname = snapshot.data()!['name'];
          cin = snapshot.data()!['cin'];
          tel = snapshot.data()!['tel'];
          adresse = snapshot.data()!['adresse'];
          email = snapshot.data()!['email'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 4),
                    child: GradientText(
                      'Nom & Prénom :',
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          fontSize: 16),
                          gradientType: GradientType.radial,
                          radius: 14,
                      colors:  const [
                        Colors.purple,Colors.blue
                      ],
                    ),
                  ),
                  // FIRST NAME TEXT FIELD
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: fnameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          hintText: fname,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontFamily: 'Sfpro'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(10)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 4, top: 10),
                    child: GradientText(
                      'CIN :',
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          fontSize: 16),
                          gradientType: GradientType.radial,
                          radius: 14,
                      colors:  const [
                        Colors.purple,Colors.blue
                      ],
                    ),
                  ),
                  //CIN FIELD

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: cinController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          hintText: cin,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontFamily: 'Sfpro'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(10)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 4, top: 10),
                    child: GradientText(
                      'Téléphone :',
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          fontSize: 16),
                          gradientType: GradientType.radial,
                          radius: 14,
                      colors:  const [
                        Colors.purple,Colors.blue
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: telController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          hintText: tel,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontFamily: 'Sfpro'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(10)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 4, top: 10),
                    child: GradientText(
                      'Adresse :',
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          fontSize: 16),
                          gradientType: GradientType.radial,
                          radius: 14,
                      colors:  const [
                        Colors.purple,Colors.blue
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: adresseController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          hintText: adresse,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontFamily: 'Sfpro'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: const [Colors.blue,Colors.purple],
                                stops: const [0.1,0.9]
                              )
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height *
                                0.06,
                            child: RaisedButton(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15)),
                                onPressed: () async {
                                  if (!_formkey.currentState!
                                          .validate() ==
                                      true) {
                                    return;
                                  }

                                  if (user != null) {
                                    CollectionReference users =
                                        firebaseFirestore
                                            .collection('users');
                                    await users.doc(user!.uid).set({
                                      'name': "${fnameController.text} ${lnameController.text}" ==
                                              ""
                                          ? fname
                                          : "${fnameController.text} ${lnameController.text}",
                                      'email':
                                          emailController.text == ""
                                              ? email
                                              : emailController.text,
                                      'cin': cinController.text == ""
                                          ? cin
                                          : cinController.text,
                                      'tel': telController.text == ""
                                          ? tel
                                          : telController.text,
                                      'adresse':
                                          adresseController.text == ""
                                              ? adresse
                                              : adresseController.text,
                                      'photo': "",
                                      'uid': user!.uid,
                                      'provider': "EMAIL"
                                    });
                                  }
                                },
                                child: const Text(
                                  "Enregistrer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Sfpro',
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // LOGIN BUTTON
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const changePassword()));
                      },
                      child: GradientText(
                          "Changer le mot de passe",
                          colors: const [
                            Colors.blue,
                            Colors.purple
                          ],
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sfpro')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
