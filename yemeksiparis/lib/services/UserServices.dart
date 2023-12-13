import 'dart:convert';
import 'dart:io';
import 'package:yemeksiparis/models/ApiError.dart';
import 'package:yemeksiparis/models/User.dart';
import 'package:yemeksiparis/models/UserDetails.dart';
import 'package:yemeksiparis/widgets/msgToast.dart';
import 'package:http/http.dart' as http;
import 'package:yemeksiparis/models/ApiRespose.dart';

class UserServices {
  Future<ApiResponse> details(String userId) async {
    ApiResponse _apiResponse = new ApiResponse();
    ApiError _apiError = new ApiError();
    Uri url = Uri.parse('http://localhost:3000/userdetails');
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId,
        }),
      );

      switch (response.statusCode) {
        case 200:
          _apiResponse.data = UserDetails.fromJson(json.decode(response.body));
          break;
        case 401:
          print((_apiResponse.apiError as ApiError).error);
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          print((_apiResponse.apiError as ApiError).error);
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.apiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }

  Future<ApiResponse> login(String userName, String userPass) async {
    ApiResponse _apiResponse = new ApiResponse();
    Uri url = Uri.parse('http://192.168.43.27:8800/login');

    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userName,
          'user_pass': userPass,
        }),
      );

      switch (response.statusCode) {
        case 200:
          _apiResponse.data = User.fromJson(json.decode(response.body));
          msgToast('login Succesful');
          break;
        case 401:
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.apiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }

  Future<ApiResponse> signup(
      String userId, String username, String userPass) async {
    int isAdmin = 0;
    ApiResponse _apiResponse = new ApiResponse();
    Uri url = Uri.parse('http://192.168.43.27:8800/login/newuser');
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId,
          'user_name': username,
          'user_pass': userPass,
          'isAdmin': isAdmin.toString()
        }),
      );

      switch (response.statusCode) {
        case 200:
          _apiResponse.data = User.fromJson(json.decode(response.body));
          msgToast('SignUp Succesful');
          break;
        case 409:
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.apiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }

  Future<ApiResponse> user_detail_form(String user_id, String email,
      String phone, String address, String pincode) async {
//    int isAvailable= 0;
    ApiResponse _apiResponse = new ApiResponse();

    Uri url = Uri.parse('http://192.168.43.27:8800/');
    try {
      final http.Response response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': user_id,
          'user_email': email,
          'user_phno': phone,
          'user_addline': address,
          'user_pincode': pincode
        }),
      );

      switch (response.statusCode) {
        case 200:
          _apiResponse.data = User.fromJson(json.decode(response.body));
          msgToast('Dish Edit Succesful');
          break;
        case 409:
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          _apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.apiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }
}
