import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/auth/views/postdetail_page.dart';
import 'package:buzz_hub/services/post_service.dart';
import 'package:buzz_hub/widgets/post_clone_item.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class PostDetailPage extends StatelessWidget {
  final PostResponse post;


  // final String avtPath, postImg, postContent, author, time, myAvtPath, myName;

  PostDetailPage({
    // required this.avtPath,
    // required this.postImg,
    // required this.postContent,
    // required this.author,
    // required this.time,
    // required this.myAvtPath,
    // required this.myName,

    required this.post
  });

  final List<Map<String, String>> comments = [
    {
      "avtPath": "lib/pics/avt.jpg",
      "commentator": "Pirate",
      "cmtContent": "Em dep lam!",
      "isReply:": "false"
    },
    {
      "avtPath": "lib/pics/avt1.jpg",
      "commentator": "Jolie",
      "cmtContent": "Gyatt !!",
      "isReply:": "true"
    },
    // Add more sample comments if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, post.author.toString()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostItem(post: PostResponse(
              postId: "1",
              textContent: "Test Content",
              imageContent: [LoginPage.currentUser!.avatarUrl!],
              author: LoginPage.currentUser!,
              createdAt: DateTime.now()
            )),
            Divider(),
            // Comment input cell
            CommentCell(
              myAvt: LoginPage.currentUser!.avatarUrl!,
              myName: LoginPage.currentUser!.userName!,
            ),

            Divider(),
            // Display comments
            for (var comment in comments)
              CommentWidget(
                avtPath: comment['avtPath']!,
                commentator: comment['commentator']!,
                cmtContent: comment['cmtContent']!,
                isReply: comment['isReply'] == 'true',
            ),            
          ],
        ),
      ),
    );
  }
}


class CommentWidget extends StatelessWidget {
  final String avtPath;
  final String commentator;
  final String cmtContent;
  final bool isReply;

  const CommentWidget({
    Key? key,
    required this.avtPath,
    required this.commentator,
    required this.cmtContent,
    required this.isReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarWidget(
            imagePath: avtPath,
            R: 16,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  commentator,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(cmtContent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CommentCell extends StatelessWidget {
  final String myAvt;
  final String myName;

  const CommentCell({
    Key? key,
    required this.myAvt,
    required this.myName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20, // Adjust the radius as needed
            backgroundImage: NetworkImage(
              'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/${LoginPage.currentUser!.avatarUrl!}'
            ),
          ),
          const SizedBox(width: 8.0),

          // Comment input field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write a comment as ${myName}',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 8.0),

          // Send button
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: () {
              // Implement the send action here
              print('Send button pressed');
            },
          ),
        ],
      ),
    );
  }
}


AppBar buildAppBar(BuildContext context, String author) {
  return AppBar(
    backgroundColor: Colors.white,
    title: const Text(
      'Post',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        height: 1.0,
        color: Colors.grey.withOpacity(0.5),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16.0),
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.person_add),
                  title: Text('Follow $author'),
                ),
                value: 'follow',
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.block),
                  title: Text('Block $author'),
                ),
                value: 'block',
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.volume_off),
                  title: Text('Mute $author'),
                ),
                value: 'mute',
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('Report post'),
                ),
                value: 'report',
              ),
            ];
          },
          onSelected: (value) {
            // Handle the selected option here
            print('Selected option: $value');
          },
        ),
      ),
    ],
  );
}



// need call comment API
class AvatarWidget extends StatelessWidget {
  final String imagePath;
  final double R;

  const AvatarWidget({
    Key? key,
    required this.imagePath,
    required this.R,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0), // Adjust this value as needed
      child: CircleAvatar(
        radius: R,
        // change to network img and put 'link' + avtPath here 
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}

// class PostWidget extends StatefulWidget {
//   final String avtPath;
//   final String postImg;
//   final String postContent;
//   final String author;
//   final String time;
//   final String myAvtPath;
//   final String myName;

//   const PostWidget({
//     Key? key,
//     required this.avtPath,
//     required this.postImg,
//     required this.postContent,
//     required this.author,
//     required this.time,
//     required this.myAvtPath,
//     required this.myName,
//   }) : super(key: key);

//   @override
//   _PostWidgetState createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   bool isLiked = false, isBookmarked = false;
//   int likeCount = 0;
//   int cmtCount = 0;
//   int shareCount = 0;

//   void navigateToPostDetailPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PostDetailPage(
//           avtPath: widget.avtPath,
//           postImg: widget.postImg,
//           postContent: widget.postContent,
//           author: widget.author,
//           time: widget.time,
//           myAvtPath: widget.myAvtPath,
//           myName: widget.myName,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Author
//         Padding(
//           padding: const EdgeInsets.only(top: 16, bottom: 10, left: 16),
//           child: Row(
//             children: [
//               AvatarWidget(
//                 imagePath: widget.avtPath,
//                 R: 18,
//               ),
//               const SizedBox(width: 6), // Add spacing between avatar and content
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.author, // Add the author's name or username here
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     widget.time, // Add the time of the post here
//                     style: const TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // Post Content
//         GestureDetector(
//           onTap: navigateToPostDetailPage,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 0, bottom: 5, left: 16, right: 16),
//             child: Text(
//               widget.postContent,
//               style: const TextStyle(fontSize: 20),
//             ),
//           ),
//         ),

//         // Post Image
//         GestureDetector(
//           onTap: navigateToPostDetailPage,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: Image.asset(
//                 widget.postImg,
//                 fit: BoxFit.cover
//               ),
//             ),
//           ),
//         ),

//         // Post Actions (e.g., Comment, Share)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         isLiked = !isLiked;
//                         if (isLiked) {
//                           likeCount++;
//                         } else {
//                           likeCount--;
//                         }
//                       });
//                     },
//                     icon: Icon(
//                       isLiked ? Icons.favorite : Icons.favorite_border,
//                       color: isLiked ? Colors.pink : null,
//                     ),
//                   ),
//                   Text('$likeCount'), // Display the number of likes
//                   IconButton(
//                     onPressed: () {
//                       // Handle comment action
//                       navigateToPostDetailPage();
//                     },
//                     icon: const Icon(Icons.comment),
//                   ),
//                   Text('$cmtCount'), // Display the number of comments
//                   IconButton(
//                     onPressed: () {
//                       // Handle share action
//                       setState(() {
//                         shareCount++;
//                       });
//                     },
//                     icon: const Icon(Icons.share),
//                   ),
//                   Text('$shareCount'), // Display the number of shares
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {
//                   //Handle bookmark action
//                   setState(() {
//                     isBookmarked = !isBookmarked;        
//                   });
//                 }, 
//                 icon: Icon(
//                   isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
