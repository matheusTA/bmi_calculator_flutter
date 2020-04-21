import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'BMI Calculaator',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculator() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100;
      double bmi = (weight / (height * height));

      if (bmi < 18.6) {
        _infoText = 'Abaixo do peso ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = 'Peso ideal ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = 'Levemente acima do peso ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = 'Obesidade grau I ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = 'Obesidade grau II ${bmi.toStringAsPrecision(4)}';
      } else if (bmi >= 40) {
        _infoText = 'Obesidade grau III ${bmi.toStringAsPrecision(4)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculadora de IMC',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.redAccent,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _weightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira seu peso';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.restaurant),
                        labelText: 'Peso (kg)*',
                      ),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira sua altura';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.directions_walk),
                        labelText: 'Altura (cm)*',
                      ),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculator();
                          }
                        },
                        child: Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
