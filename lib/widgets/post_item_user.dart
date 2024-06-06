import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/services/dto/responses/post_user_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post});
  final PostUserResponse post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false, isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(color: AppColors.Grey),
          borderRadius: BorderRadius.circular(25.0)),
      child: Column(children: <Widget>[
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
                    blurRadius: 6.0,
                  )
                ]),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.jpg'),
            ),
          ),
          title: Text(
            widget.post.authorName!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            widget.post.createdAt!.toString(),
            style: TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
            onPressed: () => print("More"),
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                softWrap: true,
                widget.post.textContent!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10.0),
                width: Get.width,
                height: Get.width - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8.0)
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/' +
                                widget.post.imageContent!.first)))),
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
                            });
                          },
                        ),
                        const Text(
                          '25',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 5),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.comment_rounded),
                          iconSize: 20.0,
                          color: Colors.black,
                          onPressed: () => print('Comment'),
                        ),
                        const Text(
                          '25',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
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
                          '25',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
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
        )
      ]),
    );
  }
}
