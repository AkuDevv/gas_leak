// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/widgets/client/SearchObject.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  String query = "";
  String test = "";
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController searchcontroller = TextEditingController();
// ignore: prefer_final_fields
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchcontroller,
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        query = value;
                        if (value == 'avec') {
                          test = "true";
                        } else if (value == 'sans') {
                          test = "false";
                        } else {
                          test = " ";
                        }
                      });
                    }
                  },
                  decoration: InputDecoration(
                      iconColor: Colors.blueAccent,
                      hintText: "Rechercher/Filtrer",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('historiques')
                        .where('date', isNotEqualTo: ' ')
                        .snapshots()
                        .asBroadcastStream(),
                    builder: ((BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data!.docs
                                .where(
                                    (QueryDocumentSnapshot<Object?> element) =>
                                        element['date']
                                            .toString()
                                            .contains(query))
                                .isEmpty &&
                            snapshot.data!.docs
                                .where(
                                    (QueryDocumentSnapshot<Object?> element) =>
                                        element['heure']
                                            .toString()
                                            .contains(query))
                                .isEmpty &&
                            !query.toLowerCase().contains('avec') &&
                            !query.toLowerCase().contains('sans')) {
                          return Center(
                            child: Text("Aucun r??sultat trouv?? !"),
                          );
                        } else {
                          return ListView(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              ...snapshot.data!.docs
                                  .where((QueryDocumentSnapshot<Object?>
                                          element) =>
                                      (element['date']
                                              .toString()
                                              .toLowerCase()
                                              .contains(query.toLowerCase()) ||
                                          element['heure']
                                              .toString()
                                              .toLowerCase()
                                              .contains(query.toLowerCase()) ||
                                          element['intervention']
                                              .toString()
                                              .toLowerCase()
                                              .contains(test)))
                                  .map((QueryDocumentSnapshot<Object?> data) {
                                final String date = data.get('date');
                                final String heure = data.get('heure');
                                final bool intervention =
                                    data.get('intervention');
                                String msg = "";

                                if (intervention == true) {
                                  msg = 'Avec intervention';
                                } else {
                                  msg = 'Sans intervention';
                                }

                                return SearchObject(
                                  date: date,
                                  heure: heure,
                                  intervention: msg,
                                );
                              })
                            ],
                          );
                        }
                      }
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
