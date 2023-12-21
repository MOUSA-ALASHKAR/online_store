import 'package:get/get.dart';
import 'package:online_store/UI/views/main_view/main_view.dart';
import 'package:online_store/core/services/base_controller.dart';

class SplashScreenController extends BaseController {

  @override
  void onInit() {

    Future.delayed(Duration(seconds: 3)).then((value) {Get.off(MainView());});
    super.onInit();
  }


}