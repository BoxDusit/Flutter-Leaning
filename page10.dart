import 'package:flutter/material.dart';
import 'package:flutter_application_1/page9.dart';
class Page10 extends StatelessWidget {
  const Page10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section 10'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text('Menu',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
            ),
            ListTile(
              title: Text('Home Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page9()),
                );
              },
            ),
             ListTile(
              title: Text('สมัครสมาชิก'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page9()),
                );
              },
            ),
          ],
        ),
      ),

      body: Center()
    );
  }
}