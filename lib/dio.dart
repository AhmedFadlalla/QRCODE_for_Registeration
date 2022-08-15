import 'package:dio/dio.dart';


class DioHelper{

   static  Dio? dio;


  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/check_member/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json',
        }



      )

    );

  }

 static Future<Response> getData({
      required String url,
      Map<String,dynamic>? query,
   int? id
})async{
   BaseOptions(
       receiveDataWhenStatusError: true,
       headers: {
         'Content-Type':'application/json',
       }

   );


   return await dio!.get(url,queryParameters: query);
}

static Future<Response> postData({
  required String url,
  Map<String,dynamic>? query,
  required Map<String,dynamic> data,
  String lang='ar',
  String? token,
})async{
    dio!.options.headers= {
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };


    return await dio!.post(url,queryParameters: query,data:  data);

}

}