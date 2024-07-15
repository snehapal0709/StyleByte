import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _skinTone = '';
  String _hairColor = '';
  String _eyeColor = '';
  String _occasion = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final palette =
          _getColorPalette(_skinTone, _hairColor, _eyeColor, _occasion);
      _saveToFirestore(palette);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(palette: palette)),
      );
    }
  }

  Map<String, List<Map<String, String>>> _getColorPalette(
      String skinTone, String hairColor, String eyeColor, String occasion) {
    // Define color palettes for different combinations
    Map<String, Map<String, List<Map<String, String>>>> palettes = {
      '#f8d9c0_black_dark_brown': {
        'Neutral Colors': [
          {'Beige': '#F5F5DC'},
          {'Ivory': '#FFFFF0'},
          {'Taupe': '#483C32'},
          {'Cream': '#FFFDD0'}
        ],
        'Warm Colors': [
          {'Coral': '#FF7F50'},
          {'Terracotta': '#E2725B'},
          {'Warm Red': '#FF4500'},
          {'Mustard': '#FFDB58'}
        ],
        'Cool Colors': [
          {'Teal': '#008080'},
          {'Turquoise': '#40E0D0'},
          {'Navy': '#000080'},
          {'Olive Green': '#808000'}
        ],
        'Soft Pastels': [
          {'Peach': '#FFDAB9'},
          {'Mint Green': '#98FF98'},
          {'Lavender': '#E6E6FA'},
          {'Blush Pink': '#FFC0CB'}
        ],
        'Jewel Tones': [
          {'Emerald Green': '#50C878'},
          {'Ruby Red': '#9B111E'},
          {'Sapphire Blue': '#0F52BA'},
          {'Amethyst Purple': '#9966CC'}
        ],
      },
      // Add more combinations here
    };

    String key = '${skinTone}_${hairColor}_${eyeColor}'
        .toLowerCase()
        .replaceAll(' ', '_');

    // Debugging statements
    print('Generated key: $key');
    if (palettes.containsKey(key)) {
      print('Palette found for key $key: ${palettes[key]}');
    } else {
      print('No palette found for key $key, using default palette');
    }

    return palettes[key] ??
        {
          'Default': [
            {'White': '#FFFFFF'},
            {'Light Grey': '#CCCCCC'},
            {'Grey': '#999999'},
            {'Dark Grey': '#666666'}
          ]
        };
  }

  void _saveToFirestore(Map<String, List<Map<String, String>>> palette) {
    FirebaseFirestore.instance.collection('palettes').add({
      'skinTone': _skinTone,
      'hairColor': _hairColor,
      'eyeColor': _eyeColor,
      'occasion': _occasion,
      'palette': palette,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Color Palette'),
        backgroundColor: Color(0xFFFF377F),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _skinTone.isNotEmpty ? _skinTone : null,
                onChanged: (newValue) {
                  setState(() {
                    _skinTone = newValue!;
                  });
                },
                items: <String>[
                  '#F8D9C0',
                  '#E1AC8C',
                  '#B97D56',
                  '#7A4E2D',
                  '#542C1B',
                  '#311B0E'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      width: 24,
                      height: 24,
                      color: Color(int.parse(value.substring(1, 7), radix: 16) +
                          0xFF000000),
                    ),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: 'Select Your Skin Tone'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a skin tone'
                    : null,
                onSaved: (value) => _skinTone = value!,
              ),
              DropdownButtonFormField<String>(
                value: _hairColor.isNotEmpty ? _hairColor : null,
                onChanged: (newValue) {
                  setState(() {
                    _hairColor = newValue!;
                  });
                },
                items: <String>['Black', 'Blonde', 'Brown', 'Grey']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: 'Select Your Hair Color'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a hair color'
                    : null,
                onSaved: (value) => _hairColor = value!,
              ),
              DropdownButtonFormField<String>(
                value: _eyeColor.isNotEmpty ? _eyeColor : null,
                onChanged: (newValue) {
                  setState(() {
                    _eyeColor = newValue!;
                  });
                },
                items: <String>[
                  'Black',
                  'Dark Brown',
                  'Light Brown',
                  'Blue',
                  'Green'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: 'Select Your Eye Color'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select an eye color'
                    : null,
                onSaved: (value) => _eyeColor = value!,
              ),
              DropdownButtonFormField<String>(
                value: _occasion.isNotEmpty ? _occasion : null,
                onChanged: (newValue) {
                  setState(() {
                    _occasion = newValue!;
                  });
                },
                items: <String>['Party', 'Traditional', 'Casual', 'Formal']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: 'Select The Occasion'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select an occasion'
                    : null,
                onSaved: (value) => _occasion = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF377F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
