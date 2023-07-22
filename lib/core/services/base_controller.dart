import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/core/enums/Operation_type.dart';
import 'package:online_store/core/enums/request_status.dart';

class BaseController extends GetxController {
  Rx<RequestStatus> requestStatus = RequestStatus.DEFAULT.obs;
  // Rx<OperationType> operationType = OperationType.NONE.obs;
  RxList<OperationType> listType = <OperationType>[].obs;

  Future runFutureFunction({required Future function}) async {
    return await function;
  }

  Future runLoadingFutureFunction(
      {required Future function,
        OperationType? type = OperationType.NONE}) async {

    requestStatus.value = RequestStatus.LOADING;
    // operationType.value = type!;
    listType.add(type!);
    await function;
    requestStatus.value = RequestStatus.DEFAULT;
    listType.remove(type);
    // operationType.value = OperationType.NONE;
  }

  Future runFullLoadingFutureFunction({
    required Future function,
  }) async {
    customLoader();
    await function;
    BotToast.closeAllLoading();
  }
}