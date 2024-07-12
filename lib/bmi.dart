import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController _weightController = TextEditingController();
  double? _result;
  int? _feet = 0;
  int? _inches;
  String _conclusion = 'Result';
  String _error = '';

  void calculateBMI() {
    if (_feet == 0) {
      _error = "Enter Feet";
    } else if (_inches == null) {
      _error = "Enter Inches";
    } else if (_weightController.text == '') {
      _error = "Enter Weight";
    } else {
      int? feetComponent = _feet;
      int? inchesComponent = _inches;
      double weightInLBS = double.parse(_weightController.text);
      double heightInFeet = feetComponent! + (inchesComponent! / 12);
      double heightInM = heightInFeet / 3.281;
      double heightSquared = heightInM * heightInM;
      double weightInKg = weightInLBS / 2.205;
      _result = weightInKg / heightSquared;
      if (_result! < 18.5) {
        _conclusion = 'Underweight';
      } else if (_result! > 18.5 && _result! < 25) {
        _conclusion = 'Healthy';
      } else if (_result! > 25 && _result! < 30) {
        _conclusion = 'OverWeight';
      } else {
        _conclusion = 'Severely OverWeight';
      }
    }

    setState(() {});
  }

  List<DropdownMenuItem<int>> getDropdownItemsForFeet() {
    List<DropdownMenuItem<int>> list = [
      const DropdownMenuItem(
        value: 0,
        child: Text('Feet'),
      )
    ];
    for (int i = 3; i <= 7; i++) {
      var dropDownItem = DropdownMenuItem(
        value: i,
        child: Text('$i'),
      );
      list.add(dropDownItem);
    }
    return list;
  }

  List<DropdownMenuItem<int>> getDropdownItemsForInches() {
    List<DropdownMenuItem<int>> list = [
      const DropdownMenuItem(
        value: null,
        child: Text('Inches'),
      )
    ];
    for (int i = 0; i <= 11; i++) {
      var dropDownItem = DropdownMenuItem(
        value: i,
        child: Text('$i'),
      );
      list.add(dropDownItem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButton(
                    items: getDropdownItemsForFeet(),
                    value: _feet,
                    onChanged: (changedValue) {
                      setState(() {
                        _feet = changedValue;
                        print(_feet);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButton(
                    items: getDropdownItemsForInches(),
                    value: _inches,
                    onChanged: (changedValue) {
                      setState(() {
                        _inches = changedValue;
                        print(_inches);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight in lbs',
              ),
            ),
            const SizedBox(height: 50),
            OutlinedButton(
              onPressed: calculateBMI,
              child: const Text(
                "Calculate",
              ),
            ),
            const SizedBox(height: 50),
            Text(_conclusion),
            Text(
              _result == null
                  ? "Enter Value"
                  : '${_result?.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(_error),
          ],
        ),
      ),
    );
  }
}
