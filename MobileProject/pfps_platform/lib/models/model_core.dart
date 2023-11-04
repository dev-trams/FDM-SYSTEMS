import 'package:json_annotation/json_annotation.dart';

part 'model_core.g.dart';

@JsonSerializable()
class CoreClient {
  final String data_number;
  final String license;
  final String address;
  final String device_id;
  final String barrier_value;
  final String water_value;
  final String temp_value;
  final String humi_value;
  final String uptime;

  CoreClient(
      {required this.data_number,
      required this.license,
      required this.address,
      required this.device_id,
      required this.barrier_value,
      required this.water_value,
      required this.temp_value,
      required this.humi_value,
      required this.uptime});

  factory CoreClient.fromJson(Map<String, dynamic> json) =>
      _$CoreClientFromJson(json);
  Map<String, dynamic> toJson() => _$CoreClientToJson(this);
}
