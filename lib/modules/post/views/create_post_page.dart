import 'package:flutter/material.dart';
import 'package:buzz_hub/modules/post/models/post_model.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost>  {

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
                      child: Text('Create post',
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
            SizedBox(
              width: double.infinity,
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const SizedBox(width: 10.0);
                  }
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration:
                        const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ]),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 60.0,
                          width: 60.0,
                          image: AssetImage(stories[index - 1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                height: 520.0,
                decoration: BoxDecoration(
                    // color: Colors.red,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 100,
                                height: 100,
                                // color: Colors.black,
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
                                          AssetImage(posts[0].authorImageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                posts[0].authorName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 80),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 30),
                                      
                                    ]
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type here...",
                            border: InputBorder.none,
                          ),
                          scrollPadding: EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          autofocus: false,
                          minLines: 6, // any number you need (It works as the rows for the textarea)
                          maxLines: null,
                      ),
                    )
                 ],
                ),
              ),
            )
          ]),
    );
  }
}
