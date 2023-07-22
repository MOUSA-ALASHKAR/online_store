import 'dart:convert';
import 'package:dartz/dartz.dart';
// import 'package:online_store/core/data/models/apis/products_model.dart';
// import 'package:online_store/core/data/models/common_response.dart';
// import 'package:online_store/core/data/network/endpoints/categories_endpoint.dart';
// import 'package:online_store/core/data/network/network_config.dart';
// import 'package:online_store/core/enums/request_type.dart';
// import 'package:online_store/core/utils/network_util.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<Either<String, List<String>>> getAll() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

      if (response.statusCode == 200) {
        final parsedResponse = jsonDecode(response.body).cast<String>();
        return Right(parsedResponse);
      } else {
        return Left('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}