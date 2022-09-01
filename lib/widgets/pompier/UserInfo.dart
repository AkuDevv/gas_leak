import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/pompier/HistoriqueUser.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class UserInformations extends StatefulWidget {
  final String uid;
  const UserInformations({Key? key,required this.uid}) : super(key: key);

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
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

  double? longitude = 0;
  double? latitude = 0;
  bool acceptedLocation = false;

  final _formkey = GlobalKey<FormState>();

  bool showPassword = true;

  Future _getUserFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
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
                      colors: const [Colors.purple, Colors.blue],
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
                      colors: const [Colors.purple, Colors.blue],
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
                      colors: const [Colors.purple, Colors.blue],
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
                      colors: const [Colors.purple, Colors.blue],
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
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                      child: const Text('Historique'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => HistoriqueUser(uid: widget.uid))));
                      },
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