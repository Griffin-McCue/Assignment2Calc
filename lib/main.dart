import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _operand1 = "";
  String _operator = "";
  String _operand2 = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _operand1 = "";
        _operator = "";
        _operand2 = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_operand1.isNotEmpty) {
          _operator = buttonText;
        }else if(_output != "0"){
            _operand1 = _output;
            _operator = buttonText;
            _output = "0";
        }
      } else if (buttonText == "=") {
        if (_operand1.isNotEmpty && _operator.isNotEmpty && _output.isNotEmpty) {
          _operand2 = _output;
          double num1 = double.parse(_operand1);
          double num2 = double.parse(_operand2);
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
              if (num2 != 0) {
                result = num1 / num2;
              } else {
                _output = "Error: Division by zero";
                return;
              }
              break;
          }
          _output = result.toString();
          _operand1 = "";
          _operator = "";
          _operand2 = "";
        }
      } else {
        if (_output == "0" || _operator.isNotEmpty) {
          _output = buttonText;
          if(_operator.isNotEmpty){
            _operator = "";
          }
        } else {
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}