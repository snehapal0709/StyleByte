import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<String> palette;

  ResultScreen({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Palette')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: palette.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Color(
                  int.parse(palette[index].substring(1, 7), radix: 16) +
                      0xFF000000),
            );
          },
        ),
      ),
    );
  }
}
