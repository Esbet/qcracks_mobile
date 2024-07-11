

import 'micro_core_utils.dart';

abstract class Locator {
  void registerFactory<T extends Object>(FuncFactory<T> factoryFunc);
  T get<T extends Object>({String? instanceName, dynamic param1, dynamic param2, Type? type});
}
