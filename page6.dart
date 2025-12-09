import 'package:flutter/material.dart';

class Page6 extends StatelessWidget {
  const Page6({super.key});

  final List<Map<String, dynamic>> dataItems = const [
    {'title' : 'ฟิล์มลองเกิบ', 'price' : 2000, 'age' : 15 ,'img' : 'images/1.png'},
    {'title' : 'ตี๋เวรี่กู้ด', 'price' : 3000, 'age' : 10 ,'img' : 'images/6.png'},
    {'title' : 'ต๋องโซคิ้ว', 'price' : 2500, 'age' : 8 ,'img' : 'images/7.png'},
    {'title' : 'ทิมไบเล่', 'price' : 4000, 'age' : 12 ,'img' : 'images/8.png'},
    {'title' : 'บอยสายมู', 'price' : 3500, 'age' : 14 ,'img' : 'images/23.png'},
    {'title' : 'ฟลุ๊กระเบิดขวด', 'price' : 5000, 'age' : 9 ,'img' : 'images/14.png'},];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ร้านสติกเกอร์ของพี่ชายนายเจล'),
        backgroundColor: Colors.black87,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        itemCount: dataItems.length,  
        itemBuilder: (context, index) {
          final item = dataItems[index];
          return Card(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    item['img'],
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart, size: 30, color: const Color.fromARGB(255, 0, 0, 0),),
                  title: Text(item['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  subtitle: Text('Price: ${item['price']} - Age: ${item['age']},', style: TextStyle(fontSize: 16),),
                  onTap: () {
                    final snackbar = SnackBar(
                      content: Text('You selected ${item['title']}'),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                ),
              ],
            ),
          );
        },
    ),
    );
  }
}
