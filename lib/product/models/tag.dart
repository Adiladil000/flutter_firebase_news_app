import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_news_app/product/utility/base/base_firebase_model.dart';

@immutable
class Tag with EquatableMixin, IdModel, BaseFirebaseModel<Tag> {
  const Tag({
    this.id,
    this.name,
    this.active,
  });

  final String? name;
  final bool? active;
  @override
  final String? id;

  @override
  List<Object?> get props => [name, active];

  Tag copyWith({
    String? name,
    bool? active,
  }) {
    return Tag(
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'active': active,
    };
  }

  @override
  Tag fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] as String?,
      active: json['active'] as bool?,
    );
  }
}
