import 'package:buzz_hub/modules/auth/views/login_page.dart';

// postId: "1",
//         textContent:
//             "It is a long established fact that a reader will bee distracted by the readable content ... 100000000000000000000000000000000000000000000000000000000",
//         imageContent: [LoginPage.currentUser!.avatarUrl!],
//         author: LoginPage.currentUser,
//         createdAt: DateTime.now()

class Post {
  int postId;
  String imageAuthor;
  String textContent;
  String imageContent;
  String author;
  String createdAt;

  Post({
    required this.postId,
    required this.imageAuthor,
    required this.textContent,
    required this.imageContent,
    required this.author,
    required this.createdAt,
  });
}

final List<Post> posts = [
  Post(
    postId: 1,
    imageAuthor: 'assets/images/user0.jpg',
    author: LoginPage.currentUser!.fullName.toString(),
    imageContent: 'assets/images/dog.png',
    textContent: 'Chú chó trong phim này thật dễ thương và đáng yêu! Những biểu cảm ngộ nghĩnh và hành động đáng yêu của nó khiến người xem không thể không yêu mến.',
    createdAt: '5h ago'
  ),

  Post(
    postId: 2,
    imageAuthor: 'assets/images/user0.png',
    author: "Leo",
    imageContent: 'assets/images/tech.jpg',
    textContent: 'It is a long established fact that a reader will bee distracted by the readable content ...',
    createdAt: '${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}'
  ),
];