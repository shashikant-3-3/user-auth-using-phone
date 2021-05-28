import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'phone_input.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 150, bottom: 20),
            child: new Image(
              image: new AssetImage('images/logo1.jpeg'),
            ),
          ),
          new Text(
            'Please select your Language',
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: new Text(
              'You can change the language\nat any time',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
            width: double.infinity,
            child: new DropDownList(),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 20),
            width: double.infinity,
            child: new ElevatedButton(
              style: new ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue[900],
                ),
              ),
              child: new Text(
                "NEXT",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhoneInput()));
              },
            ),
          ),
          new Expanded(
            child: new Align(
              alignment: Alignment.bottomCenter,
              child: new Image(
                width: double.infinity,
                fit: BoxFit.fill,
                image: new AssetImage('images/waves.jpeg'),
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
      ),
      decoration: new BoxDecoration(border: Border.all()),
      child: new DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['English', 'हिंदी', 'ਪੰਜਾਬੀ']
              .map<DropdownMenuItem<String>>((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
