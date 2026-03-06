import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/pexels_photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../../domain/usecases/get_curated_photos.dart';

// ---------------------------------------------------------------------------
// Dependency graph (bottom-up)
// ---------------------------------------------------------------------------

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final homeRemoteDatasourceProvider = Provider<HomeRemoteDatasource>((ref) {
  return HomeRemoteDatasource(ref.watch(dioClientProvider).dio);
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  return HomeRepositoryImpl(ref.watch(homeRemoteDatasourceProvider));
});

final getCuratedUseCaseProvider = Provider<GetCuratedPhotosUseCase>((ref) {
  return GetCuratedPhotosUseCase(ref.watch(photoRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Home feed state — pagination-aware
// ---------------------------------------------------------------------------

class HomeFeedNotifier extends StateNotifier<AsyncValue<List<PexelsPhoto>>> {
  final GetCuratedPhotosUseCase _useCase;
  int _page = 1;
  bool _fetching = false;

  HomeFeedNotifier(this._useCase) : super(const AsyncValue.loading()) {
    fetchInitial();
  }

  Future<void> fetchInitial() async {
    _page = 1;
    state = const AsyncValue.loading();
    try {
      final photos = await _useCase(page: _page);
      state = AsyncValue.data(photos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchMore() async {
    if (_fetching || state is AsyncLoading) return;
    final current = state.valueOrNull ?? [];
    _fetching = true;
    try {
      _page++;
      final more = await _useCase(page: _page);
      state = AsyncValue.data([...current, ...more]);
    } catch (_) {
      _page--; // rollback page on error
    } finally {
      _fetching = false;
    }
  }
}

final homeFeedProvider =
    StateNotifierProvider<HomeFeedNotifier, AsyncValue<List<PexelsPhoto>>>(
      (ref) => HomeFeedNotifier(ref.watch(getCuratedUseCaseProvider)),
    );
