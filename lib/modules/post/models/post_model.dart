class Post {
  String authorName;
  String authorImageUrl;
  String timeAgo;
  String imageUrl;
  String content;
  String update;

  Post({
    required this.authorName,
    required this.authorImageUrl,
    required this.timeAgo,
    required this.imageUrl,
    required this.content,
    required this.update,
  });
}

final List<Post> posts = [
  Post(
    authorName: 'Sam Martin',
    authorImageUrl: 'assets/images/user0.png',
    timeAgo: '5 min',
    imageUrl: 'assets/images/post0.jpg',
    content: 'It is a long established fact that a reader will bee distracted by the readable content ... 100000000000000000000000000000000000000000000000000000000',
    update: '5h ago'
  ),
  Post(
    authorName: 'Sam Martin',
    authorImageUrl: 'assets/images/user0.png',
    timeAgo: '10 min',
    imageUrl: 'assets/images/post1.jpg',
    content: 'It is a long established fact that a reader will bee distracted by the readable content ...',
    update: '6h ago'
  ),
];

final List<String> stories = [
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
  'assets/images/user4.png',
  'assets/images/user0.png',
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
];