import 'package:flutter/material.dart';
import 'ex3.dart';

class Ex2 extends StatelessWidget {
  const Ex2({super.key});

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
              const Text('Page 2', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('<<- Go to Homepage'),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Ex3()),
                  );
                },
                child: const Text('Go to Page 3 ->>'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
