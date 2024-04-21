import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'json_map.dart';

part 'payee.g.dart';

@immutable
@JsonSerializable()
class Payee extends Equatable {
  Payee({
    this.id,
    required this.name,
    this.lastCategoryId = 0,
  });

  final int? id;
  final String name;
  final int lastCategoryId;

  Payee copyWith({int? id, String? name, int? lastCategoryId}) {
    return Payee(
      id: id ?? this.id,
      name: name ?? this.name,
      lastCategoryId: lastCategoryId ?? this.lastCategoryId,
    );
  }

  static Payee fromJson(JsonMap json) => _$PayeeFromJson(json);

  JsonMap toJson() => _$PayeeToJson(this);

  @override
  List<Object?> get props => [id, name, lastCategoryId];
}
