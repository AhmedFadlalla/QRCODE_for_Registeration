import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/dio.dart';
import 'package:qr_code_app/models/user_model.dart';
import 'package:qr_code_app/modulus/cubit/state.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeCubit extends Cubit<QRCodeStates> {
  QRCodeCubit() :super(QRCodeInitialState());

  static QRCodeCubit get(context) => BlocProvider.of(context);


  UserData? model;
  Future<Map<String,dynamic>> getData(Barcode barcode)async{
   final response= await http.post(
      Uri.parse('https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/check_member/'),
      body: jsonEncode({
        "data":{
          "attendee_code":"$barcode"
        }
      }),
      headers:  {
        "Content-Type":"application/json"
      }
    );

   if (kDebugMode) {
     print('body ${json.decode(response.body)}');

   }return json.decode(response.body);


    
  }

  UserData? data;
  void getUserData(){

    emit(GetDataLoadingState());
    DioHelper.getData(url: 'https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/check_member/')
        .then((value) {

      data=UserData.fromJson(value.data);
      if (kDebugMode) {
        print(data);
      }
      emit(GetDataSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetDataErrorState(error.toString()));

    });
  }
}