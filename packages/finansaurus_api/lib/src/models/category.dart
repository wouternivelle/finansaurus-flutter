import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'json_map.dart';

part 'category.g.dart';

@immutable
@JsonSerializable()
class Category extends Equatable {
  Category({
    this.id,
    required this.name,
    required this.type,
    required this.hidden,
    required this.system,
    this.parent,
  });

  static Category empty() {
    return Category(
        name: '',
        parent: null,
        hidden: false,
        system: false,
        type: CategoryType.GENERAL);
  }

  final int? id;
  final String name;
  final CategoryType type;
  final bool hidden;
  final bool system;
  final int? parent;

  Category copyWith(
      {int? id,
      String? name,
      CategoryType? type,
      bool? hidden,
      bool? system,
      int? parent}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      hidden: hidden ?? this.hidden,
      system: system ?? this.system,
      parent: parent,
    );
  }

  static Category fromJson(JsonMap json) => _$CategoryFromJson(json);

  JsonMap toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id, name, type, hidden, system, parent];
}

enum CategoryType { GENERAL, INCOME_NEXT_MONTH, INCOME_CURRENT_MONTH, INITIAL }
