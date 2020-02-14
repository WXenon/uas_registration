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
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { VERIFYING, UNAUTHENTICATED, AUTHENTICATED_USER }

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

class MsalToken {
  final String name;
  final String email;
  final String jwt;

  MsalToken({this.name, this.email, this.jwt});

  Future<void> store() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', jwt);
  }

  Future<String> token() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  Future<void> remove() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
  }

  factory MsalToken.fromJwt(String jwt) {
    final jwtParts = jwt.split('.');
    var jwtPayload = base64Url.normalize(jwtParts[1]);
    var decodedToken = json.decode(utf8.fuse(base64Url).decode(jwtPayload));
    return MsalToken(
        name: decodedToken['name'], email: decodedToken['upn'], jwt: jwt);
  }
}

class _LoginPage extends State<LoginPage> {

  TextEditingController usernameController = new TextEditingController(), pwdController = new TextEditingController();

  MsalMobile msal;
  AuthStatus _status = AuthStatus.UNAUTHENTICATED;
  MsalToken _msalToken;

  @override
  void initState() {
    super.initState();
    MsalMobile.create('assets/auth_config.json', 'https://login.microsoftonline.com/fc418f16-5c93-437d-b743-05e9e2a04d93').then((client) {
      setState(() {
        msal = client;
        login();
      });
    });
  }

//  _launchURL() async {
//    final url = 'https://uasrdblogin.azurewebsites.net';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

//  bool loginSuccess(String username, String password){
//    bool success = false;
//    http
//        .post("https://uasrdblogin.azurewebsites.net",
//        headers: {
//          "Content-type": "application/json"
//        },
//        body: json.encode({
//          "username": username,
//        }))
//        .then((onValue) {
//      Map<String, dynamic> response =
//      json.decode(onValue.body);
//      if (password == response.toString()){
//        success = true;
//      }
//      return success;
//    });
//  }

  void _msalErrorHandler(exception, {Function callback}) {
    if (exception is MsalMobileException) {
      print(exception.errorCode);
      print(exception.message);
      if (exception.innerException != null) {
        print(exception.innerException.errorCode);
        print(exception.innerException.message);
      }
      if (callback != null) {
        callback();
      }
    } else {
      print('exception occurred');
    }
  }

  login() async{
    await msal.signIn(null, ["api://fc418f16-5c93-437d-b743-05e9e2a04d93/signin"]).then((result) async{
      if (result.cancelled) {
        _status = AuthStatus.UNAUTHENTICATED;
      } else if (result.success) {
        _status = AuthStatus.AUTHENTICATED_USER;
        var pref = await SharedPreferences.getInstance();
        await pref.setString('user_type', 'user');
        _msalToken = MsalToken.fromJwt(result.accessToken);
        await _msalToken.store();
      }
    }).catchError((exception) => _msalErrorHandler(exception, callback: () {
      //exception.errorcode.toString.contains('already'
      if (exception.errorCode.toString().contains('already')) {
        _status = AuthStatus.AUTHENTICATED_USER;
      } else {
        _status = AuthStatus.UNAUTHENTICATED;
        }
      }
    )
    );
  }

//  void login(String username, String password){
//    if(loginSuccess(username, password)){
//      Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegisteredAdmin()),);
//    }else{
//      Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegistered()),);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
      ),
    );
  }
}//login page logic
