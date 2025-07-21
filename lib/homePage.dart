import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxury_motors/admin_page.dart';
import 'package:luxury_motors/carDetails.dart';
import 'package:luxury_motors/widgets/custemCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedBrand = 'All';

  final List<String> brands = [
    'All',
    'BMW',
    'Mercedes',
    'Audi',
    'Lamborghini',
    'GAC',
    'Toyota',
    'Nissan',
    'Hyundai',
    'Kia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C2C2E), Color(0xFF1C1C1E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      const Text(
                        'Egypt, Cairo',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),

                      IconButton(
                        icon: Icon(
                          CupertinoIcons.add_circled,
                          color: Colors.white70,
                        ),
                        onPressed: () {
 Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const AdminPage(),
                                      ),);
                          },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Greeting
                  Row(
                    children: [
                      const Text(
                        "Hello, ",
                        style: TextStyle(fontSize: 35, color: Colors.white70),
                      ),
                      const Text(
                        "Ready to ride?",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Welcome to Luxury Motors",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Brand Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          brands.map((brand) {
                            final isSelected = brand == selectedBrand;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedBrand = brand;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      isSelected
                                          ? Colors.deepOrange
                                          : Colors.deepPurple,
                                  child: Text(
                                    brand,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Car Grid
                  StreamBuilder(
                    stream:
                        FirebaseFirestore.instance
                            .collection('cars')
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No cars found',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      final allCars = snapshot.data!.docs;
                      final filteredCars =
                          selectedBrand == 'All'
                              ? allCars
                              : allCars
                                  .where(
                                    (doc) =>
                                        doc['brand']?.toLowerCase() ==
                                        selectedBrand.toLowerCase(),
                                  )
                                  .toList();

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.82,
                            ),
                        itemCount: filteredCars.length,
                        itemBuilder: (context, index) {
                          final car = filteredCars[index];
                          return CarCard(
                            imageUrl: car['image'],
                            name: car['model'],
                            engine: car['engine'],
                            price: car['price'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsPage(carData: car),
                                ),
                              );
                            },
                            carData: car,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
