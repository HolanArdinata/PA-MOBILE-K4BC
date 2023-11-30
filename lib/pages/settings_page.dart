// import 'dart:async';
// import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:laptop_recommendation/controller/laptop_controller.dart';
// import 'package:laptop_recommendation/pages/home_page.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => SettingsPageState();
// }

// class SettingsPageState extends State<SettingsPage> {
//   bool selected = false;
//   int _index = 1;
//   final LaptopController laptopController = LaptopController();
//   late StreamController<QuerySnapshot> _streamController;

//   void _onItemTap(int index) {
//     setState(() {
//       _index = index;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     _streamController = StreamController<QuerySnapshot>();

//     FirebaseAuth.instance.authStateChanges().listen((User? user) async {
//       if (user != null) {
//         laptopController.laptopEntryCollection.snapshots().listen(
//           (QuerySnapshot snapshot) {
//             _streamController.add(snapshot);
//           },
//         );
//       } else {
//         _streamController.close();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Settings",
//           style: GoogleFonts.sora(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text("Hollan Ardinata"),
//               accountEmail: Text("holanardinata733@gmail.com"),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage("assets/download.png"),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text(
//                 "Home",
//                 style: GoogleFonts.sora(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.account_circle_outlined),
//               title: Text(
//                 "Settings",
//                 style: GoogleFonts.sora(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SettingsPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text(
//                 "Logout",
//                 style: GoogleFonts.sora(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () async {
//                 await FirebaseAuth.instance.signOut();
//               },
//             )
//           ],
//         ),
//       ),
//       body:
//        Padding(
//         padding: const EdgeInsets.all(20),
//         child: ListView(
//           children: [
//             const SizedBox(height: 40),
//             Container(
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selected = !selected;
//                   });
//                 },
//                 child: AnimatedContainer(
//                   width: selected ? 1000.0 : 500.0,
//                   height: selected ? 200.0 : 100.0,
//                   color: selected ? Colors.grey.shade100 : Colors.grey.shade100,
//                   alignment: selected
//                       ? Alignment.center
//                       : AlignmentDirectional.topCenter,
//                   duration: const Duration(seconds: 1),
//                   curve: Curves.easeIn,
//                   child: CircleAvatar(
//                     radius: 70,
//                     backgroundImage: AssetImage('assets/holan.jpeg'),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             itemProfile('Name', 'Mochammad Hollan Ardinata Saragih',
//                 CupertinoIcons.person),
//             const SizedBox(height: 10),
//             itemProfile('NIM', '210916103', CupertinoIcons.info),
//             const SizedBox(height: 10),
//             itemProfile('Address', 'Jl.Kadrie Oening', CupertinoIcons.location),
//             const SizedBox(height: 10),
//             itemProfile(
//                 'Email', 'Holanardinata733@gmail.com', CupertinoIcons.mail),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: CupertinoButton(
//                   onPressed: () {
//                     final mySnackBar = SnackBar(
//                       content: Text("Profile edited."),
//                       duration: Duration(seconds: 3),
//                       padding: EdgeInsets.all(10),
//                       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//                     );
//                     ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
//                   },
//                   color: Colors.grey,
//                   child: Text(
//                     'Edit Profile',
//                     style: GoogleFonts.sora(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   itemProfile(String title, String subtitle, IconData iconData) {
//     return Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                   offset: Offset(0, 5),
//                   color: Color.fromARGB(255, 48, 176, 211).withOpacity(.2),
//                   spreadRadius: 2,
//                   blurRadius: 10)
//             ]),
//         child: ListTile(
//           title: Text(
//             title,
//             style: GoogleFonts.sora(),
//           ),
//           subtitle: Text(
//             subtitle,
//             style: GoogleFonts.sora(),
//           ),
//           leading: Icon(iconData),
//           trailing: Icon(Icons.arrow_forward, color: Colors.blue),
//           tileColor: Colors.white,
//         ));
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  SimpleUserCard(
                    userName: "Nom de l'utilisateur",
                    userProfilePic: AssetImage("assets/profilpic.png"),
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: CupertinoIcons.pencil_outline,
                        iconStyle: IconStyle(),
                        title: 'Appearance Appearance ...',
                        subtitle: "Make Ziar'App yours...",
                        titleMaxLine: 1,
                        subtitleMaxLine: 1,
                      ),
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.fingerprint,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: Colors.red,
                        ),
                        title: 'Privacy',
                        subtitle: "Lock Ziar'App to improve your privacy",
                      ),
                      SettingsItem(
                        onTap: () {
                          setState(() {
                            _themeMode = _themeMode == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                          });
                        },
                        icons: Icons.dark_mode_rounded,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: Colors.red,
                        ),
                        title: 'Dark mode',
                        subtitle: "Automatic",
                        trailing: Switch.adaptive(
                          value: _themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            setState(() {
                              _themeMode =
                                  value ? ThemeMode.dark : ThemeMode.light;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.info_rounded,
                        iconStyle: IconStyle(
                          backgroundColor: Colors.purple,
                        ),
                        title: 'About',
                        subtitle: "Learn more about Ziar'App",
                      ),
                    ],
                  ),
                  SettingsGroup(
                    settingsGroupTitle: "Account",
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.exit_to_app_rounded,
                        title: "Sign Out",
                      ),
                      SettingsItem(
                        onTap: () {},
                        icons: CupertinoIcons.repeat,
                        title: "Change email",
                      ),
                      SettingsItem(
                        onTap: () {},
                        icons: CupertinoIcons.delete_solid,
                        title: "Delete account",
                        titleStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

