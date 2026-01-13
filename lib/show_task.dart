import 'package:flutter/material.dart';

class ShowTask extends StatefulWidget {
  const ShowTask({super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'This is the ShowTask widget',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
