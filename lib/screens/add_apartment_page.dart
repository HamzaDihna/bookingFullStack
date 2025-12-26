import 'package:flutter/material.dart';

class AddApartmentPage extends StatelessWidget {
  const AddApartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Apartment'),
      ),
      body: const Center(
        child: Text(
          'Add Apartment Form Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
