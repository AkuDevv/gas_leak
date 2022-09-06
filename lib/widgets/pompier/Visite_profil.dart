// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'HistoriqueUser.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? fname = "";
  String? cin = "";
  String? tel = "";
  String? adresse = "";
  String? email = "";
  double? longitude = 1.1;
  double? latitude = 1.1;

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
          longitude = snapshot.data()!['longitude'];
          latitude = snapshot.data()!['latitude'];
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            fname!,
            style: TextStyle(fontFamily: 'Sfpro'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            height: height * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(20)),
                //color: Colors.grey,
                gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.8,
                    colors: const [Color(0xff00366f), Color(0xffd51b33)],
                    stops: const [0.1, 0.9])),
            child: Padding(
              padding: EdgeInsets.only(top: 80, left: 30, right: 30),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Tél: ' + tel!,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sfpro',
                            fontSize: 18),
                      ),
                      Text(
                        'CIN: ' + cin!,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sfpro',
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        adresse!,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sfpro',
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HistoriqueUser(uid: widget.uid)));
                        },
                        child: GradientText(
                          'Historique',
                          colors: const [Color(0xff00366f), Color(0xffd51b33)],
                          style: TextStyle(
                              //color: Color(0xff00366f),
                              fontFamily: 'Sfpro',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          pinned: true,
          expandedHeight: height * 0.4,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: height,
              width: width,
              child: (longitude! == 1.1)
                  ? Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "Utilisateur n'a pas autorisé l'accès à son emplacement",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Stack(
                      children: [
                        GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(latitude!, longitude!),
                                zoom: 14.5),
                            markers: {
                              Marker(
                                  markerId: const MarkerId('Position'),
                                  position: LatLng(latitude!, longitude!))
                            }),

                        //color: Colors.grey,
                      ],
                    ),
            ),
          ]),
        ),
      ],
    ));
  }
}
