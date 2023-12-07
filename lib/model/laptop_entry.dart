import 'package:cloud_firestore/cloud_firestore.dart';

class LaptopEntry {
  final String? id;
  final DateTime date;
  final String useremail;
  final String laptopname;
  final String price;
  final String processor;
  final String graphic;
  final String ram;
  final String storage;
  final String resolution;
  final String inch;
  final String modelyear;
  final String brand;
  final String imageurl;
  final int rating;

  LaptopEntry(
      {this.id,
      required this.date,
      required this.useremail,
      required this.laptopname,
      required this.price,
      required this.processor,
      required this.graphic,
      required this.ram,
      required this.storage,
      required this.resolution,
      required this.inch,
      required this.modelyear,
      required this.brand,
      required this.imageurl,
      required this.rating});

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'useremail': useremail,
      'laptopname': laptopname,
      'price': price,
      'processor': processor,
      'graphic': graphic,
      'ram': ram,
      'storage': storage,
      'resolution': resolution,
      'inch': inch,
      'modelyear': modelyear,
      'brand': brand,
      'imageurl': imageurl,
      'rating': rating,
    };
  }

  static LaptopEntry fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return LaptopEntry(
      id: doc.id,
      date: DateTime.parse(map['date'].toDate().toString()),
      useremail: map['useremail'],
      laptopname: map['laptopname'],
      price: map['price'],
      processor: map['processor'],
      graphic: map['graphic'],
      ram: map['ram'],
      storage: map['storage'],
      resolution: map['resolution'],
      inch: map['inch'],
      modelyear: map['modelyear'],
      brand: map['brand'],
      imageurl: map['imageurl'],
      rating: map['rating'],
    );
  }
}
