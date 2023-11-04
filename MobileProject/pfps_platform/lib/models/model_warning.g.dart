// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarningModel _$WarningModelFromJson(Map<String, dynamic> json) => WarningModel(
      id: json['id'] as String,
      device_id: json['device_id'] as String,
      manual: json['manual'] as String,
      barrier_control: json['barrier_control'] as String,
      warning: json['warning'] as String,
      uptime: json['uptime'] as String,
    );

Map<String, dynamic> _$WarningModelToJson(WarningModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_id': instance.device_id,
      'manual': instance.manual,
      'barrier_control': instance.barrier_control,
      'warning': instance.warning,
      'uptime': instance.uptime,
    };
