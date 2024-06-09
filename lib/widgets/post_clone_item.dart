import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/views/postdetail_page.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/profile/views/profile.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/post_service.dart';
import 'package:buzz_hub/modules/auth/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


HomeController controller = HomeController();

class PostItem extends StatefulWidget {
  const PostItem({Key? key, required this.post}) : super(key: key);
  final PostResponse post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false, 
  isBookmarked = false;
  int likeCount = 0;
  int commentCount = 0;
  CurrentUserResponse? author = null;
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    fetchLikeCount();
    // fetchgetAuthor();
    // fetchCommentCount();
  }
  Future<void> fetchLikeCount() async {
    int fetchedLikeCount = await controller.getCountLike(widget.post.postId!);
    setState(() {
      likeCount = fetchedLikeCount;
    });
  }
  // Future<void> fetchgetAuthor() async {
  //   CurrentUserResponse? auth = await controller.getUser(widget.post.author!.userName!);
  //   setState(() {
  //     author = auth;
  //   });
  // }
  Future<void> fetchLike() async {
    bool isLikedtemp = await controller.likePost(widget.post.postId!);

    if (isLikedtemp) {
      bool temp = await controller.dislikePost(widget.post.postId!);
      setState(() {
        isLiked = false;
      });
    } else {
      setState(() {
        isLiked = true;
      });
    }
  }
  // Future<void> fetchCommentCount() async {
  //   int fetchedCommentCount = await PostService().getCountComment(widget.post.postId);
  //   setState(() {
  //     commentCount = fetchedCommentCount;
  //   });
  // }

  void _navigateToPostDetailPage() async {
    // PostResponse? post = await controller.getPostById(widget.post.postId!);
    // if (post != null) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PostDetailPage(post: post),
    //     ),
    //   );
    // } else {
    //   // Handle the error if the post is not fetched
    //   print('Failed to fetch post details');
    // }
  }

void _showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Post"),
        content: Text("Are you sure you want to delete this post?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              // Perform delete action here
              setState(() {
                isHidden = true;
              });
            },
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("No"),
          ),
        ],
      );
    },
  );
  }

  void _onPopupMenuSelected(String value) {
    switch (value) {
      case 'edit':
        // edit action
        break;
      case 'delete':
        _showDeleteConfirmationDialog(context);
        break;
      case 'hide':
        setState(() {
          isHidden = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Post hidden'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  isHidden = false;
                });
              },
            ),
          ),
        );
        break;
    }
  }



  @override
  Widget build(BuildContext context) {

    if (isHidden) {
      return SizedBox.shrink(); // Return an empty widget if the post is hidden
    }

    bool isAuthor = widget.post.author!.fullName! == LoginPage.currentUser?.fullName;


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.Grey),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.only(left: 10, right: 0.0),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 2),
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: 
                // NetworkImage(
                //   author!.avatarUrl
                //   ?? 
                //   'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg',
                // ),
                
                // widget.post.author!.avatarUrl is always null ???
                NetworkImage(
                  widget.post.author!.avatarUrl 
                  ?? 
                  'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg',
                ),

              ),
            ),
            title: Text(
              widget.post.author!.fullName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.post.createdAt!.toString(),
              style: TextStyle(fontSize: 12),
            ),
            trailing: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _onPopupMenuSelected,
              itemBuilder: (BuildContext context) {
                return isAuthor
                    ? [
                        PopupMenuItem<String>(
                          value: 'hide',
                          child: const Row(
                            children: const [
                              Icon(Icons.visibility_off, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Hide'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: const Row(
                            children: const [
                              Icon(Icons.edit, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: const Row(
                            children: const [
                              Icon(Icons.delete, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ]
                    : [
                        PopupMenuItem<String>(
                          value: 'hide',
                          child: Row(
                            children: const [
                              Icon(Icons.visibility_off, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Hide'),
                            ],
                          ),
                        ),
                      ];
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Ensures children are aligned to the left
            children: [
              Container(
                alignment: Alignment.centerLeft, // Ensures text is aligned to the left
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.post.textContent!,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (widget.post.imageContent != null && widget.post.imageContent!.isNotEmpty)
                Container(
                  height: Get.width - 40,
                  margin: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.post.imageContent!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width - 40,
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          // boxShadow: const [
                          //   BoxShadow(
                          //     color: Colors.black45,
                          //     offset: Offset(0, 5),
                          //     blurRadius: 8.0,
                          //   ),
                          // ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/posts-image/' +
                                  widget.post.imageContent![index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.pink : null,
                            ),
                            iconSize: 20.0,
                            onPressed: () {
                              setState(() {
                                
                                isLiked = !isLiked;
                                if (isLiked) {
                                  HomeController().likePost(widget.post.postId!);
                                  likeCount ++;
                                } else {
                                  HomeController().dislikePost(widget.post.postId!);
                                  likeCount --;
                                }
                              });
                            },
                          ),
                          Text(
                            '$likeCount',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      // Row(
                      //   children: <Widget>[
                      //     IconButton(
                      //       icon: const Icon(Icons.comment_rounded),
                      //       iconSize: 20.0,
                      //       color: Colors.black,
                      //       onPressed: _navigateToPostDetailPage,
                      //     ),
                      //     Text(
                      //       '$commentCount',
                      //       style: TextStyle(
                      //         fontSize: 14.0,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(width: 5),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.share),
                            iconSize: 20.0,
                            color: Colors.black,
                            onPressed: () => print('Share'),
                          ),
                          const Text(
                            '',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
                    ),
                    iconSize: 20.0,
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
