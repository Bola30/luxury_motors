import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luxury_motors/widgets/adminTextFeild.dart';
import 'package:luxury_motors/widgets/customButton.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _model = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _engine = TextEditingController();
  final TextEditingController _speed = TextEditingController();
  final TextEditingController _seats = TextEditingController();

  final List<String> brands = ['BMW', 'Mercedes', 'Audi', 'Lamborghini' , "GAC" , "Toyota" , "Nissan" , "Hyundai" , "Kia"];
  String? selectedBrand;
  XFile? _image;
  bool _loading = false;

  Future<String?> uploadImageToCloudinary(File imageFile) async {
    const cloudName = 'dchmqjrum';
    const uploadPreset = 'ml_default'; // أو أي preset عام عندك
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();
      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['secure_url'];
      } else {
        print('Upload failed: ${res.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Admin Panel', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(source: ImageSource.gallery);
                  if (picked != null) setState(() => _image = picked);
                },
                child: _image == null
                    ? Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Center(
                          child: Text('Tap to Upload Car Image', style: TextStyle(color: Colors.white70)),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_image!.path),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              Admintextfeild(controller: _model, hintText: 'Model', icon: const Icon(Icons.directions_car, color: Colors.black)),
              Admintextfeild(controller: _price, hintText: 'Price', icon: const Icon(Icons.attach_money, color: Colors.black)),
              Admintextfeild(controller: _engine, hintText: 'Engine', icon: const Icon(Icons.engineering, color: Colors.black)),
              Admintextfeild(controller: _speed, hintText: 'Speed', icon: const Icon(Icons.speed, color: Colors.black)),
              Admintextfeild(controller: _seats, hintText: 'Seats', icon: const Icon(Icons.event_seat, color: Colors.black)),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedBrand,
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: brands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                hint: const Text('Select Car Brand', style: TextStyle(color: Colors.white70)),
                onChanged: (v) => setState(() => selectedBrand = v),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: _loading ? 'Uploading...' : 'Add Car',
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() => _loading = true);
                        String? imageUrl;

                        if (_image != null) {
                          imageUrl = await uploadImageToCloudinary(File(_image!.path));
                          if (imageUrl == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Image upload failed.')),
                            );
                            setState(() => _loading = false);
                            return;
                          }
                        }

                        await FirebaseFirestore.instance.collection('cars').add({
                          'model': _model.text,
                          'price': _price.text,
                          'engine': _engine.text,
                          'speed': _speed.text,
                          'seats': _seats.text,
                          'brand': selectedBrand,
                          'image': imageUrl,
                          'created_at': Timestamp.now(),
                        });

                        setState(() {
                          _loading = false;
                          _image = null;
                          _model.clear();
                          _price.clear();
                          _engine.clear();
                          _speed.clear();
                          _seats.clear();
                          selectedBrand = null;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Car Added Successfully')),
                        );
                      },
                color: Colors.amber,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
