import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:msal_mobile/msal_mobile.dart';
import 'package:uas_registration/newApplication.dart';
import 'package:uas_registration/providers/db_provider.dart';
import 'package:uas_registration/providers/msal_provider.dart';
import 'package:dio/dio.dart';

import 'pendingUASView.dart';

class UASRegistered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisteredUASPage(),
    );
  }
}

class RegisteredUASPage extends StatefulWidget {
  @override
  _RegisteredUASPage createState() => _RegisteredUASPage();
}

class Tabs {
  final String title;
  final IconData icon;
  Tabs({this.title,this.icon});
}

class _RegisteredUASPage extends State<RegisteredUASPage> with TickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pd;
  MsalMobile msal;
  TabController _controller;

  UASRegClient client = new UASRegClient();
//  Future<bool> _onWillPop() async {
//    return (await showDialog(
//          context: context,
//          builder: (context) => new AlertDialog(
//            title: new Text('Are you sure?'),
//            content: new Text('Do you want to exit an App'),
//            actions: <Widget>[
//              new FlatButton(
//                onPressed: () => Navigator.of(context).pop(false),
//                child: new Text('No'),
//              ),
//              new FlatButton(
//                onPressed: () => Navigator.of(context).pop(true),
//                child: new Text('Yes'),
//              ),
//            ],
//          ),
//        )) ??
//        false;
//  }



  final List<Tabs> _tabs = [new Tabs(title: "Registered UAS", icon: new IconData(58826, fontFamily: 'MaterialIcons')),
    new Tabs(title: "Registration", icon: IconData(57680, fontFamily: 'MaterialIcons'))
  ];

  Tabs _myHandler ;

  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _myHandler = _tabs[0];
    _controller.addListener(_handleSelected);
  }
  void _handleSelected() {
    setState(() {
      _myHandler= _tabs[_controller.index];
    });
  }

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
    return WillPopScope(
        onWillPop: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: DefaultTabController(
          length: 2,
          child: new Scaffold(
              appBar: AppBar(
                title: Text(_myHandler.title),
                actions: <Widget>[
                  FlatButton(
                      child: new Text("Logout"),
                      onPressed: () {
                        Provider.of<MsalProvider>(context, listen: false)
                            .logout();
                      }
                      )
                ],
                bottom: new TabBar(
                  controller: _controller,
                  tabs: <Widget>[
                    new Tab(icon: new Icon(_tabs[0].icon)),
                    new Tab(icon: new Icon(_tabs[1].icon))
                  ],
                ),
              ),
              body: new TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    PendingUASView(),
                    NewApplication()
                  ]
              )
          )
        ),
    );
  }
}
