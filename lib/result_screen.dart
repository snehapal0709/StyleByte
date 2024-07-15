import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, List<Map<String, String>>> palette;

  ResultScreen({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Color Palette'),
        backgroundColor: Color(0xFFFF377F),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: palette.keys.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10, // Reduced spacing between items
                  runSpacing: 10, // Reduced spacing between lines
                  children: palette[category]!.map((color) {
                    String colorName = color.keys.first;
                    String colorCode = color.values.first;
                    return Container(
                      width: 60, // Adjust width for each item
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(int.parse(colorCode.substring(1, 7),
                                      radix: 16) +
                                  0xFF000000),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Colors.grey[300]!), // Added border
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            colorName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
