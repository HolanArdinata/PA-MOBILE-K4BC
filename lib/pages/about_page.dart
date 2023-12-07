// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class about_page extends StatefulWidget {
  const about_page({super.key});

  @override
  State<about_page> createState() => _about_pageState();
}

class _about_pageState extends State<about_page> {
  
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var tinggiLayar = MediaQuery.of(context).size.height;
    var lebarLayar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.primary,
        title: Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: Center(
        
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: selected ? 300 : 200,
                height: selected ? 300 : 200,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: lebarLayar,
            height: tinggiLayar - 500,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  """
Kelompok 4 BC 2023
Muhammad Irvan Hakim (2109106057)
Adhitya Saputra (2109106102)
M. Hollan Ardinata Saragih (2109106103)
Mardianto Tandi Ramma (2109106109)
                  """,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white
                      ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
