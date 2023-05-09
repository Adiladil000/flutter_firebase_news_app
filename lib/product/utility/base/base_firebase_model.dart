import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_news_app/product/utility/exception/custom_exception.dart';

abstract class IdModel {
  String? get id;
}

abstract class BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw FireBaseCustomException('$snapshot data is null');
    }
    //Fixme
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
