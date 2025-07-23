import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallSellerButton extends StatelessWidget {
  final String phoneNumber;

  const CallSellerButton({super.key, required this.phoneNumber});

  void _callNumber() async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $callUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: _callNumber,
        icon: const Icon(Icons.phone),
        label: const Text(
          'Call Seller',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
