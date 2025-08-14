import 'package:equatable/equatable.dart';

class Room extends Equatable {
  const Room({required this.id, required this.participants});
  final String id;
  final List<String> participants;
  @override
  List<Object?> get props => [id, participants];
}
