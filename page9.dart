import 'package:flutter/material.dart';

class Page9 extends StatefulWidget {
  const Page9({super.key});

  @override
  State<Page9> createState() => _Page9State();
}

class _Page9State extends State<Page9> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _email;
  String? _educationLevel;
  String? _province;

  final List<String> _provinces = [
    'กรุงเทพมหานคร',
    'เชียงใหม่',
    'ภูเก็ต',
    'ขอนแก่น',
    'ชลบุรี',
    'นครราชสีมา',
    'สุราษฎร์ธานี',
    'สงขลา',
    'อุดรธานี',
    'พิษณุโลก',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section 9 - Form Validation'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ชื่อผู้ใช้',
                enabledBorder: UnderlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'ชื่อผู้ใช้ต้องมีอย่างน้อย 6 ตัวอักษร';
                }
                return null;
              },
              onSaved: (value) => _username = value,
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'รหัสผ่าน',
                enabledBorder: UnderlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
                }
                return null;
              },
              onSaved: (value) => _password = value,
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'อีเมล',
                enabledBorder: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null ||
                    !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'กรุณากรอกอีเมลที่ถูกต้อง';
                }
                return null;
              },
              onSaved: (value) => _email = value,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'เลือกระดับการศึกษา',
                enabledBorder: UnderlineInputBorder(),
              ),
              value: _educationLevel,
              items:
                  const [
                        'ไม่มีการศึกษา',
                        'ประถมศึกษา',
                        'มัธยมศึกษา',
                        'ปริญญาตรี',
                        'ปริญญาโท',
                        'ปริญญาเอก',
                      ]
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
              validator: (value) =>
                  value == null ? 'กรุณาเลือกระดับการศึกษา' : null,
              onChanged: (value) {
                setState(() {
                  _educationLevel = value;
                });
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'เลือกจังหวัด',
                enabledBorder: UnderlineInputBorder(),
              ),
              items: _provinces
                      .map(
                        (p) =>
                            DropdownMenuItem<String>(
                              child: Text(p),
                              value: p,
                            ),
                      )
                      .toList(),
              validator: (value) =>
                  value == null ? 'กรุณาเลือกจังหวัด' : null,
              onChanged: (value) {
                setState(() {
                  _province = value;
                });
              },
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'สมัครสมาชิกสำเร็จ\n'
                        'ชื่อผู้ใช้: $_username\n'
                        'อีเมล: $_email\n'
                        'รหัสผ่าน: $_password\n'
                        'ระดับการศึกษา: $_educationLevel\n'
                        'จังหวัด: $_province',
                      ),
                    ),
                  );
                }
              },
              child: const Text('สมัครสมาชิก'),
            ),
          ],
        ),
      ),
    );
  }
}
