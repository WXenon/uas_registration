import 'package:flutter/material.dart';
import 'userLandingPage.dart';
import 'adminLandingPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:uas_registration/providers/msal_provider.dart';
import 'package:uas_registration/screens/authenticate/sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas_registration/providers/db_provider.dart';
import 'package:uas_registration/models/dartmodel.dart';

void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)  => MsalProvider())
      ],
      child: UASReg(),
    )
);

class UASReg extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<UASReg> {

  UASRegClient client = new UASRegClient();
  int attempt;
  Users user;
  String fUsername, methodUsername, methodAdmin, futureAdmin;

  Future<String> getFUsername() async{
    fUsername = await Provider.of<MsalProvider>(context, listen: false).getAccount();
    return fUsername;
  }

  String getUsername(){
    getFUsername().then((fUsername) {
      methodUsername = fUsername;
    });
    return methodUsername;
  }
  
  Future<Users> getUser() async{
    Users user = await client.getExistingUser(getUsername());
    return user;
  }
  
  Future<String> getFutureAdmin() async{
    Users user = await client.getExistingUser(getUsername());
    futureAdmin = user.admin;
    return futureAdmin;
  }

  String getAdmin(){
    getFutureAdmin().then((futureAdmin){
      methodAdmin = futureAdmin;
    });
    return methodAdmin;
  }

  Future<String> getFExistingUser() async{
    Users resUser = await client.getExistingUser(getUsername());
    String resUsername = resUser.username;
    return resUsername;
  }

  String getExistingUsername(){
    getFExistingUser().then((username){
      methodUsername = username;
    });
    return methodUsername;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: Consumer(
            builder: (BuildContext context, MsalProvider msal, Widget)
            {
              if (msal.status == AuthStatus.VERIFYING) {
                print(msal.status);
                return SignIn();
              }
              else if (msal.status == AuthStatus.UNAUTHENTICATED) {
                for (attempt = 0; attempt > 0; attempt++){
                  if(attempt == 1){
                    Fluttertoast.showToast(
                        msg: "Please check your internet connection and try again",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else if (attempt > 1) {
                    Fluttertoast.showToast(
                        msg: "Could not login, please try again or approach an administrator",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                }
                print(msal.status);
                attempt++;
                return SignIn();
              }
              else if (msal.status == AuthStatus.AUTHENTICATED_USER && getExistingUsername() != "user not found") {
                print(getExistingUsername());
                if (getAdmin() == "1") {
                  return UASRegisteredAdmin();
                }
                else {
                  return UASRegistered();
                }
              }
              else {
                msal.logout();
                return SignIn();
              }
            }
            )
    );
  }
}