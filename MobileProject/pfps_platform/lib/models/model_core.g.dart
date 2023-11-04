// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreClient _$CoreClientFromJson(Map<String, dynamic> json) => CoreClient(
      data_number: json['data_number'] as String,
      license: json['license'] as String,
      address: json['address'] as String,
      device_id: json['device_id'] as String,
      barrier_value: json['barrier_value'] as String,
      water_value: json['water_value'] as String,
      temp_value: json['temp_value'] as String,
      humi_value: json['humi_value'] as String,
      uptime: json['uptime'] as String,
    );

Map<String, dynamic> _$CoreClientToJson(CoreClient instance) =>
    <String, dynamic>{
      'data_number': instance.data_number,
      'license': instance.license,
      'address': instance.address,
      'device_id': instance.device_id,
      'barrier_value': instance.barrier_value,
      'water_value': instance.water_value,
      'temp_value': instance.temp_value,
      'humi_value': instance.humi_value,
      'uptime': instance.uptime,
    };
