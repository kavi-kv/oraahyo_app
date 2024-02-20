import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxString connectivtyType = "".obs;
  final connTypeResult = Connectivity().checkConnectivity();
  final String ethIpV4 = "192.168.48.75";
  final String wIpV4 = "192.168.100.7";

  @override
  Future<void> onInit() async {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // _updateConnectionStatus(await _connectivity.checkConnectivity());

    // connTypeResult;
  }

  Future<String?> checkConnectionType() async {
    var endPoints = null;
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.ethernet) { ethIpV4;}
    else if(connectivityResult == ConnectivityResult.ethernet) {return wIpV4;}
    else{ return "There Is No Connection"; }
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  RxString connResult() {
    if (connTypeResult == ConnectivityResult.mobile) {
      connectivtyType = "Mobile Data".obs;
    } else {
      connectivtyType = "Wifi".obs;
    }
    return connectivtyType;
  }

  
}
