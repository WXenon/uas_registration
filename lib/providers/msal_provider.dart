import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:msal_mobile/msal_mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_registration/models/dartmodel.dart';
import 'db_provider.dart';

enum AuthStatus { VERIFYING, UNAUTHENTICATED, AUTHENTICATED_USER }

class MsalProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.UNAUTHENTICATED;
  MsalMobile _msal;
  MsalToken _msalToken;

  MsalProvider() {
    _initMsal();
  }

  AuthStatus get status => _status;
  MsalToken get token => _msalToken;

  UASRegClient client = new UASRegClient();

  void _initMsal() async {
    await MsalMobile.create('assets/auth_config.json',
        'https://login.microsoftonline.com/fc418f16-5c93-437d-b743-05e9e2a04d93')
        .then((msalMobile) {
      _msal = msalMobile;
      notifyListeners();
    });
  }

  Future<Users> getFutureUser() async{
    return await client.getExistingUser(await getAccount());
  }

  Users getUser(){
    Users user = new Users();
    getFutureUser().then((fUser){
      user = fUser;
    });
    return user;
  }

  String getEmail(){
    String email = getUser().username;
    return email;
  }

  Future<void> login({bool admin = false}) async {
    await _msal.signIn(null, [
      "api://989d1e10-2f09-46ec-9d69-8718832ee1a4/signin"
    ]).then((result) async {
      if (result.cancelled) {
        _status = AuthStatus.UNAUTHENTICATED;
        notifyListeners();
      } else if (result.success) {
        print(await getAccount());
        _msalToken = MsalToken.fromJwt(result.accessToken);
        _msalToken.store().then((token) async{
          if ((await getAccount()) != null){
            getAccount().then((email) {
              client.getExistingUser(email).then((currentUser) async{
                if (currentUser.username == "user not found"){
                  String admin = "0";
                  client.createUser(email, admin).then((jsonResponse) async{
                    _status = AuthStatus.AUTHENTICATED_USER;
                    var pref = await SharedPreferences.getInstance();
                    await pref.setString('user_type', 'user');
                    notifyListeners();
                  });
                } else {
                  _status = AuthStatus.AUTHENTICATED_USER;
                  var pref = await SharedPreferences.getInstance();
                  await pref.setString('user_type', 'user');
                  _msalToken = MsalToken.fromJwt(result.accessToken);
                  await _msalToken.store();
                  notifyListeners();
                }
              });
            });
          }
          else{
            _status = AuthStatus.UNAUTHENTICATED;
            notifyListeners();
          }
        });
      }
    }).catchError((exception) => _msalErrorHandler(exception, callback: () {
      //exception.errorcode.toString.contains('already'
      if (exception.errorCode.toString().contains('already')) {
        _status = AuthStatus.AUTHENTICATED_USER;
      } else {
        _status = AuthStatus.UNAUTHENTICATED;
      }
      notifyListeners();
    }));
  }

  //Get Signed In Accounts
  Future<String> getAccount() async {
    String endResult;
    await _msal.getAccount().then((result) {
      if (result.currentAccount != null) {
        print('current account id: ${result.currentAccount.username}');
        _status = AuthStatus.AUTHENTICATED_USER;
        notifyListeners();
        endResult = result.currentAccount.username;
      } else {
        _status = AuthStatus.UNAUTHENTICATED;
        print('there is no current account id.');
        endResult = null;
      }
    });
    return endResult;
  }

  //Acquire tokens
  Future<void> acquireTokenSilently() async {
    var prefs = await SharedPreferences.getInstance();
    var userType = await prefs.getString('user_type');
    if (userType == 'user') {
      await _msal.acquireTokenSilent([
        'api://989d1e10-2f09-46ec-9d69-8718832ee1a4/signin'
      ], 'https://login.microsoftonline.com/fc418f16-5c93-437d-b743-05e9e2a04d93').then(
              (result) async {
            if (result.cancelled) {
              _status = AuthStatus.UNAUTHENTICATED;
              notifyListeners();
            } else if (result.success) {
              // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
              // pattern.allMatches(result.accessToken).forEach((match) => print(match.group(0)));
              _msalToken = MsalToken.fromJwt(result.accessToken);
              await _msalToken.store();
              _status = AuthStatus.AUTHENTICATED_USER;
              notifyListeners();
            }
          }).catchError((exception) => _msalErrorHandler(exception, callback: () {
        _status = AuthStatus.UNAUTHENTICATED;
        print(_status.toString());
        notifyListeners();
      }));
    }
  }

  Future<void> logout({Function callback}) async {
    await _msal.signOut().then((_) async {
      _status = AuthStatus.UNAUTHENTICATED;
      var prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_type');
      notifyListeners();
    }).catchError(
            (exception) => _msalErrorHandler(exception, callback: callback));
  }

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
}

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