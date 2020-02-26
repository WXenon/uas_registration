import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:swiftchatbot/screens/menu.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:msal_mobile/msal_mobile.dart';
import 'package:uas_registration/providers/msal_provider.dart';
import 'package:uas_registration/providers/db_provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pd;
  MsalMobile msal;
  UASRegClient client = new UASRegClient();

  @override
  Widget build(BuildContext context) {
    pd = new ProgressDialog(context);
    pd.style(
        message: 'Signing In',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text(
                        'UAS Registration',
                        style: new TextStyle(fontSize: 40.0),
                      ),
                      SizedBox(height: 20.0),
//                      Image.asset(
//                        'assets/images/logo.png',
//                        scale: 1.0,
//                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25.0),
                          RaisedButton(
                              color: Colors.lightBlue[200],
                              child: Text('Microsoft Login',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                Provider.of<MsalProvider>(context, listen: false)
                                    .login();
                                await client.sendTaskRequest(Provider.of<MsalProvider>(context, listen: false).getAccount(), 1);
                                Provider.of<MsalProvider>(context, listen: false)
                                    .getAccount();
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}