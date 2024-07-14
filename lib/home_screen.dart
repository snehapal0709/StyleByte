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
      final palette = _getColorPalette(_skinTone, _hairColor, _eyeColor);
      _saveToFirestore(palette);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(palette: palette)),
      );
    }
  }

  List<String> _getColorPalette(
      String skinTone, String hairColor, String eyeColor) {
    // Predefined color palettes for every combination
    Map<String, List<String>> palettes = {
      '#F8D9C0_Black_Black': [
        '#FF5733',
        '#33FF57',
        '#3357FF',
        '#F1C40F',
        '#9B59B6'
      ],
      '#F8D9C0_Black_Dark Brown': [
        '#E74C3C',
        '#3498DB',
        '#2ECC71',
        '#F39C12',
        '#9B59B6'
      ],
      '#F8D9C0_Black_Light Brown': [
        '#1ABC9C',
        '#8E44AD',
        '#2980B9',
        '#E67E22',
        '#D35400'
      ],
      '#F8D9C0_Black_Blue': [
        '#2980B9',
        '#8E44AD',
        '#1ABC9C',
        '#F39C12',
        '#C0392B'
      ],
      '#F8D9C0_Black_Green': [
        '#27AE60',
        '#2980B9',
        '#8E44AD',
        '#E74C3C',
        '#F39C12'
      ],
      '#F8D9C0_Blonde_Black': [
        '#E67E22',
        '#3498DB',
        '#8E44AD',
        '#2ECC71',
        '#9B59B6'
      ],
      '#F8D9C0_Blonde_Dark Brown': [
        '#8E44AD',
        '#3498DB',
        '#E74C3C',
        '#1ABC9C',
        '#D35400'
      ],
      '#F8D9C0_Blonde_Light Brown': [
        '#2980B9',
        '#E67E22',
        '#8E44AD',
        '#F39C12',
        '#27AE60'
      ],
      '#F8D9C0_Blonde_Blue': [
        '#3498DB',
        '#1ABC9C',
        '#8E44AD',
        '#F39C12',
        '#C0392B'
      ],
      '#F8D9C0_Blonde_Green': [
        '#2ECC71',
        '#2980B9',
        '#8E44AD',
        '#E74C3C',
        '#F39C12'
      ],
      '#F8D9C0_Brown_Black': [
        '#E67E22',
        '#3498DB',
        '#8E44AD',
        '#2ECC71',
        '#9B59B6'
      ],
      '#F8D9C0_Brown_Dark Brown': [
        '#8E44AD',
        '#3498DB',
        '#E74C3C',
        '#1ABC9C',
        '#D35400'
      ],
      '#F8D9C0_Brown_Light Brown': [
        '#2980B9',
        '#E67E22',
        '#8E44AD',
        '#F39C12',
        '#27AE60'
      ],
      '#F8D9C0_Brown_Blue': [
        '#3498DB',
        '#1ABC9C',
        '#8E44AD',
        '#F39C12',
        '#C0392B'
      ],
      '#F8D9C0_Brown_Green': [
        '#2ECC71',
        '#2980B9',
        '#8E44AD',
        '#E74C3C',
        '#F39C12'
      ],
      '#F8D9C0_Grey_Black': [
        '#E67E22',
        '#3498DB',
        '#8E44AD',
        '#2ECC71',
        '#9B59B6'
      ],
      '#F8D9C0_Grey_Dark Brown': [
        '#8E44AD',
        '#3498DB',
        '#E74C3C',
        '#1ABC9C',
        '#D35400'
      ],
      '#F8D9C0_Grey_Light Brown': [
        '#2980B9',
        '#E67E22',
        '#8E44AD',
        '#F39C12',
        '#27AE60'
      ],
      '#F8D9C0_Grey_Blue': [
        '#3498DB',
        '#1ABC9C',
        '#8E44AD',
        '#F39C12',
        '#C0392B'
      ],
      '#F8D9C0_Grey_Green': [
        '#2ECC71',
        '#2980B9',
        '#8E44AD',
        '#E74C3C',
        '#F39C12'
      ],
      // Add combinations for other skin tones and combinations
    };

    String key = '${skinTone}_${hairColor}_${eyeColor}'.replaceAll(' ', '_');
    return palettes[key] ??
        [
          '#FFFFFF',
          '#000000',
          '#808080',
          '#C0C0C0',
          '#D3D3D3'
        ]; // Default palette if no match found
  }

  void _saveToFirestore(List<String> palette) {
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
      appBar: AppBar(title: Text('Find Your Color Palette')),
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
                decoration: const InputDecoration(labelText: 'Select Occasion'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select an occasion'
                    : null,
                onSaved: (value) => _occasion = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Get Palette'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
