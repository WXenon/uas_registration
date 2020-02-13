import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'userLandingPage.dart';
import 'adminLandingPage.dart';
import 'package:http/http.dart' as http;
import 'package:msal_mobile/msal_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'msal_p'

void main() => runApp(UASReg());

class UASReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: MaterialApp(
          title: 'UAS Reg',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(title: 'Welcome to UAS Registration'),
        )
        , onWillPop: () async => true);
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}//login page interface



class _LoginPage extends State<LoginPage> {

  TextEditingController usernameController = new TextEditingController(), pwdController = new TextEditingController();

  MsalMobile msal;

  @override
  void initState() {
    super.initState();
    MsalMobile.create('assets/auth_config.json', "https://login.microsoftonline.com/Organizations").then((client) {
      setState(() {
        msal = client;
      });
    });
  }

  _launchURL() async {
    final url = 'https://uasrdblogin.azurewebsites.net';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool loginSuccess(String username, String password){
    bool success = false;
    http
        .post("https://uasrdblogin.azurewebsites.net",
        headers: {
          "Content-type": "application/json"
        },
        body: json.encode({
          "username": username,
        }))
        .then((onValue) {
      Map<String, dynamic> response =
      json.decode(onValue.body);
      if (password == response.toString()){
        success = true;
      }
      return success;
    });
  }

  void login(String username, String password){
//    if(loginSuccess(username, password)){
//      Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegisteredAdmin()),);
//    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegistered()),);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ,
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Align(
//              child: new Container(
//                margin: EdgeInsets.all(32.0),
//                  child: new TextField(
//                      controller: usernameController,
//                      textAlign: TextAlign.start,
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 18.0,
//                      ),
//                      keyboardType: TextInputType.emailAddress,
//                      cursorColor: Colors.blue,
//                      decoration: new InputDecoration(
//                        labelText: 'Email',
//                        icon: new Icon(Icons.email),
//                        hintText: 'Email',
//                      )
//                  )
//              )
//            ),
//            Align(
//                child: new Container(
//                    margin: EdgeInsets.fromLTRB(32, 0, 32, 32),
//                    child: new TextField(
//                        controller: pwdController,
//                        textAlign: TextAlign.start,
//                        obscureText: true,
//                        style: TextStyle(
//                          color: Colors.black,
//                          fontSize: 18.0,
//                        ),
//                        keyboardType: TextInputType.visiblePassword,
//                        cursorColor: Colors.blue,
//                        decoration: new InputDecoration(
//                          labelText: 'Password',
//                          icon: new Icon(Icons.vpn_key),
//                          hintText: 'Password',
//                        )
//                    )
//                )
//            ),
//            Align(
//                child: new Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Align(
//                        child: new Container(
//                          margin: EdgeInsets.fromLTRB(0, 0, 70, 0),
//                          child: new RaisedButton(onPressed: (){
//                            login(usernameController.text, pwdController.text);
//                          }, child: new Text('Login')),
//                        )
//                    ),
//                    Align(
//                        child: new Container(
//                          child: new RaisedButton(onPressed: null, child: new Text('Sign Up')),
//                        )
//                    ),
//                  ],
//                )
//            )
//          ],
//        ),
//      ),
    );
  }
}//login page logic
