// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'UserInfo.dart';

class HomePompier extends StatefulWidget {
  const HomePompier({Key? key}) : super(key: key);

  @override
  State<HomePompier> createState() => _HomePompierState();
}

class _HomePompierState extends State<HomePompier> {
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
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text(
          'Espace pompiers',
          style: TextStyle(
            fontFamily: 'Sfpro',
            fontSize: 18,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                      });
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
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
                            .where((QueryDocumentSnapshot<Object?> element) =>
                                element['tel'].toString().contains(query))
                            .isEmpty) {
                          return Center(
                            child: Text('No search found'),
                          );
                        } else {
                          return ListView(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              ...snapshot.data!.docs
                                  .where((QueryDocumentSnapshot<Object?>
                                          element) =>
                                      (element['tel']
                                          .toString()
                                          .toLowerCase()
                                          .contains(query.toLowerCase())))
                                  .map((QueryDocumentSnapshot<Object?> data) {
                                final String name = data.get('name');
                                final String tlf = data.get('tel');
                                final String uid = data.get('uid');

                                return Card(
                                  child: ListTile(
                                    leading: Icon(Icons.person),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserInformations(uid : uid)));
                                    },
                                    title: Text(
                                      name,
                                      style: TextStyle(
                                        fontFamily: 'Sfpro',
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(tlf),
                                  ),
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
