// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_recommendation/auth_gate.dart';

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
  final User? user = FirebaseAuth.instance.currentUser;

  final LaptopController laptopController = LaptopController();

  late StreamController<QuerySnapshot> _streamController;

  final notifHapus = SnackBar(
    content: Text(
      "Data Berhasil Dihapus.",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    duration: Duration(seconds: 3),
    padding: EdgeInsets.all(10),
    backgroundColor: const Color.fromARGB(255, 172, 0, 0),
  );

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
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
          title: Text(
            'Laptop Review',
            style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
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
                icon: const Icon(Icons.bar_chart, color: Colors.white),
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
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                ),
                accountName: Text("User"),
                accountEmail: Text(user?.email ?? ""),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/logo.png"),
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AuthGate(),
                    ),
                  );
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
              List<LaptopEntry> userEntries = snapshot.data!.docs
                  .map((doc) => LaptopEntry.fromMap(doc))
                  .toList();

              userEntries.sort((a, b) => b.date.compareTo(a.date));

              List<Widget> widgets = [];

              DateTime? lastDate;

              for (int i = 0; i < userEntries.length; i++) {
                final entry = userEntries[i];

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
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Hapus Data"),
                            content:
                                Text("Anda yakin ingin menghapus data ini ?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  laptopController.removeEntry(entry);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(notifHapus);
                                },
                                child: Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
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
