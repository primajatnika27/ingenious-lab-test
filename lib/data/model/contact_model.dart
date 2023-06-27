import 'package:ingenious_test/domain/entity/list_contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel.fromJson(Map<String, dynamic> json)
      : super(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  static List<ContactEntity> parseEntries(List<dynamic> entries) {
    List<ContactEntity> data = [];
    for (var value in entries) {
      data.add(ContactModel.fromJson(value));
    }
    return data;
  }
}