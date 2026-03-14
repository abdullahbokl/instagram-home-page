import 'package:equatable/equatable.dart';

class FeedUser extends Equatable {
  const FeedUser({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.isVerified = false,
  });

  final String id;
  final String username;
  final String avatarUrl;
  final bool isVerified;

  @override
  List<Object?> get props => [id, username, avatarUrl, isVerified];
}
