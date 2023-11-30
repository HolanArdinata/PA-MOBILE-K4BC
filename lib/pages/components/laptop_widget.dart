import 'package:google_fonts/google_fonts.dart';
import 'package:laptop_recommendation/controller/laptop_controller.dart';
import 'package:laptop_recommendation/pages/add_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/laptop_entry.dart';

class LaptopEntryWidget extends StatelessWidget {
  final LaptopEntry entry;
  final Function onDelete;
  final LaptopController laptopController = LaptopController();

  LaptopEntryWidget({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AddEntryView(
                  entry: entry, laptopController: laptopController)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade900),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(child: _pickedImageBytes != null
            //               ? Image.memory(_pickedImageBytes!,
            //                   fit: BoxFit.cover, width: 140, height: 140)
            //               : Image.network('assets/images/kursi.jpg',
            //                   fit: BoxFit.cover, width: 140, height: 140),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EE, MMM d').format(entry.date.toLocal()),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < entry.rating
                          ? Colors.deepPurple
                          : Colors.grey,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Laptop name: ${entry.laptopname}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Price: ${entry.price}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Processor: ${entry.processor}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Graphic Card: ${entry.graphic}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Brand: ${entry.brand}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Model Year: ${entry.modelyear}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

Widget contentDetailLaptop(
  BuildContext context,
  String namaLaptop,
  String poster1,
  String poster2,
  String description,
  String processor,
  String graphic,
  String ram,
  String storage,
  String Brand,
  // final tujuanBeli,
  final video,
) {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // CollectionReference laptopQueue = firestore.collection("laptop");

  var lebar = MediaQuery.of(context).size.width;
  return Scaffold(
    appBar: AppBar(
      title: Text(namaLaptop,
          style: GoogleFonts.sora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      // backgroundColor: background1,
    ),
    body: ListView(
      children: [
        Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 77, 77, 77)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: lebar,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(poster1))),
                ),
                Container(
                  width: lebar,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(poster2))),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: Container(
                  width: lebar / 2,
                  child: Text(
                    "BUY LAPTOP",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  // Get.to(tujuanBeli);
                },
                style: ElevatedButton.styleFrom(
                    // primary: tombol2, onPrimary: tombol1
                    ),
              ),
              ElevatedButton(
                child: Container(
                  // margin: EdgeInsets.all(
                  //   20,
                  // ),
                  width: lebar / 2,
                  child: Text(
                    "REVIEW VIDEO",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  // Get.to(video);
                },
                style: ElevatedButton.styleFrom(
                    // primary: tombol2, onPrimary: tombol1
                    ),
              )
            ],
          ),
        ),
        Divider(),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text(
            "DESCRIPTION",
            style: GoogleFonts.sora(
              fontSize: 20, fontWeight: FontWeight.bold,
              // color: text1
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            left: 15,
            right: 15,
          ),
          child: Text(description,
              textAlign: TextAlign.justify,
              style: GoogleFonts.sora(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text(
            "Processor :",
            style: GoogleFonts.sora(
              fontSize: 20, fontWeight: FontWeight.bold,
              // color: text1
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            left: 15,
          ),
          child: Text(
            processor,
            style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text(
            "Graphic Card :",
            style: GoogleFonts.sora(
              fontSize: 20, fontWeight: FontWeight.bold,
              //  color: text1
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            left: 15,
          ),
          child: Text(
            graphic,
            style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text(
            "RAM :",
            style: GoogleFonts.sora(
              fontSize: 20, fontWeight: FontWeight.bold,
              // color: text1
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            left: 15,
          ),
          child: Text(
            ram,
            style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text(
            "Storage :",
            style: GoogleFonts.sora(
              fontSize: 20, fontWeight: FontWeight.bold,
              // color: text1
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            left: 15,
            right: 15,
          ),
          child: Text(
            storage,
            style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text("Brand :",
              style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold,
                // color: text1
              )),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            left: 15,
          ),
          child: Text(
            Brand,
            style: GoogleFonts.sora(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    ),
  );
}
