import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:get/get.dart';

class MobileNetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxString connectivtyType = "".obs;
  RxString endPoints = "".obs;
  final connTypeResult = Connectivity().checkConnectivity();
  final RxBool _connected = false.obs;
  final String ethIpV4 = "192.168.11.56";
  final String wIpV4 = "192.168.100.7";
  final String ulr = "https://oraahyo-backend.onrender.com";
  bool get isConnected => _connected.value;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    _connectivity.onConnectivityChanged.listen((event) {
      _connected.value = event != ConnectivityResult.none;
      updateConnectivity(event);
    });
  }

  Future<void> checkConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _connected.value = result != ConnectivityResult.none;
    updateConnectivity(result);
  }

  void updateConnectivity(ConnectivityResult result) {
    switch(result){
      case ConnectivityResult.wifi:
        endPoints.value = wIpV4;
        break;
      case ConnectivityResult.ethernet:
        endPoints.value = ethIpV4;
        break;
      default:
        endPoints.value = "No internet connection";
        break;
    }
  }
 
}
