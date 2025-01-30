import 'package:flutter/material.dart';
import 'bmi_calculation_page.dart'; // BMI hesaplama sayfasını ayrı dosyadan import ediyoruz

void main() {
  runApp(MaterialApp(
    home: CalorieCalculationPage(),
  ));
}

class CalorieCalculationPage extends StatefulWidget {
  @override
  _CalorieCalculationPageState createState() => _CalorieCalculationPageState();
}

class _CalorieCalculationPageState extends State<CalorieCalculationPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _isMale = true;
  int _calorieResult = 2844;

  void _calculateCalories() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;
    final age = int.tryParse(_ageController.text) ?? 0;

    if (weight > 0 && height > 0 && age > 0) {
      double bmr;
      if (_isMale) {
        bmr = 10 * weight + 6.25 * height - 5 * age + 5;
      } else {
        bmr = 10 * weight + 6.25 * height - 5 * age - 161;
      }

      setState(() {
        _calorieResult = bmr.round();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalori Hesaplama")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Başlık kısmı eklendi
            const SizedBox(height: 20),
            Text(
              'Fitsphre',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Mor renk
                fontFamily: 'Poppins', // Google Font
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kalori Hesaplama',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.purple, width: 4),
              ),
              child: Center(
                child: Text(
                  '$_calorieResult',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InputField(controller: _weightController, label: 'Kilonuz (kg)'),
            InputField(controller: _heightController, label: 'Boyunuz (cm)'),
            InputField(controller: _ageController, label: 'Yaşınız'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCalories,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                'Hesapla',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // BMI sayfasına yönlendirecek
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BmiCalculationPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                'BMI Hesapla',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  InputField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
