import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/widgets/post_clone_item.dart';
import 'package:buzz_hub/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buzz_hub/modules/auth/controller/home_controller.dart';

String? myAvtPath = LoginPage.currentUser?.avatarUrl;
String? myName = LoginPage.currentUser?.fullName;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostResponse>? postList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    List<PostResponse>? posts = await PostService().getAllPost();
    setState(() {
      postList = posts;
      print(postList);
      isLoading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    await fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, // Remove the 'Home' text
        backgroundColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0), // Adjust the padding as needed
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/${myAvtPath ?? ''}'
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0), // Adjust the padding as needed
            child: IconButton(
              onPressed: () {
                // Handle the onPressed event for the add icon
              },
              icon: const Icon(Icons.add_alert), // Use any desired icon here
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : postList == null
              ? Center(child: Text('No posts available'))
              : RefreshIndicator(
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: postList!.map((p) => PostItem(post: p)).toList(),
                    ),
                  ),
                ),
    );
  }
}

















// class AvatarWidget extends StatelessWidget {
//   final String imagePath;
//   final double R;

//   const AvatarWidget({
//     Key? key,
//     required this.imagePath,
//     required this.R,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 16.0), // Adjust this value as needed
//       child: CircleAvatar(
//         radius: R,
//         backgroundImage:
//           NetworkImage(
//             'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/${LoginPage.currentUser!.avatarUrl!}'
//           )
//       ),
//     );
//   }
// }

// class PostWidget extends StatefulWidget {
//   final String avtPath;
//   final String postImg;
//   final String postContent;
//   final String author;
//   final String time;

//   const  PostWidget({
//     Key? key,
//     required this.avtPath,
//     required this.postImg,
//     required this.postContent,
//     required this.author,
//     required this.time,
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
//           // avtPath: widget.avtPath, 
//           // postImg: widget.postImg, 
//           // postContent: widget.postContent, 
//           // author: widget.author, 
//           // time: widget.time,
//           // myAvtPath: myAvtPath,
//           // myName: myName,
//         ),
//       ),
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Author
//           Padding(
//             padding: const EdgeInsets.only(top: 16, bottom: 10, left: 16),
//             child: Row(
//               children: [
//                 AvatarWidget(
//                   imagePath: widget.avtPath,
//                   R: 18,
//                 ),
//                 const SizedBox(width: 6), // Add spacing between avatar and content
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.author, // Add the author's name or username here
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       widget.time, // Add the time of the post here
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Post Content
//           GestureDetector(
//             onTap: navigateToPostDetailPage,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 0, bottom: 5, left: 6),
//               child: Text(
//                 widget.postContent,
//                 style: const TextStyle(fontSize: 20),
//               ),
//             ),
//           ),

//           // Post Image
//           GestureDetector(
//             onTap: navigateToPostDetailPage,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
//               child: SizedBox(
//                 child: Image.asset(
//                   widget.postImg, // Update the path according to your project structure
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),

//           // Post Actions (e.g., Comment, Share)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0), // Adjust the padding as needed
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 4.0), // Adjust the padding as needed
//                       child: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isLiked = !isLiked;
//                             if (isLiked) {
//                               likeCount++;
//                             } else {
//                               likeCount--;
//                             }
//                           });
//                         },
//                         icon: Icon(
//                           isLiked ? Icons.favorite : Icons.favorite_border,
//                           color: isLiked ? Colors.pink : null,
//                         ),
//                       ),
//                     ),
//                     Text('$likeCount'), // Display the number of likes
//                     Padding(
//                       padding: const EdgeInsets.only(right: 4.0), // Adjust the padding as needed
//                       child: IconButton(
//                         onPressed: () {
//                           // Handle comment action
//                           navigateToPostDetailPage();
//                         },
//                         icon: const Icon(Icons.comment),
//                       ),
//                     ),
//                     Text('$cmtCount'), // Display the number of comments
//                     Padding(
//                       padding: const EdgeInsets.only(right: 4.0), // Adjust the padding as needed
//                       child: IconButton(
//                         onPressed: () {
//                           // Handle share action
//                           setState(() {
//                             shareCount++;
//                           });
//                         },
//                         icon: const Icon(Icons.share),
//                       ),
//                     ),
//                     Text('$shareCount'), // Display the number of shares
//                   ],
//                 ),
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
//         ],
//       ),
//     );
//   }
// }