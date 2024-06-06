import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:buzz_hub/modules/profile/views/profile.dart' as profile;
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/modules/search/controller/search_bar_controller.dart';
import 'package:buzz_hub/services/get_all_user_service.dart';
import 'package:buzz_hub/services/dto/responses/get_all_user_response.dart';
import 'package:buzz_hub/services/dto/requests/friend_request.dart';
import  'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/friend_request_service.dart';
import 'package:buzz_hub/services/check_status_friend.dart';


class MySearchBarApp extends StatefulWidget {
  @override
  _MySearchBarAppState createState() => _MySearchBarAppState();
}

class _MySearchBarAppState extends State<MySearchBarApp> {
  List<UserResponse>? allUser;
  // Assuming you have an instance of FriendService
  FriendRequest friendRequest = FriendRequest(receiverId: 'string');

  @override
  void initState() {
    super.initState();

    // Create an instance of the GetAllUserService
    final getAllUserService = GetAllUserService();

    // Call the getAllUsers method to fetch the list of users
    getAllUserService.getAllUsers().then((users) {
      setState(() {
        allUser = users;
      });
    });
  }
  


  // Example method to retrieve article data
  Map<String, dynamic> getArticleData(int index) {
    // Replace with your actual data retrieval logic
    final topics = ['Technology', 'Science', 'Health', 'Business'];
    final illustrations = [
      'assets/images/tech.jpg',
      'assets/images/science.jpg',
      'assets/images/health.jpg',
      'assets/images/business.jpg',
    ];
    final contents = [
      'Technology',
      'Science',
      'Health',
      'Business',
    ];

    return {
      'topic': topics[index],
      'illustrationUrl': illustrations[index],
      'content': contents[index],
    };
  }


  Map<String, dynamic> getVideo(int index) {
    // Replace with your actual data retrieval logic
    final illustrations = [
      'assets/images/music.png',
      'assets/images/dance.png',
      'assets/images/trend.png',
      'assets/images/doremon.png',
    ];

    return {
      'illustrationUrl': illustrations[index],
    };
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile.ProfileScreen()),
                );
              },
            child: CircleAvatar(
              // Retrieve the user's current image here
              backgroundImage: AssetImage('assets/images/user.jpg'),
              radius: 16,
            )),
            SizedBox(width: 16), // Add spacing between circle and search bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () { 
                      showSearch(context: context, delegate: CustomSearchDelegate(allUser ?? []));
                    }
                  )
                ),
                onTap: () {
                  showSearch(context: context, delegate: CustomSearchDelegate(allUser ?? []));
                }
              ),
            ),
            SizedBox(width: 16), // Add spacing between search bar and button
            IconButton(
              onPressed: () {
                // Handle button press
              },
              icon: Icon(
                IconData(0xee36, fontFamily: 'MaterialIcons'),
              ), // Replace with your desired non-text icon
            ),
          ],
        ),
      ),
            body: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 16.0),
                      child: 
                      Text(
                        'Trends',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle button press
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                  ],
                ),
                Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    final articleData = getArticleData(index);
                    return ArticleCard(
                      topic: articleData['topic'],
                      illustrationUrl: articleData['illustrationUrl'],
                      content: articleData['content'],
                    );
                  }),
                )),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 16.0),
                    child: 
                    Text(
                      'Videos',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text(
                  'View More',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ],
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    final articleData = getVideo(index);
                    return Video(
                      illustrationUrl: articleData['illustrationUrl'],
                    );
                  }),
                )),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class CustomSearchDelegate extends SearchDelegate {
  List<UserResponse> allUser;
  final friendRequestService = FriendRequestService();
  CheckFriendStatusService service = CheckFriendStatusService();


  CustomSearchDelegate(this.allUser);
  
  ImageProvider getAvatarImage(UserResponse user) {
      if (user.avatarUrl != 'string' && user.avatarUrl != '') {
        return NetworkImage(Constants.HOST_AVATAR_URL + user.avatarUrl);
      } else {
        return const AssetImage('assets/images/user.jpg');
      }
    }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var item in allUser) {
      if (item.userName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item.userName);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserResponse> matchUser = allUser.where((user) => user.userName.toLowerCase().contains(query.toLowerCase())).toList();


    return ListView.builder(
      itemCount: matchUser.length,
      itemBuilder: (context, index) {
        var user = matchUser[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12),
              width: MediaQuery.of(context).size.width * 0.2,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: getAvatarImage(user),
            ),
            ),
            SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                user.userName, // Display the username here
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: Color(0xFFF2F2F2),
                ),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (user.isFriend) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Unfriend ${user.userName}?'),
                        content: Text('Are you sure you want to unfriend ${user.userName}?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              // try {
                              //   await friendRequestService.unfriendUser(user.userName);
                              //   Navigator.pop(context);
                              //   // Update the user's friend status here
                              // } catch (e) {
                              //   // Handle the exception here
                              // }
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          )
                        ]
                      )
                    );
                  } else {
                    try {
                      await friendRequestService.sendFriendRequest(FriendRequest(
                        receiverId: user.userName,
                      ));
                      // Update the user's friend status here
                    } catch (e) {
                      // Handle the exception here
                    }
                  }
                },
                child: FutureBuilder<bool?>(
                      future: service.checkFriendStatus(user.userName),
                      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();  // Show a loading spinner while waiting
                        } else {
                          bool? isRequest = snapshot.data;
                          return Text(
                            user.isFriend ? 'Unfriend' : (isRequest == true ? 'Request Sent' : 'Add Friend'),
                            style: TextStyle(
                              color: user.isFriend ? Colors.red : (isRequest == true ? Colors.orange : Colors.green),
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    )
              ),
            )])
          ]
        );
      }
    );
  }
}

// Custom ArticleCard widget (same as before)
class ArticleCard extends StatelessWidget {
  final String topic;
  final String illustrationUrl; // Replace with actual image URLs
  final String content;

  ArticleCard({
    required this.topic,
    required this.illustrationUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.asset(
              illustrationUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              topic,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom ArticleCard widget (same as before)
class Video extends StatelessWidget {
  final String illustrationUrl; // Replace with actual image URLs

  Video({
    required this.illustrationUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(illustrationUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: Icon(Icons.play_arrow),
        )
      )
    );
  }
}

