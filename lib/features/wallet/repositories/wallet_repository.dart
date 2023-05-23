import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../services/wallet_service.dart';


class WalletRepository {
  WalletRepository(this.service);

  final WalletService service;

  Future<Either<Failure, Unit>> mainToGame(String token, int amount) async {
    try {
      await service.mainToGameTransfer(token, amount);
      return right(unit);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> gameToMain(String token, int amount) async {
    try {
      await service.gameToMainTransfer(token, amount);
      return right(unit);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
