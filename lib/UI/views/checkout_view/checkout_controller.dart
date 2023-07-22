import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/main_view/main_view.dart';
import 'package:online_store/core/services/base_controller.dart';

class CheckoutController extends BaseController {
  @override
  void onClose() {
    cartService.clearCart();
    Get.off(MainView());
    super.onClose();
  }
}