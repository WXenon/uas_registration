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

  Future<Users> getAdmin(username) async {
    var client = AADClient();
    var res = await client.dio.get('$baseUrl/users', queryParameters:{
      'username': username
    });
    return Users.fromJson(res.data);
  }

  Future<Response> sendTaskRequest(username, admin) async {
    var client = AADClient();
    var res = await client.dio.post('$baseUrl/users', data: {
      'username': username,
      'admin': admin
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