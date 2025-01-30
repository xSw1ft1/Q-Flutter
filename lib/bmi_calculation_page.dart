import 'package:flutter/material.dart';

class BmiCalculationPage extends StatefulWidget {
  @override
  _BmiCalculationPageState createState() => _BmiCalculationPageState();
}

class _BmiCalculationPageState extends State<BmiCalculationPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmiResult = 0.0;

  void _calculateBmi() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      setState(() {
        _bmiResult = weight / (height / 100 * height / 100);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vücut Kitle Endeksi Hesapla")),
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
              'Vücut Kitle Endeksi',
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
                  '${_bmiResult.toStringAsFixed(1)}',
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBmi,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                'Hesapla',
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
