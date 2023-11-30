import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 140,
                    margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              );
            },
            footerBuilder: (context, action) {
              return Text(
                  "By Signing in, you agree to our terms and conditions",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sora(color: Colors.grey));
            },
          );
        }

        return HomePage();
      },
    );
  }
}
