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
import 'package:uas_registration/providers/msal_provider.dart';
import 'dart:io';

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

  bool weightReq = false,
      pL_passive = false,
      pL_non_jett = false,
      pL_approvedConfByOEM = false,
      UASConf_approved = false,
      batteryInUAS = false,
      batteryInController = false,
      dF_returnHome = false,
      dF_emergLandingSysUser = false,
      dF_geoFencing = false,
      dF_2steppropulsion = false,
      cots = false,
      zeromarginSafety = false;
  void _weightReqChanged(bool value) {
    setState(() {
      weightReq = value;
    });
  }

  void _pL_passiveChanged(bool value) => setState(() => pL_passive = value);
  void _pL_non_jettChanged(bool value) => setState(() => pL_non_jett = value);
  void _pL_approvedConfByOEMChanged(bool value) =>
      setState(() => pL_approvedConfByOEM = value);
  void _UASConf_approvedChanged(bool value) =>
      setState(() => UASConf_approved = value);
  void _batteryInUASChanged(bool value) =>
      setState(() => batteryInUAS = value);
  void _batteryInControllerChanged(bool value) =>
      setState(() => batteryInController = value);
  void _dF_returnHomeChanged(bool value) =>
      setState(() => dF_returnHome = value);
  void _dF_emergLandingSysUserChanged(bool value) =>
      setState(() => dF_emergLandingSysUser = value);
  void _dF_geoFencingChanged(bool value) =>
      setState(() => dF_geoFencing = value);
  void _dF_2steppropulsionChanged(bool value) =>
      setState(() => dF_2steppropulsion = value);
  void _cotsChanged(bool value) => setState(() => cots = value);
  void _zeromarginSafetyChanged(bool value) =>
      setState(() => zeromarginSafety = value);

  void clickable() {
    if (weightReq &&
        pL_passive &&
        pL_non_jett &&
        pL_approvedConfByOEM &&
        UASConf_approved &&
        batteryInUAS &&
        batteryInController &&
        dF_returnHome &&
        dF_emergLandingSysUser &&
        dF_geoFencing &&
        dF_2steppropulsion &&
        cots &&
        zeromarginSafety) {
      Fluttertoast.showToast(
          msg: "Successful Submission",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
    } else {
      Fluttertoast.showToast(
          msg: "Unsuccessful Submission",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
    }
  }

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
                  children: [
                new Center(
                    child: new Column(children: <Widget>[
                  new Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: new Text(
                      'Registered UAS',
                      style: new TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                  //              new Expanded(child: new ListView.builder(
                  //                    itemCount: null,
                  //                    itemBuilder: (BuildContext, int index){
                  //                      String key = null;
                  //                      return new Row(
                  //                        children: <Widget>[
                  //                          new Text('${key} : '),
                  //                          new Text({key})
                  //                        ],
                  //                      );
                  //                    })
                  //              )
                ])),
                new SingleChildScrollView(
                    child: new Center(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                              child: new Text(
                                "Register a UAS",
                                style: new TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            new Align(
                              child: new Column(
                                children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent),
                                    borderRadius: new BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red,
                                        ),
                                    ]
                                  ),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: new Text(
                                          "BASELINE REQUIREMENTS",
                                          style: new TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      new Container(
                                          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.blueAccent),
                                              borderRadius: new BorderRadius.circular(30.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white,
                                                ),
                                              ]
                                          ),
                                          child: new Column(
                                            children: <Widget>[
                                              new CheckboxListTile(
                                                value: weightReq,
                                                onChanged: _weightReqChanged,
                                                title:
                                                new Text("Max Take-off Weight 20kg or less"),
                                              ),
                                              new CheckboxListTile(
                                                value: pL_passive,
                                                onChanged: _pL_passiveChanged,
                                                title: new Text("Passive Payload"),
                                              ),
                                              new CheckboxListTile(
                                                value: pL_non_jett,
                                                onChanged: _pL_non_jettChanged,
                                                title: new Text("Non-Jettisonable Payload"),
                                              ),
                                              new CheckboxListTile(
                                                value: pL_approvedConfByOEM,
                                                onChanged: _pL_approvedConfByOEMChanged,
                                                title: new Text("Approved Payload Config by OEM"),
                                              ),
                                              new CheckboxListTile(
                                                value: UASConf_approved,
                                                onChanged: _UASConf_approvedChanged,
                                                title: new Text(
                                                    "UAS Config approved Accessories by OEM"),
                                              ),
                                              new CheckboxListTile(
                                                value: batteryInUAS,
                                                onChanged: _batteryInUASChanged,
                                                title: new Text(
                                                    "Battery(if Lithium) In UAS tested minimum UN 38.3 / UL 1642 or any of the following criteria: IEC62133 / UL 2054 / RTCA DO-311 / RTCA DO-227 / MIL-PRF-29595A"),
                                              ),
                                              new CheckboxListTile(
                                                value: batteryInController,
                                                onChanged: _batteryInControllerChanged,
                                                title: new Text(
                                                    "Battery(if Lithium) In controller tested minimum UN 38.3 / UL 1642 or any of the following criteria: IEC62133 / UL 2054 / RTCA DO-311 / RTCA DO-227 / MIL-PRF-29595A"),
                                              ),
                                              new CheckboxListTile(
                                                value: dF_returnHome,
                                                onChanged: _dF_returnHomeChanged,
                                                title: new Text("Return home feature"),
                                              ),
                                              new CheckboxListTile(
                                                value: dF_emergLandingSysUser,
                                                onChanged: _dF_emergLandingSysUserChanged,
                                                title: new Text("Emergency Landing Feature"),
                                              ),
                                              new CheckboxListTile(
                                                value: dF_geoFencing,
                                                onChanged: _dF_geoFencingChanged,
                                                title: new Text("Geo-fencing Feature"),
                                              ),
                                              new CheckboxListTile(
                                                value: dF_2steppropulsion,
                                                onChanged: _dF_2steppropulsionChanged,
                                                title: new Text(
                                                    "2 steps procedure for propulsion system to activate"),
                                              ),
                                              new CheckboxListTile(
                                                value: cots,
                                                onChanged: _cotsChanged,
                                                title: new Text("Is the UAS a COTS item"),
                                              ),
                                              new CheckboxListTile(
                                                value: zeromarginSafety,
                                                onChanged: _zeromarginSafetyChanged,
                                                title: new Text(
                                                    "Margin of Safety(SF 1.5) for (1)Joint Mechanism between tether to the VTOL UAS, (2)Anchoring Mechanism between the tether and Anchoring Point, (3)tether and (4)Length restraining mechanism(if any) at least 0"),
                                              ),
                                              new Container(
                                                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                                  child: new Text(
                                                      "*DO NOTE THAT ALL IN BASELINE REQUIREMENTS ARE TO BE CHECKED TO BE ACCEPTED FOR REGISTRATION!",
                                                      style: new TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                          fontStyle: FontStyle.italic,
                                                          color: Colors.red))),
                                            ]
                                          )
                                      ),
                                    ]
                                  )
                                ),
                                  new Container(
                                    margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Text("SPECIFICATIONS", style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                        new Container(
                                            margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                                            padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.blueAccent),
                                                borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                          child: new Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Name of UAS',
                                                ),
                                              ),
                                              new Container(
                                                  margin: EdgeInsets.fromLTRB(0,10,0,10),
                                                  child: new Text("General Specs", style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
                                              ),
                                              new Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                                child: new TextField(
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  cursorColor: Colors.blue,
                                                  decoration: new InputDecoration(
                                                    labelText: 'UAS Planar Physical Area (m)',
                                                    hintText: 'See red box',
                                                  ),
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'UAS Drag Coefficient((Cd(-))',
                                                  hintText: '0.9 if unknown',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Maximum Thrust(N)',
                                                  hintText: '(N)',
                                                ),
                                              ),
                                              new Container(
                                                  margin: EdgeInsets.fromLTRB(0,20,0,10),
                                                  child: new Text("Propeller Specs", style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Propeller Diameter(m)',
                                                  hintText: '(m)',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Propeller Weight (kg)',
                                                  hintText: '(kg)',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Number of Blade per Propeller',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Propeller RPM(RPM)',
                                                  hintText: '(RPM)',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Propeller Drag Coefficient(Cd(-))',
                                                  hintText: '0.5 if unknown',
                                                ),
                                              ),
                                              new Container(
                                                  margin: EdgeInsets.fromLTRB(0,20,0,10),
                                                  child: new Text("GPS Specs", style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Max GPS Vertical Error (m)',
                                                  hintText: '0.7m if unknown',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Max GPS Horizontal Error(m)',
                                                  hintText: '7.8m if unknown',
                                                ),
                                              ),
                                              new Container(
                                                  margin: EdgeInsets.fromLTRB(0,20,0,10),
                                                  child: new Text("Battery Specs", style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Model',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Type',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Certification Standard',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Approx Maximum Flight Time (mins)',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Capacity (mAh)',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Voltage (V)',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Energy (Wh)',
                                                  hintText: '(Capacity/1000) x Voltage',
                                                ),
                                              ),
                                              new Container(
                                                  margin: EdgeInsets.fromLTRB(0,20,0,10),
                                                  child: new Text("Tether Specs", style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'OEM of Tethered System',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Material of the Tether',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Rated/Tested Strength of Tether',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Anchoring btw Tether and Anchoring Point',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Joint btw the Tether and UAS',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Strength of Anchor btw Tether and Anchor Point',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Strength of Joint btw Tether and UAS',
                                                ),
                                              ),
                                              new TextField(
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.blue,
                                                decoration: new InputDecoration(
                                                  labelText: 'Method restraining Deployed Tether Length',
                                                ),
                                              ),
                                            ],
                                          )
                                        ),
                                        new InkWell(
                                          onTap: clickable,
                                          child: new Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                              padding: EdgeInsets.fromLTRB(127, 20, 127, 20),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.blueAccent),
                                                  borderRadius: new BorderRadius.circular(30.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.cyanAccent,
                                                    ),
                                                  ]
                                              ),

                                            child: new Text("Submit Form", style: new TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
                                          )
                                        )
                                      ])
                                  )],
                              )
                            )
                          ]
                        )
                    )
                )]
              )
          )
        ),
    );
  }
}
