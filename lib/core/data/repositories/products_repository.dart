import 'package:dartz/dartz.dart';
import 'package:online_store/core/data/models/apis/products_model.dart';
import 'package:online_store/core/data/models/common_response.dart';
import 'package:online_store/core/data/network/endpoints/get_all_products_endpoint.dart';
import 'package:online_store/core/data/network/network_config.dart';
import 'package:online_store/core/enums/request_type.dart';
import 'package:online_store/core/utils/network_util.dart';

class ProductsRepository {
  Future<Either<String, List<ProductsModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProductsEndpoint.getAll,
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
        CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<ProductsModel> result = [];
          commonResponse.data!.forEach(
                (element) {
              result.add(ProductsModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}