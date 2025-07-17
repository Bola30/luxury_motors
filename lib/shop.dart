import 'package:flutter/material.dart';
import 'package:luxury_motors/admin_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Shop',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey, Colors.black],
          ),
        ),
        child: Center(
          child:IconButton(onPressed: (){
            // Navigate to the admin page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          }, icon: Icon(Icons.admin_panel_settings, color: Colors.yellow, size: 100),),
    

        ),
      ),
    );
  }
}