import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class EvidenceGallery extends StatelessWidget {
  const EvidenceGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Violation Evidence Gallery',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All Photos',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildGalleryItem(
              'Sanitation Issue - 12 Oct',
              'https://picsum.photos/seed/san1/300/200',
            ),
            const SizedBox(width: 16),
            _buildGalleryItem(
              'Expired Stock - 12 Oct',
              'https://picsum.photos/seed/exp1/300/200',
            ),
            const SizedBox(width: 16),
            _buildGalleryItem(
              'Structural Notice - 05 Nov',
              'https://picsum.photos/seed/str1/300/200',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGalleryItem(String label, String imageUrl) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
