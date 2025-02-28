import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "";
  String _num1 = "";
  String _num2 = "";
  String _operator = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "";
        _num1 = "";
        _num2 = "";
        _operator = "";
      } else if (value == "=") {
        if (_num1.isNotEmpty && _num2.isNotEmpty && _operator.isNotEmpty) {
          double num1 = double.parse(_num1);
          double num2 = double.parse(_num2);
          double result = 0;

          switch (_operator) {
            case "+":
              result = num1 + num2;
              break;
            case "-":
              result = num1 - num2;
              break;
            case "*":
              result = num1 * num2;
              break;
            case "/":
              result = num2 != 0 ? num1 / num2 : double.infinity;
              break;
          }
          _output = result.toString();
          _num1 = _output;
          _num2 = "";
          _operator = "";
        }
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_num1.isNotEmpty && _operator.isEmpty) {
          _operator = value;
        }
      } else {
        if (_operator.isEmpty) {
          _num1 += value;
          _output = _num1;
        } else {
          _num2 += value;
          _output = _num2;
        }
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              for (var row in [
                ["7", "8", "9", "/"],
                ["4", "5", "6", "*"],
                ["1", "2", "3", "-"],
                ["C", "0", "=", "+"]
              ])
                Row(
                  children: row.map((text) => _buildButton(text)).toList(),
                ),
            ],
          )
        ],
      ),
    );
  }
}
