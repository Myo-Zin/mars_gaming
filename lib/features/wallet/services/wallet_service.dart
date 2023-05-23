import 'package:dio/dio.dart';
import '../../../core/global_variables.dart';
import '../../../utils/url_constants.dart';

class WalletService {
  WalletService(this.dio);

  final Dio dio;

  Future<dynamic> mainToGameTransfer(String token, int amount) async {
    try {
      final resp = await dio.post(
        UrlConst.mainToGameTransferUrl,
        options: Options(headers: authHeader(token)),
        data: {
          "transfer_balance": amount,
        },
      );
      return resp.data;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> gameToMainTransfer(String token, int amount) async {
    try {
      final resp = await dio.post(
        UrlConst.gameToMainTransferUrl,
        options: Options(headers: authHeader(token)),
        data: {
          "transfer_balance": amount,
        },
      );
      return resp.data;
    } on DioError {
      rethrow;
    }
  }
}
