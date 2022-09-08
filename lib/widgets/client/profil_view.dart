// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/widgets/client/changePassword.dart';
import 'package:geolocator/geolocator.dart';
import 'package:load_switch/load_switch.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController fnameController = TextEditingController();
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

  double? longitude = 1.1;
  double? latitude = 1.1;
  bool acceptedLocation = false;
  bool? loading = false;

  String message = "";

  Future<bool> getLoading() async {
    await Future.delayed(const Duration(seconds: 4));
    return !acceptedLocation;
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

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
                      style: TextStyle(fontFamily: 'Sfpro', fontSize: 16),
                      gradientType: GradientType.radial,
                      radius: 14,
                      colors: const [Color(0xff00366f), Color(0xffd51b33)],
                    ),
                  ),
                  // FIRST NAME TEXT FIELD
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: fnameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
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
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 4, top: 10),
                    child: GradientText(
                      'CIN :',
                      style: TextStyle(fontFamily: 'Sfpro', fontSize: 16),
                      gradientType: GradientType.radial,
                      radius: 14,
                      colors: const [Color(0xff00366f), Color(0xffd51b33)],
                    ),
                  ),
                  //CIN FIELD

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: cinController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.badge),
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
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 4, top: 10),
                    child: GradientText(
                      'Téléphone :',
                      style: TextStyle(fontFamily: 'Sfpro', fontSize: 16),
                      gradientType: GradientType.radial,
                      radius: 14,
                      colors: const [Color(0xff00366f), Color(0xffd51b33)],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: telController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
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
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 4, top: 10),
                    child: GradientText(
                      'Adresse :',
                      style: TextStyle(fontFamily: 'Sfpro', fontSize: 16),
                      gradientType: GradientType.radial,
                      radius: 14,
                      colors: const [Color(0xff00366f), Color(0xffd51b33)],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: adresseController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 15, fontFamily: 'Sfpro'),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          hintText: adresse,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontFamily: 'Sfpro'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(10)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "Autoriser l'accès à mon emplacement :",
                          style: TextStyle(
                              fontFamily: 'Sfpro', color: Color(0xff00366f)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: LoadSwitch(
                            width: 40,
                            height: 20,
                            future: getLoading,
                            value: acceptedLocation,
                            onTap: (value) {
                              print(value);
                            },
                            onChange: (value) async {
                              Position position =
                                  await _getGeoLocationPosition();
                              setState(() {
                                acceptedLocation = value;
                                latitude = position.latitude;
                                longitude = position.longitude;
                              });
                              if (user != null) {
                                CollectionReference users =
                                    firebaseFirestore.collection('users');
                                await users.doc(user!.uid).update({
                                  'name': fname,
                                  'email': email,
                                  'cin': cin,
                                  'tel': tel,
                                  'adresse': adresse,
                                  'photo': "",
                                  'uid': user!.uid,
                                  'provider': "EMAIL",
                                  'latitude': latitude == 1.1 ? 1.1 : latitude,
                                  'longitude':
                                      longitude == 1.1 ? 1.1 : longitude,
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(colors: const [
                            Color(0xff00366f),
                            Color(0xffd51b33)
                          ], stops: const [
                            0.1,
                            0.9
                          ])),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextButton(
                          onPressed: () async {
                            if (!_formkey.currentState!.validate() == true) {
                              return;
                            }

                            if (user != null) {
                              CollectionReference users =
                                  firebaseFirestore.collection('users');
                              await users.doc(user!.uid).update({
                                'name': fnameController.text == ""
                                    ? fname
                                    : fnameController.text,
                                'email': emailController.text == ""
                                    ? email
                                    : emailController.text,
                                'cin': cinController.text == ""
                                    ? cin
                                    : cinController.text,
                                'tel': telController.text == ""
                                    ? tel
                                    : telController.text,
                                'adresse': adresseController.text == ""
                                    ? adresse
                                    : adresseController.text,
                                'photo': "",
                                'uid': user!.uid,
                                'provider': "EMAIL",
                                'latitude': latitude == 1.1 ? 1.1 : latitude,
                                'longitude': longitude == 1.1 ? 1.1 : longitude,
                              }).then((value) => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                            'Enregistré!',
                                            style:
                                                TextStyle(fontFamily: 'Sfpro'),
                                          ),
                                          content: const Text(
                                            'Vos modifications ont été enregistrées!',
                                            style:
                                                TextStyle(fontFamily: 'Sfpro'),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ) /*(value) {setState(() {
                                message = 'Votre profil a été modifié avec succès!';
                              });}*/
                                  );
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

                  // LOGIN BUTTON
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const changePassword()));
                      },
                      child: Text("Changer le mot de passe",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Sfpro',
                              color: Color(0xff00366f))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
