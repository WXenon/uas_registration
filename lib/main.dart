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
  int admin, futureAdmin, attempt;
  Users user;
  String username;

  Future<String> getUsername() async{
    username = await Provider.of<MsalProvider>(context, listen: false).getAccount();
    return username;
  }
  
  Future<Users> getUser() async{
    Users user = await client.getUsers(getUsername());
    return user;
  }
  
  Future<int> getFutureAdmin() async{
    Users user = await client.getUsers(getUsername());
    futureAdmin = user.admin;
    return futureAdmin;
  }

  int getAdmin(){
    getFutureAdmin().then((futureAdmin){
      admin = futureAdmin;
    });
    return admin;
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
              else if (msal.status == AuthStatus.AUTHENTICATED_USER) {
                getAdmin();
                if (admin == 1) {
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