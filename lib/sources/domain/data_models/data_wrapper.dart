import 'package:colored/sources/domain/data_models/items_wrapper.dart';
import 'package:vector_math/hash.dart';

class DataWrapper<T> {
  const DataWrapper({
    this.apiVersion,
    this.method,
    this.data,
  });

  factory DataWrapper.fromMap(
    Map<String, dynamic> map,
    ItemsWrapper<T> itemsWrapper,
  ) =>
      DataWrapper(
        apiVersion: map["apiVersion"],
        method: map["method"],
        data: itemsWrapper,
      );

  final String apiVersion;
  final String method;
  final ItemsWrapper<T> data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataWrapper &&
          runtimeType == other.runtimeType &&
          apiVersion == other.apiVersion &&
          method == other.method &&
          data == other.data;

  @override
  int get hashCode => hashObjects([apiVersion, method, data]);
}
