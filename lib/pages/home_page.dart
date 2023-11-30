import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:laptop_recommendation/pages/add_entry_page.dart';

import 'package:laptop_recommendation/pages/settings_page.dart';

import 'package:laptop_recommendation/pages/statistics_view_dart.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import '../controller/laptop_controller.dart';

import '../model/laptop_entry.dart';

import 'components/laptop_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final LaptopController laptopController = LaptopController();

  late StreamController<QuerySnapshot> _streamController;

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<QuerySnapshot>();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        laptopController.laptopEntryCollection.snapshots().listen(
          (QuerySnapshot snapshot) {
            _streamController.add(snapshot);
          },
        );
      } else {
        _streamController.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Laptop Recommendation',
            style: GoogleFonts.sora(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddEntryView(laptopController: laptopController)),
                );
              },
            ),
            IconButton(
                icon: const Icon(Icons.tag),
                onPressed: () async {
                  var entriesList = await laptopController.listEntries();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => StatisticsView(
                              entriesList: entriesList,
                            )),
                  );
                }),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Hollan Ardinata"),
                accountEmail: Text("holanardinata733@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/download.png"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text(
                  "Settings",
                  style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );

                  print("Klik Utama");
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
        ),
        body: StreamBuilder(
          stream: _streamController.stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No data found'));
            } else {
              List<LaptopEntry> entries = snapshot.data!.docs
                  .map((doc) => LaptopEntry.fromMap(doc))
                  .toList();

              entries.sort((a, b) => b.date.compareTo(a.date));

              List<Widget> widgets = [];

              DateTime? lastDate;

              for (int i = 0; i < entries.length; i++) {
                final entry = entries[i];

                if (lastDate == null ||
                    entry.date.month != lastDate.month ||
                    entry.date.year != lastDate.year) {
                  final headerText = DateFormat('MMMM yyyy').format(entry.date);

                  widgets.add(DateHeader(text: headerText));
                }

                widgets.add(
                  LaptopEntryWidget(
                    entry: entry,
                    onDelete: () {
                      laptopController.removeEntry(entry);
                    },
                  ),
                );

                lastDate = entry.date;
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: widgets,
                ),
              );
            }
          },
        ));
  }
}

class DateHeader extends StatelessWidget {
  final String text;

  const DateHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
