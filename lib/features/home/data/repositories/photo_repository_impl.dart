import '../../domain/entities/pexels_photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../datasources/pexels_remote_datasource.dart';

/// Concrete implementation of [PhotoRepository].
/// Bridges the domain interface with the remote datasource.
class PhotoRepositoryImpl implements PhotoRepository {
  final PexelsRemoteDatasource _datasource;
  const PhotoRepositoryImpl(this._datasource);

  @override
  Future<List<PexelsPhoto>> getCuratedPhotos({
    int page = 1,
    int perPage = 20,
  }) => _datasource.getCuratedPhotos(page: page, perPage: perPage);

  @override
  Future<List<PexelsPhoto>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = 20,
  }) => _datasource.searchPhotos(query: query, page: page, perPage: perPage);
}
