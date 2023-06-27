import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const ContactEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    email,
  ];
}