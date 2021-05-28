import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_selection.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class OTPVerification extends StatefulWidget {
  final String mobile;
  OTPVerification(this.mobile);
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController _otpController = TextEditingController();
  User _firebaseUser;
  String _status;
  AuthCredential _phoneAuthCredential;
  String _verificationId;
  int _code;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("firebase initialized");
      setState(() {
        _submitPhoneNumber();
        _getFirebaseUser();
      });
    });
  }

  void _handleError(e) {
    print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  void _getFirebaseUser() {
    this._firebaseUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _status =
          (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn\n';
    });
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((UserCredential authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        );
      }).catchError((e) => _handleError(e));
      setState(() {
        _status += 'Signed In\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber() async {
    String phoneNumber = "+91 " + widget.mobile;
    print(phoneNumber);

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        );
      });
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      _handleError(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());
      setState(() {
        _status += 'Code Sent\n';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 60000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void _submitOTP() {
    String smsCode = _otpController.text.toString().trim();

    this._phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: this._verificationId,
      smsCode: smsCode,
    );

    _login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: new InkWell(
          child: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 150),
            child: new Text(
              'Verify Phone',
              style: new TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveFlutter.of(context).fontSize(3.0),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: new Text(
              'Code is sent to ' + widget.mobile,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: ResponsiveFlutter.of(context).fontSize(2.0),
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: new TextField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          new Center(
            child: new Container(
              // margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('Didn\'t receive the code?'),
                  new TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue[900],
                      ),
                    ),
                    onPressed: () => _submitPhoneNumber(),
                    child: Text('Request Again'),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: new ElevatedButton(
              style: new ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue[900],
                ),
              ),
              child: new Text(
                "VERIFY AND CONTINUE",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () =>
                  (/*_otpController.text.length < 6 ? null : */ _submitOTP()),
            ),
          ),
        ],
      ),
    );
  }
}
