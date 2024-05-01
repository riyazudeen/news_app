import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'model_class/news_data.dart';


final dio = Dio();


class Failure {
  late Object errorMessage;

  Failure({
    required this.errorMessage,
  });

  Failure.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'][0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorMessage'] = errorMessage;

    return data;
  }
}

class ApiHelper{



  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw Failure(errorMessage : response.statusMessage.toString());
      case 401:
      case 403:
        throw Failure(errorMessage : response.statusMessage.toString());
      case 500:
      default:
        throw Failure(errorMessage :
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }





  Future<dynamic> get(String url) async {
    var apiUrl =  url;
    print(url);
    dynamic responseJson;
    try {
      final response = await dio.get(apiUrl);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Failure(errorMessage :'No Internet connection');
    }

    return responseJson;
  }
}

class ApiServices{
  var myFormat = DateFormat('yyyy-MM-d');
  final  _helper = ApiHelper();

Future<NewsData> getNewsData() async {
 // print(myFormat.format(DateTime.now()));
  Map<String, dynamic> response = await _helper.get('https://newsapi.org/v2/everything?q=tesla&from=2024-04-29&sortBy=publishedAt&apiKey=8aa8f4f91bb5414cbe669cd59f08092a');
  return newsDataApiResponse(response);
}
}

