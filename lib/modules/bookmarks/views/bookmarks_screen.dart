import 'package:flutter/material.dart';
import 'package:buzz_hub/modules/post/models/post_model.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBookmarks createState() => _CreateBookmarks();
}

class _CreateBookmarks extends State<BookMarks>  {
  Widget _builtPost(int index) {
    return 
    Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                // constraints: const BoxConstraints.expand(),
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: Colors.red,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 10, right: 0.0),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent),
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
                                      image:
                                          AssetImage(posts[index].authorImageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            title: Text(
                              posts[0].authorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold
                              ),
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
                              offset: Offset(0,5),
                              blurRadius: 8.0
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage(posts[index].imageUrl),
                            fit: BoxFit.fitWidth,
                          )
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
                          onPressed: () => print('Note'),),
                        ],
                      ),
                    ],
                  )
                ]
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: const Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 216, 204, 208),
                      size: 30.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      child: Text('Bookmarks',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )),
            const Column(
              children: <Widget>[
                Divider(
                  color: Colors.black,
                )
              ],
            ),
            _builtPost(0),
            const SizedBox(height: 10),
            _builtPost(1),
          ],
      )
    );
  }
}
