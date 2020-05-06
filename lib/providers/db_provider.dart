import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:provider/provider.dart';
import 'package:uas_registration/models/dartmodel.dart';
import 'package:uas_registration/providers/msal_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:msal_mobile/msal_mobile.dart';

//String baseUrl = 'http://localhost:3000/v1';
// String baseUrl = 'http://uasr.database.windows.net';
String baseUrl = 'https://uasregdbconnect.azurewebsites.net/api';

@JsonSerializable(nullable: false)
class UASRegClient {

  Future<Users> getExistingUser(username) async {
    var client = AADClient();
    var res = await client.dio.get(baseUrl + '/users/getExisting', queryParameters:{
      'username': username
    });
    if (res.data is Map){
      print("user is Map");
      return Users.fromJson(res.data);
    }
    else if (res.data is String){
      print("user is String");
      print(res.data);
//      Map user = json.encode(res.data) as Map;
//      String jsonRes = "{'username':'" + res.data + "}";
      final jsonData = json.decode(res.data);
//      var map = Map<String, dynamic>.from(jsonData);
      return Users.fromJson(jsonData);
    }
    else{
      return Users.fromJson(res.data);
    }
  }

  Future<Users> createUser(String username, String admin) async {
    var client = AADClient();
    var res = await client.dio.post(baseUrl + '/users/create', data: {
      'username': username,
      'admin': admin
    });
    if (res.data is Map){
      print("user is Map");
      return Users.fromJson(res.data);
    }
    else if (res.data is String){
      print("user is String");
      print(res.data);
//      Map user = json.encode(res.data) as Map;
//      String jsonRes = "{'username':'" + res.data + "}";
      final jsonData = json.decode(res.data);
//      var map = Map<String, dynamic>.from(jsonData);
      return Users.fromJson(jsonData);
    }
    else{
      return Users.fromJson(res.data);
    }
  }

  Future<Users> getAdmin(username) async {
    var client = AADClient();
    var res = await client.dio.get(baseUrl + '/users/getAdmin', queryParameters:{
      'username': username
    });
    if (res.data is Map){
      print("user is Map");
      return Users.fromJson(res.data);
    }
    else if (res.data is String){
      print("user is String");
      print(res.data);
//      Map user = json.encode(res.data) as Map;
//      String jsonRes = "{'username':'" + res.data + "}";
      final jsonData = json.decode(res.data);
//      var map = Map<String, dynamic>.from(jsonData);
      return Users.fromJson(jsonData);
    }
    else{
      return Users.fromJson(res.data);
    }
  }

  Future<Response> createUAS(String username, String uasname, String physicalarea, String uasdragcoef, String maxthrust, String propellerdiameter, String propellerweight,
      String noofbladepropeller, String propellerrpm, String propdragcoef, String maxgpsverterr, String maxgpshorerr, String battmodel, String batttype, String battstandard,
      String battappoxmaxtime, String battcap, String battvolt, String battenergy, String oemoftethersystem, String materialoftether, String strengthoftether, String anchortetheranchor,
      String jointtetheruas, String strengthanchortetheranchor, String strengthjointtetheruas, String method) async {
    var client = AADClient();
    var res = await client.dio.post(baseUrl + '/uas/create', data: {
      'username': username,
      'uasname': uasname,
      'physicalarea': physicalarea,
      'uasdragcoef': uasdragcoef,
      'maxthrust': maxthrust,
      'propellerdiameter': propellerdiameter,
      'propellerweight': propellerweight,
      'noofbladepropeller': noofbladepropeller,
      'propellerrpm': propellerrpm,
      'propdragcoef': propdragcoef,
      'maxgpsverterr': maxgpsverterr,
      'maxgpshorerr': maxgpshorerr,
      'battmodel': battmodel,
      'batttype': batttype,
      'battstandard': battstandard,
      'battapproxmaxtime': battappoxmaxtime,
      'battcap': battcap,
      'battvolt': battvolt,
      'battenergy': battenergy,
      'oemoftethersystem': oemoftethersystem,
      'materialoftether': materialoftether,
      'strengthoftether': strengthoftether,
      'anchortetheranchor': anchortetheranchor,
      'jointtetheruas': jointtetheruas,
      'strenthanchortetheranchor': strengthanchortetheranchor,
      'strengthjointtetheruas': strengthjointtetheruas,
      'method': method
    });
    return res.data;
  }

  Future<Response> createUASR(String uasname, String physicalarea, String uasdragcoef, String maxthrust, String propellerdiameter, String propellerweight,
      String noofbladepropeller, String propellerrpm, String propdragcoef, String maxgpsverterr, String maxgpshorerr, String battmodel, String batttype, String battstandard,
      String battappoxmaxtime, String battcap, String battvolt, String battenergy, String oemoftethersystem, String materialoftether, String strengthoftether, String anchortetheranchor,
      String jointtetheruas, String strengthanchortetheranchor, String strengthjointtetheruas, String method) async {
    var client = AADClient();
    var res = await client.dio.post(baseUrl + '/uasr/create', data: {
      'uasname': uasname,
      'physicalarea': physicalarea,
      'uasdragcoef': uasdragcoef,
      'maxthrust': maxthrust,
      'propellerdiameter': propellerdiameter,
      'propellerweight': propellerweight,
      'noofbladepropeller': noofbladepropeller,
      'propellerrpm': propellerrpm,
      'propdragcoef': propdragcoef,
      'maxgpsverterr': maxgpsverterr,
      'maxgpshorerr': maxgpshorerr,
      'battmodel': battmodel,
      'batttype': batttype,
      'battstandard': battstandard,
      'battapproxmaxtime': battappoxmaxtime,
      'battcap': battcap,
      'battvolt': battvolt,
      'battenergy': battenergy,
      'oemoftethersystem': oemoftethersystem,
      'materialoftether': materialoftether,
      'strengthoftether': strengthoftether,
      'anchortetheranchor': anchortetheranchor,
      'jointtetheruas': jointtetheruas,
      'strenthanchortetheranchor': strengthanchortetheranchor,
      'strengthjointtetheruas': strengthjointtetheruas,
      'method': method
    });
    return res.data;
  }

  Future<Uas> getAllUas() async {
    var client = AADClient();
    var res = await client.dio.get(baseUrl + '/uas/');
    print(res.data);
    if (res.data is Map){
      print("is Map");
      return Uas.fromJson(res.data);
    }
    else if (res.data is String){
      print("is String");
      Map uasr = json.encode(res.data) as Map;
//      final jsonData = json.decode(res.data);
//      var map = Map<String, dynamic>.from(jsonData);
      return Uas.fromJson(uasr);
    }
    else{
      return Uas.fromJson(res.data);
    }
  }

  Future<Uas> getUas(String uasname) async {
    var client = AADClient();
    var res = await client.dio.get(baseUrl + '/uas/view', queryParameters: {
      'uasname': uasname,
    });
    print(res.data);
    if (res.data is Map){
      print("is Map");
      return Uas.fromJson(res.data);
    }
    else if (res.data is String){
      print("is String");
      Map uasr = json.encode(res.data) as Map;
//      final jsonData = json.decode(res.data);
//      var map = Map<String, dynamic>.from(jsonData);
      return Uas.fromJson(uasr);
    }
    else{
      return Uas.fromJson(res.data);
    }
  }

  Future<List<Uasr>> getUasr() async {
    var client = AADClient();
    var res = await client.dio.get(baseUrl + '/uasr/all');
    print(res.data);
//    var uasrObjsJson = jsonDecode(res.data)['uasr'] as List;
    List<Uasr> uasrList = List();
    res.data.foreach((key, value) => uasrList.add(res.data(key, value)));
//    if (res.data is Map){
//      print("is Map");
//      String uasr = Uasr.fromJson(res.data).toString();
//      List uasrList;
//      uasrList.add(uasr);
//      return uasrList;
//    }
//    else if (res.data is String){
//      print("is String");
//      List uasrList;
//      uasrList.add(res.data);
//      return uasrList;
//    }
//    else{
//      List uasrList;
//      uasrList.add(res.data);
      return uasrList;
  }

  Future<Response> deleteUASR(String uasname) async {
    var client = AADClient();
    var res = await client.dio.delete(baseUrl + '/uasr/delete', data: {
      'username': uasname,
    });
    return res;
  }

  Future<Response> deleteUAS(String uasname) async {
    var client = AADClient();
    var res = await client.dio.delete(baseUrl + '/uas/delete', data: {
      'username': uasname,
    });
    return res;
  }

  // Admin
//  Future<AdminCourses> getAdminCourses() async {
////    var client = AADClient();
////    var res = await client.dio.get('${baseUrl}/courses');
////    return AdminCourses.fromJson(res.data);
////  }

//  Future<Response> updateTaskRequest(status, verification_id) async {
//    var client = AADClient();
//    var tmpStatus = '';
//    if (status == TaskStatus.APPROVED) {
//      tmpStatus = 'APPROVED';
//    } else if (status == TaskStatus.REJECTED) {
//      tmpStatus = 'REJECTED';
//    }
//    var res = await client.dio.put('${baseUrl}/courses/task/update', data: {
//      'status': tmpStatus,
//      'verification_id': verification_id
//    });
//    return res;
//  }
}

class AADClient {
  final Dio dio = Dio();

  AADClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    // Cache
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
    // Add authorization header
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (Options options) async {
          var msalToken = await MsalToken().token();
          if (msalToken == null) {
            return dio.reject('MSALToken invalid');
          } else {
            options.headers['Authorization'] = 'Bearer $msalToken';
            return options;
          }
        }
    ));
  }
}