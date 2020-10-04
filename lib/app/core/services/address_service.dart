import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/core/models/address_model.dart';

part 'address_service.g.dart';

@Injectable()
class AddressService {
  final Dio dio;
  static const BASE_URL = 'https://viacep.com.br/ws';

  AddressService(this.dio);

  Future getAddress(String zipcode) async {
    try {
      Response response = await dio.get("$BASE_URL/$zipcode/json/");

      return AddressModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
      return AddressModel();
    }
  }
}
