import 'package:flutter/material.dart';

class InteractionIcons extends StatefulWidget {
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isTagged;
  final VoidCallback? onLike;
  final VoidCallback? onTag;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const InteractionIcons({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isTagged = false,
    this.onLike,
    this.onTag,
    this.onComment,
    this.onShare,
  });

  @override
  State<InteractionIcons> createState() => _InteractionIconsState();
}

class _InteractionIconsState extends State<InteractionIcons>
    with TickerProviderStateMixin {
  late AnimationController _heartController;
  late AnimationController _tagController;
  late Animation<double> _heartScale;
  late Animation<double> _tagScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _tagController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _heartScale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );
    _tagScale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _tagController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildHeartButton(),
        const SizedBox(height: 16),
        _buildTagButton(),
        const SizedBox(height: 16),
        _buildInteractionButton(
          icon: 'assets/icons_interaction/comment.png',
          count: widget.comments,
          onTap: widget.onComment,
        ),
        const SizedBox(height: 16),
        _buildInteractionButton(
          icon: 'assets/icons_interaction/share.png',
          count: widget.shares,
          onTap: widget.onShare,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeartButton() {
    return GestureDetector(
      onTap: () {
        _heartController.forward().then((_) {
          _heartController.reverse();
        });
        widget.onLike?.call();
      },
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _heartScale,
            builder: (context, child) {
              return Transform.scale(
                scale: _heartScale.value,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/heart white.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            _formatCount(widget.likes),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagButton() {
    return GestureDetector(
      onTap: () {
        _tagController.forward().then((_) {
          _tagController.reverse();
        });
        widget.onTag?.call();
      },
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _tagScale,
            builder: (context, child) {
              return Transform.scale(
                scale: _tagScale.value,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons_interaction/etiqueta_interaction.png',
                      width: 20,
                      height: 20,
                      color: widget.isTagged ? const Color(0xFF6E44FF) : Colors.grey[600],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            'Etiquetar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required String icon,
    required int count,
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: 20,
                height: 20,
                color: isActive ? Colors.red : Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatCount(count),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}

class ReviewSection extends StatelessWidget {
  final String productName;
  final String brandName;
  final double rating;
  final int reviewCount;
  final VoidCallback? onAddReview;

  const ReviewSection({
    super.key,
    required this.productName,
    required this.brandName,
    required this.rating,
    required this.reviewCount,
    this.onAddReview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      brandName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onAddReview,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6E44FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons_interaction/star.png',
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Reseñar',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating.floor() ? Icons.star : Icons.star_border,
                    color: const Color(0xFFFFD700),
                    size: 16,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Text(
                '${rating.toStringAsFixed(1)} (${reviewCount} reseñas)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
