import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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

//start of 2nd page after login

class UASRegistered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS Reg',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisteredUASPage(title: 'Registered UAS'),
    );
  }
}

class RegisteredUASPage extends StatefulWidget {
  RegisteredUASPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisteredUASPage createState() => _RegisteredUASPage();
}

class _RegisteredUASPage extends State<RegisteredUASPage> {

  TabController _controller;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  bool weightReq = false, pL_passive = false, pL_non_jett = false, pL_approvedConfByOEM = false, UASConf_approved = false, batteryInUAS = false,
      batteryInController = false, dF_returnHome = false, dF_emergLandingSysUser = false, dF_geoFencing = false,
      dF_2steppropulsion = false, cots = false, zeromarginSafety = false;

  void _weightReqChanged(bool value) { setState(() {weightReq = value;});}
  void _pL_passiveChanged(bool value) => setState(() => pL_passive = value);
  void _pL_non_jettChanged(bool value) => setState(() => pL_non_jett = value);
  void _pL_approvedConfByOEMChanged(bool value) => setState(() => pL_approvedConfByOEM = value);
  void _UASConf_approvedChanged(bool value) => setState(() => UASConf_approved = value);
  void _batteryInUASChanged(bool value) => setState(() => batteryInUAS = value);
  void _batteryInControllerChanged(bool value) => setState(() => batteryInController = value);
  void _dF_returnHomeChanged(bool value) => setState(() => dF_returnHome = value);
  void _dF_emergLandingSysUserChanged(bool value) => setState(() => dF_emergLandingSysUser = value);
  void _dF_geoFencingChanged(bool value) => setState(() => dF_geoFencing = value);
  void _dF_2steppropulsionChanged(bool value) => setState(() => dF_2steppropulsion = value);
  void _cotsChanged(bool value) => setState(() => cots = value);
  void _zeromarginSafetyChanged(bool value) => setState(() => zeromarginSafety = value);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: DefaultTabController(
          length: 2,
          child: new Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              bottom: new TabBar(
                controller: _controller,
                tabs: <Widget>[
                  new Tab(icon: new Icon(Icons.check)),
                  new Tab(icon: new Icon(Icons.create)),
                ],
              ),
            ),
              body: new TabBarView(children: [
                new Center(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.fromLTRB(0,25,0,0),
                        child: new Text('Registered UAS', style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
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
                ])
                ),
                new SingleChildScrollView(
                  child: new Center(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.fromLTRB(0,25,0,0),
                          child: new Text("Register a UAS", style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                        ),
                        new Align(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
                                child: new Text("BASELINE REQUIREMENTS", style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Column(
                            children: <Widget>[
                              new CheckboxListTile(
                                value: weightReq,
                                title: new Text("Max Take-off Weight 20kg or less"),
                                onChanged: _weightReqChanged,
                              ),
                              new CheckboxListTile(
                                value: pL_passive,
                                onChanged: _pL_passiveChanged,
                                title: new Text("Passive Payload"),
                              ),
                              new CheckboxListTile(
                                value: pL_non_jett,
                                onChanged: _pL_non_jettChanged,
                                title: new Text("Payload Non-Jettisonable"),
                              ),
                              new CheckboxListTile(
                                value: pL_approvedConfByOEM,
                                onChanged: _pL_approvedConfByOEMChanged,
                                title: new Text("Payload Approved Config by OEM"),
                              ),
                              new CheckboxListTile(
                                value: UASConf_approved,
                                onChanged: _UASConf_approvedChanged,
                                title: new Text("UAS Config approved Accessories by OEM"),
                              ),
                              new CheckboxListTile(
                                value: batteryInUAS,
                                onChanged: _batteryInUASChanged,
                                title: new Text("Battery(if Lithium) In UAS tested minimum UN 38.3 / UL 1642 or any of the following criteria: IEC62133 / UL 2054 / RTCA DO-311 / RTCA DO-227 / MIL-PRF-29595A"),
                              ),
                              new CheckboxListTile(
                                value: batteryInController,
                                onChanged: _batteryInControllerChanged,
                                title: new Text("Battery(if Lithium) In controller tested minimum UN 38.3 / UL 1642 or any of the following criteria: IEC62133 / UL 2054 / RTCA DO-311 / RTCA DO-227 / MIL-PRF-29595A"),
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
                                title: new Text("2 steps procedure for propulsion system to activate"),
                              ),
                              new CheckboxListTile(
                                value: cots,
                                onChanged: _cotsChanged,
                                title: new Text("Is the UAS a COTS item"),
                              ),
                              new CheckboxListTile(
                                value: zeromarginSafety,
                                onChanged: _zeromarginSafetyChanged,
                                title: new Text("Margin of Safety(SF 1.5) for (1)Joint Mechanism between tether to the VTOL UAS, (2)Anchoring Mechanism between the tether and Anchoring Point, (3)tether and (4)Length restraining mechanism(if any) at least 0"),
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  )
                )
              ])
          ),
        ),
        onWillPop: _onWillPop);}
}
