import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../core/app_theme.dart';
import '../core/mock_data.dart';
import '../screens/photo_screen.dart';

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({super.key, required this.posts, required this.name});

  final List<Post> posts;
  final String name;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return CustomScrollView(
      key: PageStorageKey(name),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, bottom + 110),
          sliver: SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childCount: posts.length,
            itemBuilder: (_, i) =>
                PhotoTile(post: posts[i], heroTag: '$name-$i'),
          ),
        ),
      ],
    );
  }
}

class PhotoTile extends StatefulWidget {
  const PhotoTile({super.key, required this.post, required this.heroTag});

  final Post post;
  final String heroTag;

  @override
  State<PhotoTile> createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  void _open() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, _, _) =>
            PhotoScreen(post: widget.post, heroTag: widget.heroTag),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final radius = BorderRadius.circular(24);

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: _open,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: AspectRatio(
          aspectRatio: post.ratio,
          child: ClipRRect(
            borderRadius: radius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: widget.heroTag,
                  child: ClipRRect(
                    borderRadius: radius,
                    child: ColoredBox(
                      color: AppColors.blush,
                      child: Image.network(
                        post.image(600),
                        fit: BoxFit.cover,
                        frameBuilder: (_, child, frame, sync) =>
                            AnimatedOpacity(
                              opacity: sync || frame != null ? 1 : 0,
                              duration: const Duration(milliseconds: 400),
                              child: child,
                            ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 80,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black45],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: _Badge(
                    icon: Icons.favorite_rounded,
                    label: post.likes,
                  ),
                ),
                if (post.isVideo) ...[
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: _Badge(label: post.duration!),
                  ),
                  const Center(child: _PlayButton()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: Colors.white),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: AppColors.accent,
        size: 28,
      ),
    );
  }
}
