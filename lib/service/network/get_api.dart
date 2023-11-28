import 'dart:convert';
import '../../constants/api_endpoint.dart';
import 'package:http/http.dart' as http;

class GetProductAPI {
  Future getProductDetails() async {
    var url = Uri.parse(EndPoints.product);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}
