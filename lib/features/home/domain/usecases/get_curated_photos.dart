import '../entities/pexels_photo.dart';
import '../repositories/photo_repository.dart';

/// Fetches the curated home feed.
class GetCuratedPhotosUseCase {
  final PhotoRepository repository;
  const GetCuratedPhotosUseCase(this.repository);

  Future<List<PexelsPhoto>> call({int page = 1, int perPage = 20}) {
    return repository.getCuratedPhotos(page: page, perPage: perPage);
  }
}
