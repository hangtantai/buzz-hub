import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/views/home_page.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/auth/views/postdetail_page.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:buzz_hub/modules/post/models/post_model.dart';
import 'package:get/get.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBookmarks createState() => _CreateBookmarks();
}

class _CreateBookmarks extends State<BookMarks> {
  Widget _builtPost(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        // constraints: const BoxConstraints.expand(),
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
                child: ClipOval(
                  child: Image(
                    height: 90.0,
                    width: 90.0,
                    image: AssetImage(posts[index].authorImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(
              posts[0].authorName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].update),
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
                  posts[index].content,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8.0)
                    ],
                    image: DecorationImage(
                      image: AssetImage(posts[index].imageUrl),
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            iconSize: 20.0,
                            color: Colors.black,
                            onPressed: () => print('Love'),
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
                    icon: const Icon(Icons.bookmark),
                    iconSize: 20.0,
                    color: Colors.black,
                    onPressed: () => print('Note'),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PostResponse postResponse = PostResponse(
        postId: "1",
        textContent:
            "It is a long established fact that a reader will bee distracted by the readable content ... 100000000000000000000000000000000000000000000000000000000",
        imageContent: [LoginPage.currentUser!.avatarUrl!],
        author: LoginPage.currentUser,
        createdAt: DateTime.now());
    return Scaffold(
        appBar: AppBar(
            title: Text('Bookmarks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 216, 204, 208),
                size: 30.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            )),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return PostItem(post: postResponse);
            },
            itemCount: 2,
          ),
        ));
  }
}
