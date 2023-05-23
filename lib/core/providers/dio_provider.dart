import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../global_variables.dart';

final dioProvider = Provider((ref) => Dio(BaseOptions(headers: authHeader(null))));