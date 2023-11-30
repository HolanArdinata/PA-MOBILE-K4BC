import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../controller/laptop_controller.dart';
import '../model/laptop_entry.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class AddEntryView extends StatefulWidget {
  final LaptopController laptopController;
  final LaptopEntry? entry;

  const AddEntryView({super.key, required this.laptopController, this.entry});

  @override
  State<AddEntryView> createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {
  Uint8List? _pickedImageBytes;
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

  Future<void> _uploadProfileImage(Uint8List imageBytes) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String imageName = 'profile_images/$userId.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imageName);
      UploadTask uploadTask = storageReference.putData(imageBytes);
      await uploadTask.whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();

      await FirebaseAuth.instance.currentUser
          ?.updateProfile(photoURL: imageUrl);

      print('Gambar berhasil diupload dan dihubungkan dengan akun pengguna.');
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final Uint8List uint8List = Uint8List.fromList(imageBytes);

      setState(() {
        _pickedImageBytes = uint8List;
      });
      await _uploadProfileImage(uint8List);
    }
  }

  void _saveEntry() {
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

    if (laptopname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (processor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (graphic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (ram.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (storage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (resolution.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (inch.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (modelyear.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (brand.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    if (brand.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }

    final LaptopEntry newEntry = LaptopEntry(
      date: _selectedDate,
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
    );

    widget.laptopController.addEntry(newEntry).then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    });
  }

  void _updateEntry() {
    final String laptopname = _laptopnameController.text;
    if (laptopname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String price = _priceController.text;
    if (price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String processor = _processorController.text;
    if (processor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String graphic = _graphicController.text;
    if (graphic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String ram = _ramController.text;
    if (ram.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String storage = _storageController.text;
    if (storage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String resolution = _resolutionController.text;
    if (resolution.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String inch = _inchController.text;
    if (inch.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String modelyear = _modelyearController.text;
    if (modelyear.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }
    final String brand = _brandController.text;
    if (brand.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This cannot be empty')),
      );
      return;
    }

    final LaptopEntry updatedEntry = LaptopEntry(
      id: widget.entry!.id,
      date: _selectedDate,
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
    );

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
        title: widget.entry == null
            ? Text('Add Data Entry')
            : Text('Edit Data Entry'),
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
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Laptop Name',
                    helperText: 'Add Laptop name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _priceController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    helperText: 'Add Price',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _processorController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Processor',
                    helperText: 'Add Processor',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _graphicController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Graphic Card',
                    helperText: 'Add Graphic Card',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ramController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'RAM',
                    helperText: 'Add RAM',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _storageController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Storage',
                    helperText: 'Add Storage',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _resolutionController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Resolution',
                    helperText: 'Add Resolution',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _inchController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Inch',
                    helperText: 'Add Inch',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _modelyearController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Model Year',
                    helperText: 'Add Model year',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _brandController,
                  maxLength: 100,
                  maxLines: 1, // This allows for multiple lines
                  keyboardType: TextInputType
                      .multiline, // This sets up the keyboard for multiline input
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                    helperText: 'Add Brand',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pick and Upload Image'),
                    ),
                    // const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Rate this laptop:'),
                    Slider(
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
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
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
                  child: widget.entry == null
                      ? Text('Save Entry')
                      : Text('Update Entry'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
