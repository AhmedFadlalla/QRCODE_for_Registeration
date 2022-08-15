


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/modulus/information_screen.dart';
import 'package:qr_code_app/shared/component/components.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final qrKey=GlobalKey(debugLabel: 'qr');

  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }
  @override
  void reassemble()async {
    // TODO: implement reassemble
    super.reassemble();
    if(Platform.isAndroid){

      await controller!.pauseCamera();
    }
    await controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) =>SafeArea(child: Scaffold(
    body: Stack(
      alignment: Alignment.center,
      children: [
        buildQRCode(context),
        Positioned(bottom:10,
            child: buildResult() )
      ],
    ),

    ));

  Widget buildQRCode(BuildContext context)=>QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
    overlay:QrScannerOverlayShape(
      cutOutSize: MediaQuery.of(context).size.width*0.8,
      borderWidth: 10,
      borderLength: 20,
      borderRadius: 10,
      borderColor: Colors.blueAccent
    ),
    
  );
  Widget buildResult()=>Container(
    padding: const EdgeInsets.all(12),
    decoration: const BoxDecoration(
      color: Colors.white24
    ),
    child: Column(
      children: [
        Text(
          barcode !=null?'Result : ${barcode!.code}':'Scan Code'
        ),
        if(barcode!=null)
          defaultButton(function: (){
            controller!.stopCamera();
             navigateTo(context, InformationScreen(result: barcode! ));
            }, text: 'View Information')
      ],
    ),
  );
  void onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller=controller;
    });
    controller.scannedDataStream
        .listen((barcode) {

      setState(() {
        this.barcode=barcode;
      });
    });


  }
}
