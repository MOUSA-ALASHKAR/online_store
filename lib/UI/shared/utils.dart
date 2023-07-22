import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_store/core/data/repositories/shared_preferences_repositories.dart';
import 'package:online_store/core/services/cart_service.dart';

double screenWidth(double percent) {
  return Get.size.width / percent ;
}

double screenHeight(double percent) {
  return Get.size.height / percent ;
}

SharedPreferencesRepositories get storage =>
    Get.find<SharedPreferencesRepositories>();

CartService get cartService => Get.find<CartService>();


void customLoader() => BotToast.showCustomLoading(toastBuilder: (builder) {
  return Container(
    width: screenWidth(5),
    height: screenWidth(5),
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15)),
    child: SpinKitCircle(color: Colors.teal),
  );
});


double get taxAmount => 0.18;
double get deliveryAmount => 0.1;