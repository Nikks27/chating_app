import 'package:flutter/material.dart';


class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Status Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
