import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_screen.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/widgets/post_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class Controller extends GetxController {
  var isFavorited = false.obs;
  void toggleFavorite() {
    isFavorited.toggle();
  }

  void savePost(BuildContext context) {
    // Implement your logic to save a post here
    // For example, you might want to add the post to a database

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You have saved this post!')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Controller c = Get.put(Controller());
  PostResponse postResponse = PostResponse(
      postId: 1,
      textContent:
          "It is a long established fact that a reader will bee distracted by the readable content ... 100000000000000000000000000000000000000000000000000000000",
      imageContent: [LoginPage.currentUser!.avatarUrl!],
      author: LoginPage.currentUser,
      createdAt: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: Text("Trang cá nhân"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  // write function here
                  Obx(() => IconButton(
                      icon: Icon(
                        c.isFavorited.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: c.isFavorited.value ? Colors.pink : null,
                      ),
                      onPressed: c.toggleFavorite));
                },
                icon: Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  Get.to(BookMarks());
                },
                icon: Icon(Icons.bookmark)),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: Get.height - 80,
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // write function here
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Image.asset(
                                                  'assets/images/user.jpg'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  // write function here
                                                },
                                                child: Text('Change Image'))
                                          ]),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            )),
                        SizedBox(width: 10), // Add some space
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '250K',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Follower'), // Replace with actual number
                          ],
                        ),
                        SizedBox(width: 20), // Add some space
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '450K',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Following'), // Replace with actual number
                          ],
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // write function here
                          },
                          child: Text('Change Profile',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                              side: BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10), // Add some space
                    Row(
                      children: <Widget>[
                        Text(
                          'Account Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.blue),
                      ],
                    ),
                    Text('@search_id'), // Replace with actual search id
                    SizedBox(height: 15),
                    Text(
                      'Bio text goes here, habit, interest, passion like this,...',
                      style: TextStyle(color: Colors.black),
                    ), // Replace with actual bio
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text('Address'), // Replace with actual address
                        Spacer(),
                        Icon(Icons.cake),
                        Text(
                            'Date of Birth'), // Replace with actual date of birth
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.link),
                        Text('www.example.com'), // Replace with actual link
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PostItem(post: postResponse);
                      },
                      itemCount: 3,
                    )
                  ]),
            )));
  }
}

class CommentScreen extends StatelessWidget {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              // This is where the comments would go.
              // You might want to replace this with a StreamBuilder if you're loading comments from a database.
              children: <Widget>[
                ListTile(
                  title: Text('User1'),
                  subtitle: Text('This is a comment.'),
                ),
                ListTile(
                  title: Text('User2'),
                  subtitle: Text('This is another comment.'),
                ),
                // Add more ListTiles for more comments
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Write a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Implement your comment posting logic here
                    // For example, you might want to add the comment to your database
                    print('Comment: ${_commentController.text}');
                    _commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class Post extends StatelessWidget {
//   final Controller c;

//   Post({
//     Key? key,
//     required this.c,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       DecoratedBox(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.grey[200] ?? Colors.grey,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/user.jpg'),
//                       radius: 20,
//                     ),
//                     SizedBox(width: 10),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: 'You ',
//                             style: TextStyle(color: Colors.black, fontSize: 16),
//                           ),
//                           WidgetSpan(
//                             child: Icon(Icons.check_circle,
//                                 color: Colors.blue, size: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Spacer(),
//                     Text(
//                       'Posted 2h ago',
//                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Post content goes here...',
//                   style: TextStyle(color: Colors.black, fontSize: 16),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Obx(
//                           () => IconButton(
//                             icon: Icon(
//                               c.isFavorited.value
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: c.isFavorited.value ? Colors.pink : null,
//                             ),
//                             onPressed: c.toggleFavorite,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.comment),
//                           onPressed: () {
//                             // write function here
//                             Get.to(CommentScreen());
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.share),
//                           onPressed: () {
//                             // write function here
//                             Share.share('Check out this post',
//                                 subject: 'Look what I found!');
//                           },
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.bookmark_border),
//                       onPressed: () {
//                         c.savePost(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )),
//     ]);
//   }
// }
