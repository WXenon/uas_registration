import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:msal_mobile/msal_mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _initMsal() async {
    await MsalMobile.create('assets/auth_config.json',
        'https://login.microsoftonline.com/fc418f16-5c93-437d-b743-05e9e2a04d93')
        .then((msalMobile) {
      _msal = msalMobile;
      notifyListeners();
    });
  }

  Future<void> login({bool admin = false}) async {
    await _msal.signIn(null, [
      "api://989d1e10-2f09-46ec-9d69-8718832ee1a4/signin"
    ]).then((result) async {
      if (result.cancelled) {
        _status = AuthStatus.UNAUTHENTICATED;
        notifyListeners();
      } else if (result.success) {
        _status = AuthStatus.AUTHENTICATED_USER;
        var pref = await SharedPreferences.getInstance();
        await pref.setString('user_type', 'user');
        _msalToken = MsalToken.fromJwt(result.accessToken);
        await _msalToken.store();
        notifyListeners();
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
  Future<void> getAccount() async {
    await _msal.getAccount().then((result) {
      if (result.currentAccount != null) {
        print('current account id: ${result.currentAccount.id}');
        _status = AuthStatus.AUTHENTICATED_USER;
        notifyListeners();
      } else if (result.currentAccount == null) {
        _status = AuthStatus.UNAUTHENTICATED;
        print('there is no current account id.');
      }
    });
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
    return await prefs.getString('user_token');
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