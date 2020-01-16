import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'userLandingPage.dart';
import 'adminLandingPage.dart';

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

  String username = "", password = "";

  void login(String username, String password){
    if(username == "admin"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegisteredAdmin()),);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegistered()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              child: new Container(
                margin: EdgeInsets.all(32.0),
                  child: new TextField(
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.blue,
                      decoration: new InputDecoration(
                        labelText: 'Email',
                        icon: new Icon(Icons.email),
                        hintText: 'Email',
                      )
                  )
              )
            ),
            Align(
                child: new Container(
                    margin: EdgeInsets.fromLTRB(32, 0, 32, 32),
                    child: new TextField(
                        textAlign: TextAlign.start,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colors.blue,
                        decoration: new InputDecoration(
                          labelText: 'Password',
                          icon: new Icon(Icons.vpn_key),
                          hintText: 'Password',
                        )
                    )
                )
            ),
            Align(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 70, 0),
                          child: new RaisedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UASRegistered()),);
                          }, child: new Text('Login')),
                        )
                    ),
                    Align(
                        child: new Container(
                          child: new RaisedButton(onPressed: null, child: new Text('Sign Up')),
                        )
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}//login page logic
