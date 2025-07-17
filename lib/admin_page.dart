import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxury_motors/widgets/adminTextFeild.dart';
import 'package:luxury_motors/widgets/coustomColor.dart';
import 'package:luxury_motors/widgets/customButton.dart';
import 'package:luxury_motors/widgets/customtextfeild.dart';
import 'package:luxury_motors/widgets/dropDown.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController _model = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _engine = TextEditingController();
  TextEditingController _speed = TextEditingController();
  TextEditingController _seats = TextEditingController();
    List<String> availableColors = ['Red', 'Blue', 'Green', 'Black', 'White'];
     List<String> brands = ['BMW', 'Mercedes', 'Audi', 'Lamborghini'];
  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Admin Page',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PickColor(color: Colors.red),
                  Icon(CupertinoIcons.share_up),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
               child: Admintextfeild(
                    controller: _model,
                    hintText: 'Model',
                    icon: Icon(Icons.directions_car, ),
                    
                ),),
                Expanded(
                  child: Admintextfeild(
                    controller: _price,
                    hintText: 'Price',
                    icon: Icon(Icons.attach_money, ),
                  ),
                ),
                Expanded(
                  child: Admintextfeild(
                    controller: _engine,
                    hintText: 'Engine',
                    icon: Icon(Icons.engineering, ),
                  ),
                ),
              ],
            ),

           Admintextfeild(
              controller: _speed,
              hintText: 'Speed',
              icon: Icon(Icons.speed, ),
            ),
            Admintextfeild(
              controller: _seats,
              hintText: 'Seats',
              icon: Icon(Icons.event_seat, ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropDown(
                value: selectedBrand,
                items: brands.map((brand) => DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                )).toList(),
                hintText: 'Select Car Brand',
                onChanged: (value) {
                  setState(() {
                    selectedBrand = value as String?;
                  });
                }
              ),

            ),
            SizedBox(height: 10),
                          CustomButton(
                text: 'Add Car',
                onPressed: () {
                  // Add your logic to handle adding the car
                  print('Car Added: ${_model.text}, ${_price.text}, ${_engine.text}, ${_speed.text}, ${_seats.text}, $selectedBrand');
                }, color: Colors.white.withOpacity(0.2), 
              ),
          ],
        ),
      ),
    );
  }
}






          /* decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey, Colors.black],
            ),
          ),
          child: Center(
            child: Text(
              'Welcome to the Shop',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ), */