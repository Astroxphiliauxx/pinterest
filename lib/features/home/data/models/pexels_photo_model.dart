import '../../domain/entities/pexels_photo.dart';

/// Data Transfer Object — maps raw Pexels API JSON to the domain entity.
class PexelsPhotoModel extends PexelsPhoto {
  const PexelsPhotoModel({
    required super.id,
    required super.width,
    required super.height,
    required super.photographer,
    required super.photographerUrl,
    required super.avgColor,
    required super.src,
    required super.alt,
  });

  factory PexelsPhotoModel.fromJson(Map<String, dynamic> json) {
    final srcJson = json['src'] as Map<String, dynamic>;
    return PexelsPhotoModel(
      id: json['id'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      photographer: json['photographer'] as String,
      photographerUrl: json['photographer_url'] as String,
      avgColor: json['avg_color'] as String? ?? '#CCCCCC',
      alt: json['alt'] as String? ?? '',
      src: PhotoSrc(
        original: srcJson['original'] as String,
        large2x: srcJson['large2x'] as String,
        large: srcJson['large'] as String,
        medium: srcJson['medium'] as String,
        small: srcJson['small'] as String,
        portrait: srcJson['portrait'] as String,
        landscape: srcJson['landscape'] as String,
        tiny: srcJson['tiny'] as String,
      ),
    );
  }
}
