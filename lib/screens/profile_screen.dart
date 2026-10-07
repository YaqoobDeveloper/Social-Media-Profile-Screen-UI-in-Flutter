import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core/mock_data.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/photo_grid.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _navIndex = 4;
  bool _navVisible = true;

  bool _onScroll(UserScrollNotification notification) {
    final visible = switch (notification.direction) {
      ScrollDirection.reverse => false,
      ScrollDirection.forward => true,
      ScrollDirection.idle => _navVisible,
    };
    if (visible != _navVisible) setState(() => _navVisible = visible);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNav(
          index: _navIndex,
          visible: _navVisible,
          onChanged: (i) => setState(() => _navIndex = i),
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: _onScroll,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileHeaderDelegate(
                    topPadding: MediaQuery.paddingOf(context).top,
                  ),
                ),
              ),
            ],
            body: const TabBarView(
              children: [
                PhotoGrid(posts: kPhotos, name: 'photos'),
                PhotoGrid(posts: kVideos, name: 'videos'),
                PhotoGrid(posts: kSaved, name: 'saved'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
