import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/laptop_controller.dart';
import '../model/laptop_entry.dart';

class AddEntryView extends StatefulWidget {
  final LaptopController laptopController;
  final LaptopEntry? entry;

  const AddEntryView({super.key, required this.laptopController, this.entry});

  @override
  State<AddEntryView> createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {
  late TextEditingController _laptopnameController;
  late TextEditingController _priceController;
  late TextEditingController _processorController;
  late TextEditingController _graphicController;
  late TextEditingController _ramController;
  late TextEditingController _storageController;
  late TextEditingController _resolutionController;
  late TextEditingController _inchController;
  late TextEditingController _modelyearController;
  late TextEditingController _brandController;
  late TextEditingController _imageurlController;

  late int _rating;
  late String laptopname;
  late String price;
  late String processor;
  late String graphic;
  late String ram;
  late String storage;
  late String resolution;
  late String inch;
  late String modelyear;
  late String brand;
  late String imageurl;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _rating = widget.entry?.rating ?? 3;
    _selectedDate = widget.entry?.date ??
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _laptopnameController =
        TextEditingController(text: widget.entry?.laptopname);
    _priceController = TextEditingController(text: widget.entry?.price);
    _processorController = TextEditingController(text: widget.entry?.processor);
    _graphicController = TextEditingController(text: widget.entry?.graphic);
    _ramController = TextEditingController(text: widget.entry?.ram);
    _storageController = TextEditingController(text: widget.entry?.storage);
    _resolutionController =
        TextEditingController(text: widget.entry?.resolution);
    _inchController = TextEditingController(text: widget.entry?.inch);
    _modelyearController = TextEditingController(text: widget.entry?.modelyear);
    _brandController = TextEditingController(text: widget.entry?.brand);
    _imageurlController = TextEditingController(text: widget.entry?.imageurl);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveEntry() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String useremail = user?.email ?? "";
    final String laptopname = _laptopnameController.text;
    final String price = _priceController.text;
    final String processor = _processorController.text;
    final String graphic = _graphicController.text;
    final String ram = _ramController.text;
    final String storage = _storageController.text;
    final String resolution = _resolutionController.text;
    final String inch = _inchController.text;
    final String modelyear = _modelyearController.text;
    final String brand = _brandController.text;
    final String imageurl = _imageurlController.text;

    if (laptopname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Laptop Name cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Price cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (double.tryParse(price) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Price must be a number',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (double.parse(price) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Price must be greater than zero',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (processor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Processor cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (graphic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Graphic Card cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (ram.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'RAM cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (storage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Storage cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (resolution.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Resolution cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (inch.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Inch cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (modelyear.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Model Year cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (brand.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Brand cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (imageurl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Image URL cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }

    final LaptopEntry newEntry = LaptopEntry(
        date: _selectedDate,
        useremail: useremail,
        laptopname: laptopname,
        price: price,
        processor: processor,
        graphic: graphic,
        ram: ram,
        storage: storage,
        resolution: resolution,
        inch: inch,
        modelyear: modelyear,
        brand: brand,
        rating: _rating,
        imageurl: imageurl);

    widget.laptopController.addEntry(newEntry).then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    });
  }

  void _updateEntry() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String useremail = user?.email ?? "";
    final String laptopname = _laptopnameController.text;
    if (laptopname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Laptop Name cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String price = _priceController.text;
    if (price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Price cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (double.tryParse(price) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Price must be a number',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    if (double.parse(price) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Price must be greater than zero',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String processor = _processorController.text;
    if (processor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Processor cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String graphic = _graphicController.text;
    if (graphic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Graphic Card cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String ram = _ramController.text;
    if (ram.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'RAM cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String storage = _storageController.text;
    if (storage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Storage cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String resolution = _resolutionController.text;
    if (resolution.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Resolution cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String inch = _inchController.text;
    if (inch.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Inch cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String modelyear = _modelyearController.text;
    if (modelyear.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Model Year cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String brand = _brandController.text;
    if (brand.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Brand cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }
    final String imageurl = _imageurlController.text;
    if (imageurl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Image URL cannot be empty',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 172, 0, 0)),
      );
      return;
    }

    final LaptopEntry updatedEntry = LaptopEntry(
        id: widget.entry!.id,
        date: _selectedDate,
        useremail: useremail,
        laptopname: laptopname,
        price: price,
        processor: processor,
        graphic: graphic,
        ram: ram,
        storage: storage,
        resolution: resolution,
        inch: inch,
        modelyear: modelyear,
        brand: brand,
        rating: _rating,
        imageurl: imageurl);

    widget.laptopController.updateEntry(updatedEntry).then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
        title: widget.entry == null
            ? Text(
                'Add Data Laptop',
                style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            : Text(
                'Edit Data Laptop',
                style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _laptopnameController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Laptop Name',
                    helperText: 'Add Laptop name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _priceController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    helperText: 'Add Price',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _processorController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Processor',
                    helperText: 'Add Processor',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _graphicController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Graphic Card',
                    helperText: 'Add Graphic Card',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ramController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'RAM',
                    helperText: 'Add RAM',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _storageController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Storage',
                    helperText: 'Add Storage',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _resolutionController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Resolution',
                    helperText: 'Add Resolution',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _inchController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Inch',
                    helperText: 'Add Inch',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _modelyearController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Model Year',
                    helperText: 'Add Model year',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _brandController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                    helperText: 'Add Brand',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _imageurlController,
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    helperText: 'Add Image Laptop With Link',
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Rate this laptop:'),
                ]),
                Row(
                  children: [
                    const Text('Very Bad'),
                    CupertinoSlider(
                      value: _rating.toDouble(),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      onChanged: (double value) {
                        setState(() {
                          _rating = value.toInt();
                        });
                      },
                    ),
                    const Text('Very Good'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Release Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: widget.entry == null ? _saveEntry : _updateEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize:
                        const Size(250, 50), // Atur lebar dan tinggi button
                    padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16), // Padding di sekitar icon dan teks
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Mengatur radius untuk membuat button rounded
                    ),
                  ),
                  child: widget.entry == null
                      ? Text(
                          'Add Laptop',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          'Update Laptop',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
