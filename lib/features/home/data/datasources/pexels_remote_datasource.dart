import 'package:dio/dio.dart';
import '../../domain/entities/pexels_photo.dart';
import '../models/pexels_photo_model.dart';

/// Calls the Pexels REST API directly using Dio.
class PexelsRemoteDatasource {
  final Dio _dio;
  PexelsRemoteDatasource(this._dio);

  Future<List<PexelsPhoto>> getCuratedPhotos({
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await _dio.get(
      '/curated',
      queryParameters: {'page': page, 'per_page': perPage},
    );
    final list = response.data['photos'] as List<dynamic>;
    return list
        .map((e) => PexelsPhotoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PexelsPhoto>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await _dio.get(
      '/search',
      queryParameters: {'query': query, 'page': page, 'per_page': perPage},
    );
    final list = response.data['photos'] as List<dynamic>;
    return list
        .map((e) => PexelsPhotoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
