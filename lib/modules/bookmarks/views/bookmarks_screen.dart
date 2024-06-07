import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_null.dart';
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
  bool isLiked = false, isBookmarked = false;

  @override
  Widget build(BuildContext context) {
     Widget builtPost(int index) {
    return Container(
      // constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 20),
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
              backgroundImage: AssetImage(posts[index].imageAuthor)
            ),
          ),
          title: Text(
            posts[index].author,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].createdAt,
            style: const TextStyle(fontSize: 12),
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
                posts[index].textContent,
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
                        image: AssetImage(posts[index].imageContent)
                  )
                )
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

    return Scaffold(
        appBar: AppBar(
            title: const Text('Bookmarks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 216, 204, 208),
                size: 30.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            )),
        backgroundColor: Colors.white,
        body: posts.isEmpty
            ? const BookMarksNull()
        : Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return builtPost(index);
            },
            itemCount: posts.length,
          ),
        ));
  }
}