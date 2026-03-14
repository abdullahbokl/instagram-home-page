import 'package:equatable/equatable.dart';

class MediaItem extends Equatable {
  const MediaItem({
    required this.id,
    required this.imageUrl,
    required this.aspectRatio,
  });

  final String id;
  final String imageUrl;
  final double aspectRatio;

  @override
  List<Object?> get props => [id, imageUrl, aspectRatio];
}
