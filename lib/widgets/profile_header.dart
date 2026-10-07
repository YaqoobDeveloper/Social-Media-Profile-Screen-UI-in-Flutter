import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/mock_data.dart';
import 'profile_tabs.dart';

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  ProfileHeaderDelegate({required this.topPadding});

  final double topPadding;

  static const _toolbar = 60.0;
  static const _info = 224.0;
  static const _tabs = 52.0;
  static const _gap = 12.0;

  @override
  double get maxExtent => topPadding + _toolbar + _info + _tabs + _gap;

  @override
  double get minExtent => topPadding + _toolbar + _tabs + _gap;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final collapsed = Curves.easeOut.transform(
      ((t - 0.6) / 0.4).clamp(0.0, 1.0),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28 * t)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06 * t),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: topPadding + _toolbar - shrinkOffset,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: (1 - t * 1.6).clamp(0.0, 1.0),
              child: Transform.scale(
                scale: 1 - t * 0.12,
                alignment: Alignment.bottomCenter,
                child: const _ProfileInfo(),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topPadding + _toolbar,
            child: ColoredBox(
              color: AppColors.background,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, topPadding, 20, 0),
                child: _Toolbar(progress: collapsed),
              ),
            ),
          ),
          const Positioned(
            left: 20,
            right: 20,
            bottom: _gap,
            height: _tabs,
            child: ProfileTabs(tabs: ['Photos', 'Videos', 'Saved']),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(ProfileHeaderDelegate oldDelegate) =>
      oldDelegate.topPadding != topPadding;
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _MenuIcon(),
        Expanded(
          child: Opacity(
            opacity: progress,
            child: Transform.translate(
              offset: Offset(0, 12 * (1 - progress)),
              child: const _MiniProfile(),
            ),
          ),
        ),
        const _CircleButton(icon: Icons.more_vert_rounded),
      ],
    );
  }
}

class _MiniProfile extends StatelessWidget {
  const _MiniProfile();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Avatar(size: 36, radius: 12),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wade Warren',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            Text(
              '518 posts · 22k friends',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey,
                height: 1.3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Avatar(size: 100, radius: 30),
        const SizedBox(height: 14),
        const Text(
          'Wade Warren',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '@wadewarren',
          style: TextStyle(fontSize: 16, color: AppColors.grey),
        ),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Stat(value: '518', label: 'Posts'),
            SizedBox(width: 44),
            _Stat(value: '22k', label: 'Friends'),
          ],
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.size, required this.radius});

  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final border = size * 0.04;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(border),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - border),
        child: Image.network(kAvatar.image(300), fit: BoxFit.cover),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$value  ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: label,
            style: const TextStyle(color: AppColors.grey),
          ),
        ],
      ),
      style: const TextStyle(fontSize: 17, color: AppColors.dark),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  const _MenuIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final w in [22.0, 14.0, 22.0])
            Container(
              width: w,
              height: 2.4,
              margin: const EdgeInsets.symmetric(vertical: 2.5),
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Icon(icon, size: 22, color: AppColors.dark),
    );
  }
}
