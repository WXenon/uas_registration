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
  int admin, attempt;

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
                print(msal.status);
                attempt++;
                return SignIn();
              }
              else if (msal.status == AuthStatus.AUTHENTICATED_USER) {
//                client.sendTaskRequest(Provider.of<MsalProvider>(context, listen: false).getAccount(), 1);
//                if (client.sendTaskRequest(
//                    Provider.of<MsalProvider>(context, listen: false)
//                        .getAccount(), 1) != null) {
//                  void check() async {
//                    admin = (await client.getAdmin(
//                        Provider.of<MsalProvider>(context, listen: false)
//                            .getAccount())) as int;
//                  }
//                  check();
//                  if (admin != 0) {
//                    return UASRegisteredAdmin();
//                  }
//                  else {
//                    print(msal.status);
//                    return UASRegistered();
//                  }
//                }
//                else {
//                  void check() async {
//                    admin = (await client.getAdmin(
//                      Provider.of<MsalProvider>(context, listen: false)
//                          .getAccount())) as int;
//                  }
//                  check();
//                  if (admin != 0) {
//                    return UASRegisteredAdmin();
//                  }
//                  else {
                    print(msal.status);
                    return UASRegistered();
//                  }
//                }
              } else {
                msal.logout();
                return SignIn();
              }
            }
            )
    );
  }
}