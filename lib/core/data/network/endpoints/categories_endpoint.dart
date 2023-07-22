import 'package:online_store/core/data/network/network_config.dart';

class CategoriesEndpoint
{
  static String getCategories=NetworkConfig.getFullApiUrl('categories');
  static String getElectronics=NetworkConfig.getFullApiUrl("products/category/electronics");
  static String getJewelery=NetworkConfig.getFullApiUrl("products/category/jewelery");
  static String getMenClothing=NetworkConfig.getFullApiUrl("products/category/men's clothing");
  static String getWomenClothing=NetworkConfig.getFullApiUrl("products/category/women's clothing");
}