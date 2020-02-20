import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:wolfpack/api/models.dart';
import 'package:wolfpack/providers/msal_provider.dart';

String baseUrl = 'http://localhost:3000/v1';
// String baseUrl = 'https://6b6c4c62.ngrok.io/v1';

class WolfpackClient {
  Future<Courses> getCourses() async {
    var client = AADClient();
    var res = await client.dio.get('${baseUrl}/courses/me');
    return Courses.fromJson(res.data);
  }

  Future<Users> getUsers() async {
    var client = AADClient();
    var res = await client.dio.get('${baseUrl}/users');
    return Users.fromJson(res.data);
  }

  Future<Response> sendTaskRequest(courseId, trainerId, bookTaskId) async {
    var client = AADClient();
    var res = await client.dio.post('${baseUrl}/courses/task', data: {
      'course_id': courseId,
      'trainer_id': trainerId,
      'booktask_id': bookTaskId
    });
    return res;
  }

  // Admin
  Future<AdminCourses> getAdminCourses() async {
    var client = AADClient();
    var res = await client.dio.get('${baseUrl}/courses');
    return AdminCourses.fromJson(res.data);
  }

  Future<Response> updateTaskRequest(status, verification_id) async {
    var client = AADClient();
    var tmpStatus = '';
    if (status == TaskStatus.APPROVED) {
      tmpStatus = 'APPROVED';
    } else if (status == TaskStatus.REJECTED) {
      tmpStatus = 'REJECTED';
    }
    var res = await client.dio.put('${baseUrl}/courses/task/update', data: {
      'status': tmpStatus,
      'verification_id': verification_id
    });
    return res;
  }
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