import 'package:flutter/material.dart';
import 'userLandingPage.dart';
import 'adminLandingPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:uas_registration/providers/msal_provider.dart';
import 'package:uas_registration/screens/authenticate/sign_in.dart';

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
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: Consumer(
            builder: (BuildContext context, MsalProvider msal, Widget) {
                  if (msal.status == AuthStatus.VERIFYING){
                    print(msal.status);
                    return SignIn();
                  }

                  else if (msal.status == AuthStatus.UNAUTHENTICATED){
                    print(msal.status);
                    return SignIn();
                  }
                  else if (msal.status == AuthStatus.AUTHENTICATED_USER){
                    print(msal.status);
                    return UASRegistered();
                  }
                  else {
                    msal.logout();
                    return SignIn();
                  }
            }
        ));
  }
}