import 'package:json_annotation/json_annotation.dart';
part 'model_warning.g.dart';

@JsonSerializable()
class WarningModel {
  final String id;
  final String device_id;
  final String manual;
  final String barrier_control;
  final String warning;
  final String uptime;

  WarningModel({
    required this.id,
    required this.device_id,
    required this.manual,
    required this.barrier_control,
    required this.warning,
    required this.uptime,
  });

  factory WarningModel.fromJson(Map<String, dynamic> json) =>
      _$WarningModelFromJson(json);
  Map<String, dynamic> toJson() => _$WarningModelToJson(this);
}
