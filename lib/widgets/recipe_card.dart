import 'package:flutter/material.dart';
import '../utils/constants.dart';

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String author;
  final int likes;
  final VoidCallback onViewDetails;

  const RecipeCard({
    Key? key,
    required this.imagePath,
    required this.author,
    required this.likes,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: _buildImage(),
              ),
              ElevatedButton(
                onPressed: onViewDetails,
                child: Text('Ver detalles'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: WhiteColor,
                  backgroundColor: GreenColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Por ${author.isNotEmpty ? author : 'Desconocido'}',
                  style: robotoSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(width: 4),
                    Text(
                      '${likes >= 0 ? likes : 0}',
                      style: robotoSubtitleStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath.isNotEmpty && (imagePath.startsWith('http') || imagePath.startsWith('https'))) {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return _buildDefaultImage();
        },
      );
    } else {
      return _buildDefaultImage();
    }
  }

  Widget _buildDefaultImage() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.grey[300],
      child: Icon(Icons.restaurant, size: 50, color: Colors.white),
    );
  }
}