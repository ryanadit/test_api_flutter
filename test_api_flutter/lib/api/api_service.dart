import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  static String url = "https://jsonplaceholder.typicode.com/";
  static String urlPosts = "posts";

  static posts() async {
    try {
      return checkRes(await getTest(url+urlPosts));
    }catch(e) {
      print(e);
      return checkException(e);
    }

  }

  static postsSearch(String id) async {
    try {
      return checkRes(await getTest(url+urlPosts+"/$id"));
    }catch(e) {
      print(e);
      return checkException(e);
    }

  }

  static Future<http.Response> getTest(String url) async{
    try{
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      return response;
    }catch (e) {
      return checkException(e);
    }

  }

  static checkRes(http.Response res) {
    if(res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes));
    } else {
      return jsonDecode(res.body);
    }
  }

  static checkException(dynamic exception){
    if(exception.toString().contains('SocketException')) {
      return 'NetworkError';
    } else {
      return null;
    }
  }




}