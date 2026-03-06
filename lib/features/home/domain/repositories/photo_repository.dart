import '../entities/pexels_photo.dart';

/// Abstract contract — domain never knows about API/Dio details.
abstract class PhotoRepository {
  Future<List<PexelsPhoto>> getCuratedPhotos({int page = 1, int perPage = 20});

  Future<List<PexelsPhoto>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = 20,
  });
}
