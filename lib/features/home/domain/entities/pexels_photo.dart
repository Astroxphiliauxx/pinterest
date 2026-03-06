/// Core domain entity representing a single Pexels photo (pin).
class PexelsPhoto {
  final int id;
  final int width;
  final int height;
  final String photographer;
  final String photographerUrl;
  final String avgColor;
  final PhotoSrc src;
  final String alt;

  const PexelsPhoto({
    required this.id,
    required this.width,
    required this.height,
    required this.photographer,
    required this.photographerUrl,
    required this.avgColor,
    required this.src,
    required this.alt,
  });

  /// Useful for sizing cards in the masonry grid.
  double get aspectRatio => width / height;
}

/// All image size variants returned by the Pexels API.
class PhotoSrc {
  final String original;
  final String large2x;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  const PhotoSrc({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });
}
