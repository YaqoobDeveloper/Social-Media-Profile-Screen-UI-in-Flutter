class Post {
  const Post(this.id, this.ratio, this.likes, {this.duration});

  final String id;
  final double ratio;
  final String likes;
  final String? duration;

  String image(int width) =>
      'https://images.unsplash.com/photo-$id?w=$width&fit=crop&q=80';

  bool get isVideo => duration != null;
}

const kAvatar = Post('1438761681033-6461ffad8d80', 1, '');

const kPhotos = [
  Post('1529626455594-4ff0802cfb7e', 0.72, '12.4k'),
  Post('1524504388940-b1c1722653e1', 1.0, '8.1k'),
  Post('1534528741775-53994a69daeb', 0.85, '21k'),
  Post('1517841905240-472988babdf9', 0.66, '5.6k'),
  Post('1488426862026-3ee34a7d66df', 0.9, '9.3k'),
  Post('1531746020798-e6953c6e8e04', 0.75, '14k'),
  Post('1544005313-94ddf0286df2', 1.0, '3.2k'),
  Post('1502823403499-6ccfcf4fb453', 0.7, '7.7k'),
  Post('1509967419530-da38b4704bc6', 0.8, '11k'),
  Post('1487412720507-e7ab37603c6f', 0.95, '4.9k'),
  Post('1539571696357-5a69c17a67c6', 0.72, '6.4k'),
  Post('1508214751196-bcfd4ca60f91', 0.88, '18k'),
];

const kVideos = [
  Post('1515886657613-9f3515b0c78f', 0.62, '42k', duration: '0:32'),
  Post('1496747611176-843222e1e57c', 0.62, '18k', duration: '1:05'),
  Post('1469334031218-e382a71b716b', 0.62, '27k', duration: '0:48'),
  Post('1485968579580-b6d095142e6e', 0.62, '9.8k', duration: '0:21'),
  Post('1529139574466-a303027c1d8b', 0.62, '33k', duration: '2:10'),
  Post('1492707892479-7bc8d5a4ee93', 0.62, '15k', duration: '0:57'),
];

const kSaved = [
  Post('1483985988355-763728e1935b', 0.8, '2.1k'),
  Post('1503342217505-b0a15ec3261c', 0.68, '6.6k'),
  Post('1485462537746-965f33f7f6a7', 1.0, '1.4k'),
  Post('1519699047748-de8e457a634e', 0.75, '8.8k'),
  Post('1531123897727-8f129e1688ce', 0.9, '3.7k'),
  Post('1520813792240-56fc4a3765a7', 0.7, '5.2k'),
];
