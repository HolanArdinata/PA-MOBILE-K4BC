import 'package:laptop_recommendation/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      next: Text("Selanjutnya"),
      done: Text("Selesai"),
      onDone: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return AuthGate();
            },
          ),
        );
      },
      pages: [
        PageViewModel(
          title: "Laptop Recommendation App",
          body:
              "Recommendation Laptop App is a mobile application designed to assist users in finding the most suitable laptops based on their specific needs and preferences",
          image: Image.asset(
            "assets/logo.png",
            height: 1000.0,
            width: 1000.0,
          ),
        ),
        PageViewModel(
          title: "See Various Laptop",
          body:
              "The app leverages a comprehensive database of laptops, considering various factors such as performance, specifications, and user reviews to provide personalized recommendations.",
          image: Image.asset(
            "assets/experience.png",
            height: 1000.0,
            width: 1000.0,
          ),
        ),
        PageViewModel(
          title: "For Laptop Enthusiast",
          body:
              "The Recommendation Laptop App aims to simplify the laptop selection process, providing users with tailored suggestions and valuable insights to make confident purchasing decisions. ",
          image: Image.asset(
            "assets/buyicon.png",
            height: 1000.0,
            width: 1000.0,
          ),
        ),
      ],
    );
  }
}
