import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/core/enums/request_type.dart';

class NetworkConfig {
  static String BASE_API = '/';

  static String getFullApiUrl(String api) {
    return BASE_API + api;
  }

  static Map<String, String> getHeaders(
      {bool? needAuth = true,
        RequestType? type = RequestType.POST,
        Map<String, String>? extraHeaders = const {}}) {
    return {
      if (needAuth!)
        'Authorization':
        'Bearer ${storage.getTokenInfo()?.token ?? ''}',
      if (type != RequestType.GET) 'Content-Type': 'application/json',
      ...extraHeaders!
    };
  }
}