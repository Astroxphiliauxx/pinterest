import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/pexels_photo.dart';

class PinCard extends StatelessWidget {
  final PexelsPhoto photo;
  final VoidCallback? onTap;

  const PinCard({super.key, required this.photo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Hero(
          tag: 'pin_${photo.id}',
          child: CachedNetworkImage(
            imageUrl: photo.src.medium,
            fit: BoxFit.cover,
            // Shimmer skeleton while the image loads
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.white, height: 200),
            ),
            // Fallback coloured box on error
            errorWidget: (context, url, error) => Container(
              height: 200,
              color: _parseColor(photo.avgColor),
              child: const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white54,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.grey.shade300;
    }
  }
}
