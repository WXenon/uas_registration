import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:uas_registration/models/dartmodel.dart';
import 'package:uas_registration/providers/msal_provider.dart';
import 'package:json_annotation/json_annotation.dart';

//String baseUrl = 'http://localhost:3000/v1';
 String baseUrl = 'https://uasregdbconnect.azurewebsites.net';

@JsonSerializable(nullable: false)
class UASRegClient {
//  Future<Courses> getCourses() async {
//    var client = AADClient();
//    var res = await client.dio.get('${baseUrl}/courses/me');
//    return Courses.fromJson(res.data);
//  }

  Future<Users> getUsers(username) async {
    var client = AADClient();
    var res = await client.dio.get('$baseUrl/users/getSpec', queryParameters:{
      'username': username
    });
    return Users.fromJson(res.data);
  }

  Future<Response> createUser(String username, int admin) async {
    var client = AADClient();
    var res = await client.dio.post('$baseUrl/users/create', data: {
      'username': username,
      'admin': admin
    });
    return res;
  }

  Future<Response> createUAS(String username, String uasname, String physicalarea, String uasdragcoef, String maxthrust, String propellerdiameter, String propellerweight,
      String noofbladepropeller, String propellerrpm, String propdragcoef, String maxgpsverterr, String maxgpshorerr, String battmodel, String batttype, String battstandard,
      String battappoxmaxtime, String battcap, String battvolt, String battenergy, String oemoftethersystem, String materialoftether, String strengthoftether, String anchortetheranchor,
      String jointtetheruas, String strengthanchortetheranchor, String strengthjointtetheruas, String method) async {
    var client = AADClient();
    var res = await client.dio.post('$baseUrl/users/create', data: {
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
    return res;
  }

  Future<Response> createUASR(String uasname, String physicalarea, String uasdragcoef, String maxthrust, String propellerdiameter, String propellerweight,
      String noofbladepropeller, String propellerrpm, String propdragcoef, String maxgpsverterr, String maxgpshorerr, String battmodel, String batttype, String battstandard,
      String battappoxmaxtime, String battcap, String battvolt, String battenergy, String oemoftethersystem, String materialoftether, String strengthoftether, String anchortetheranchor,
      String jointtetheruas, String strengthanchortetheranchor, String strengthjointtetheruas, String method) async {
    var client = AADClient();
    var res = await client.dio.post('$baseUrl/users/create', data: {
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
    return res;
  }

  Future<Response> deleteUASR(String uasname) async {
    var client = AADClient();
    var res = await client.dio.post('$baseUrl/users/create', data: {
      'username': uasname,
    });
    return res;
  }

  Future<Response> deleteUAS(String uasname) async {
    var client = AADClient();
    var res = await client.dio.post('$baseUrl/users/create', data: {
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