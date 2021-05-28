import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flag/flag.dart';
import 'package:flutter_application_1/otp_verification.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class PhoneInput extends StatefulWidget {
  @override
  _PhoneInput createState() => _PhoneInput();
}

class _PhoneInput extends State<PhoneInput> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: new InkWell(
          child: new Icon(
            Icons.close,
            color: Colors.black,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              child: new Center(
                child: new Text(
                  'Please enter your mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                  ),
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 10),
              child: new Center(
                child: new Text(
                  'You will receive a 4 digit code\nto verify next',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                  ),
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: new TextField(
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Mobile Number',
                  prefix: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Flag(
                        'IN',
                        height: 20,
                        width: 30,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: new Text(
                          '+91  -',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            new Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: new ElevatedButton(
                style: new ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue[900],
                  ),
                ),
                child: new Text(
                  "CONTINUE",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPVerification(_controller.text))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
