import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_recommendation/controller/laptop_controller.dart';
import 'package:laptop_recommendation/pages/add_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/laptop_entry.dart';

class LaptopEntryWidget extends StatelessWidget {
  final LaptopEntry entry;
  final Function onDelete;
  final LaptopController laptopController = LaptopController();
  final User? user = FirebaseAuth.instance.currentUser;

  LaptopEntryWidget({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final String useremail = user?.email ?? "";
    return GestureDetector(
      onTap: entry.useremail != useremail
          ? () {}
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AddEntryView(
                    entry: entry,
                    laptopController: laptopController,
                  ),
                ),
              );
            },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          ? Colors.deepOrange
                          : Colors.grey,
                    ),
                  ),
                ),
                entry.useremail != useremail
                    ? Text("")
                    : IconButton(
                        icon: Icon(Icons.delete,
                            color: Color.fromARGB(255, 191, 33, 22)),
                        onPressed: () => onDelete(),
                      ),
              ],
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Username: ${entry.useremail}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Laptop Name: ${entry.laptopname}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Price: Rp.${entry.price}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "CPU: ${entry.processor}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "VGA: ${entry.graphic}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Brand: ${entry.brand}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Model Year: ${entry.modelyear}",
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 120,
                child: Image.network(
                  entry.imageurl,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
