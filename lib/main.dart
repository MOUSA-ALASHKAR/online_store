import 'core/data/repositories/shared_preferences_repositories.dart';
import 'package:online_store/core/services/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/my_app.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() async {
    var sharedPref = await SharedPreferences.getInstance();
    return sharedPref;
  },
  );

  Get.put(SharedPreferencesRepositories());
  Get.put(CartService());

  runApp(const MyApp());
}