import 'package:dio/dio.dart';
import '../../domain/entities/pexels_photo.dart';
import '../models/pexels_photo_model.dart';

/// Remote datasource for the Home feature.
/// Talks directly to the Pexels REST API via [Dio].
class HomeRemoteDatasource {
  final Dio _dio;
  HomeRemoteDatasource(this._dio);

  /// GET /curated — returns the latest curated photos.
  Future<List<PexelsPhoto>> getCuratedPhotos({
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await _dio.get(
      '/curated',
      queryParameters: {'page': page, 'per_page': perPage},
    );
    final photos = response.data['photos'] as List<dynamic>;
    return photos
        .map((json) => PexelsPhotoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// GET /search — returns photos matching a query.
  Future<List<PexelsPhoto>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await _dio.get(
      '/search',
      queryParameters: {'query': query, 'page': page, 'per_page': perPage},
    );
    final photos = response.data['photos'] as List<dynamic>;
    return photos
        .map((json) => PexelsPhotoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
