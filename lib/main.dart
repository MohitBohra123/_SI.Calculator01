import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      home: SIform(),
  theme: ThemeData(
      brightness : Brightness.dark,
      primaryColor : Colors.green,

  )));
}

class SIform extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds '];
  final _minimumPadding = 5.0;
  var _currentItemSelected = 'Rupees';
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();

  var displayResult = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Interest Calculator ')),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding,
                bottom: _minimumPadding,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller : principalControlled,
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g. 12000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding,
                bottom: _minimumPadding,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller : roiControlled,
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In Percentage%',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding,
                bottom: _minimumPadding,
              ),

              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller : termControlled,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Term ',
                        hintText: 'Time in years',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Container(width: _minimumPadding * 10),

                  Flexible(
                    child: DropdownButton<String>(
                      items:
                          _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String?newValueSelected) {


                        _onDropDownItemSelected(newValueSelected!);

                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 700,
                bottom: _minimumPadding * 5,
                top: _minimumPadding * 5,
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: ElevatedButton(
                      child: Text('Calculate'),
                      onPressed: () {
                        setState(() {
                          this.displayResult = _calculateTotalReturn(principalControlled,roiControlled,termControlled);
                        });
                      },
                    ),
                  ),
                  Container(width: _minimumPadding * 10),
                  Flexible(
                    child: ElevatedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        setState(() {
                         _reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding : EdgeInsets.only(left: 800,
                bottom: _minimumPadding,
                top: _minimumPadding*5,),
              child : Text(this.displayResult),
            )

          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('asset/bank_PNG29.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(child: image);
  }
  void _onDropDownItemSelected(String newValueSelected){
    setState;((){
     this._currentItemSelected = newValueSelected;
    });
  }
  String _calculateTotalReturn(dynamic principalController,roiController,termController)  {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term)/100;
    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;

  }
  void _reset(){
    principalControlled.text= '';
    roiControlled.text= '';
    termControlled.text= '';
    displayResult = '';
  }
}
