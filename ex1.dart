import 'package:flutter/material.dart';
import 'ex2.dart';
import 'ex3.dart';

class Ex1 extends StatelessWidget {
  const Ex1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section 1'),
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
              const Text('Page 1', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Ex2()),
                  );
                },
                child: const Text('Go to Page 2 ->>'),
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
