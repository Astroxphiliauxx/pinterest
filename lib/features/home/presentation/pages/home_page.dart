import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/home_providers.dart';
import '../widgets/pin_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Trigger fetch more when 85% of the way down
  void _onScroll() {
    final threshold = _scrollController.position.maxScrollExtent * 0.85;
    if (_scrollController.offset >= threshold) {
      ref.read(homeFeedProvider.notifier).fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(homeFeedProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: feedState.when(
        loading: () => _buildShimmerGrid(),
        error: (e, _) => _buildErrorState(),
        data: (photos) => RefreshIndicator(
          color: const Color(0xFFE60023),
          onRefresh: () => ref.read(homeFeedProvider.notifier).fetchInitial(),
          child: MasonryGridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return PinCard(photo: photos[index]);
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Pinterest',
        style: TextStyle(
          color: Color(0xFFE60023),
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      itemCount: 12,
      itemBuilder: (_, i) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: i.isEven ? 200.0 : 260.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.black26),
          const SizedBox(height: 16),
          const Text(
            'Something went wrong',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE60023),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () => ref.read(homeFeedProvider.notifier).fetchInitial(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
