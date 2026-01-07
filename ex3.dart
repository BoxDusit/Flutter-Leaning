import 'package:flutter/material.dart';

class Ex3 extends StatelessWidget {
  const Ex3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section 2'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Page 3', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('<<- Go to Back'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
