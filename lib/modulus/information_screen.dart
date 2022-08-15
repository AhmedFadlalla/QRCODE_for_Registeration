import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class InformationScreen extends StatelessWidget {
  final Barcode? result;

  const InformationScreen({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
        QRCodeCubit()..getData(result!),
        child: BlocConsumer<QRCodeCubit, QRCodeStates>(
          builder: (context, state) {
            var cubit = QRCodeCubit.get(context);
            var height=MediaQuery.of(context).size.height;
            return Scaffold(
              body: FutureBuilder(
                  future: cubit.getData(result!),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (kDebugMode) {
                      print(snapshot);

                    }List<Widget> children;
                    if (snapshot.hasData) {
                     children=  <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: height*0.1,),
                              const Image(image: AssetImage('assets/images/mind.png')),
                              SizedBox(height:height*0.01 ,),
                              displayDataFormat('ID', '${snapshot.data["data"][0]["id"]}'),
                              const SizedBox(height: 8,),
                              displayDataFormat('Code', '${snapshot.data["data"][0]["attendee_code"]}'),
                              const SizedBox(height: 8,),
                              displayDataFormat('Name', '${snapshot.data["data"][0]["name"]}')




                            ],
                          ),
                        )
                      ];
                    }
                    else {
                      children=<Widget>[
                        const Image(image: AssetImage('assets/images/mind.png')),
                        const Center(child: Text('Person isn\'n found'))
                      ];
                    }
                    return Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:children
                      ),
                    );
                  }
              ),
            );
          },
          listener: (context, state) {

          },
        )
    );
  }
  Widget displayDataFormat(text,data)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

       Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold
        ),
      )
      ,
      const SizedBox(height: 5,),
      Container(
          width: 180,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Center(
            child: Text(
              data,
              style:const  TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          )
      ),
    ],
  );
}
