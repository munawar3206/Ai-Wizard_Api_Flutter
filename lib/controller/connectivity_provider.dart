
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/widgets/connectivity.dart';

class InternetConnectivityProvider extends ChangeNotifier {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  final InternetConnectivityServices _connectivityServices =
      InternetConnectivityServices();

  Future getInternetConnectivity(BuildContext context) async {
    _connectivityServices.getConnectivity(context); 
     isDeviceConnected=_connectivityServices .isDeviceConnected;
     isAlertSet=_connectivityServices.isAlertSet;
     subscription=_connectivityServices.subscription;
     
    
  }
  notifyListeners();
}

