// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notpaid extends StatefulWidget {
  const Notpaid({super.key});

  @override
  State<Notpaid> createState() => _NotpaidState();
}

class _NotpaidState extends State<Notpaid> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 91, 100),
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Office')
            .doc(uid)
            .collection('fine')
            .where('mode', isEqualTo: 'notpaid')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data!.docs.map((e) {
                final Timestamp timestamp = e['date'] as Timestamp;
                final DateTime dateTime = timestamp.toDate();
                final dateString = DateFormat("dd MMM, yyyy").format(dateTime);

                final Timestamp timestamp1 = e['expired'] as Timestamp;
                final DateTime dateTime1 = timestamp1.toDate();
                final dateString1 =
                    DateFormat("dd MMM, yyyy").format(dateTime1);

                return Card(
                  color: Color.fromARGB(255, 44, 51, 51),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Fine Details: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                fontSize: 15.0),
                          )),
                        ),
                        Row(
                          children: [
                            Text(
                              "Fine description:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e['description'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Fine type:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e['type'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Fine amount:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e['amount'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Fine Date:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              dateString,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Expired Date:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              dateString1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "User Details: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                fontSize: 15.0),
                          )),
                        ),
                        Row(
                          children: [
                            Text(
                              "Name:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Vehicle Number:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e['vnum'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 201, 202),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Status:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e['mode'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(238, 137, 125, 172),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
                // return Container(
                //   child: Text(e['type']),
                // );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
