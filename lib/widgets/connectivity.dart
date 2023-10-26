import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectivityServices{


  late StreamSubscription subscription;

  var isDeviceConnected = false;

  bool isAlertSet = false;
  
  

   getConnectivity(BuildContext context) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;

      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox(context);
        
          isAlertSet = true;
       
      }
    });
  }

  showDialogBox(context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("No Connection"),
        content: const Text("Please check your internet connectivity"),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                
                  isAlertSet = false;
              
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox(context);
                
                    isAlertSet = true;
                  
                }
              },
              child: const Text('OK'))
        ],
      ),
    );
  }
}