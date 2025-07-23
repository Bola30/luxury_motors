import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luxury_motors/widgets/callerSellerButton.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final DocumentSnapshot carData;

  const DetailsPage({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    final data = carData.data() as Map<String, dynamic>? ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(data['model'] ?? 'Car Details'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple, // Change the color of the back button
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  data['image'] ?? '',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Model
              Text(
                data['model'] ?? '',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Brand
              if (data.containsKey('brand'))
                Text(
                  "Brand: ${data['brand']}",
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),

              const SizedBox(height: 10),

              // Price
              Text(
                "Price: ${data['price'] ?? ''}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(height: 10),

              // Engine
              Text(
                "Engine: ${data['engine'] ?? ''}",
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 10),

              // Speed
              if (data.containsKey('speed'))
                Text(
                  "Top Speed: ${data['speed']}",
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),

              // Seats
              if (data.containsKey('seats'))
                Text(
                  "Seats: ${data['seats']}",
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                SizedBox(height: 20),
                
if (data.containsKey('phone'))
  Center(
    child:CallSellerButton(
      phoneNumber: data['phone'],
    ),
  ),


              const SizedBox(height: 20),

              // Description
              if (data.containsKey('description'))
                Text(
                  data['description'],
                  style: const TextStyle(fontSize: 16, color: Colors.white70 , fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
