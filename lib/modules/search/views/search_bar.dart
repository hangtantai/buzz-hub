import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:buzz_hub/modules/profile/views/profile.dart' as profile;
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/get_all_user_service.dart';
import 'package:buzz_hub/services/dto/responses/get_all_user_response.dart';
import 'package:buzz_hub/services/dto/requests/friend_request.dart';
import  'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/friend_request_service.dart';
import 'package:buzz_hub/services/check_status_friend.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';

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
                  MaterialPageRoute(builder: (context) => profile.ProfileScreen(user: LoginPage.currentUser!)),
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
                  ],
                ),
                Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
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
              ],
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
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

    CurrentUserResponse? mapToUserResponse(UserResponse? user) {
    if (user == null) return null;
    return CurrentUserResponse(
      user.userName,
      user.fullName,
      user.email,
      user.avatarUrl,
      user.dob,
      user.gender,
      user.isFriend,
    );
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
    if (query.isEmpty) {
      return Container();
    }
    List<UserResponse> matchUser = allUser.where((user) => user.userName.toLowerCase().contains(query.toLowerCase())).toList();

    // 8. Separate function for friend button logic
    Widget _buildFriendButton(UserResponse user) {
      return FutureBuilder<bool?>(
        future: service.checkFriendStatus(user.userName),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            bool? isRequest = snapshot.data;
            return ElevatedButton(
              onPressed: () async {
                // ... (Your existing friend request/unfriend logic)
              },
              style: ElevatedButton.styleFrom(
                // 9. Customize button style
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
                backgroundColor: user.isFriend
                    ? Colors.red
                    : (isRequest == true ? Colors.orange : Colors.green),
              ),
              child: Text(
                user.isFriend
                    ? 'Unfriend'
                    : (isRequest == true ? 'Request Sent' : 'Add Friend'),
              ),
            );
          }
        },
      );
    }

    return ListView.builder(
      itemCount: matchUser.length,
      itemBuilder: (context, index) {
        var user = matchUser[index];
        return Card( // 1. Encapsulate each result in a Card
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 2, // 2. Add subtle elevation for depth
          child: InkWell( // 3. Make the entire card tappable
            onTap: () {
              // TODO: Navigate to user profile or details page
              Get.to(() => profile.ProfileScreen(user: mapToUserResponse(user))); 
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // 4. Center vertically
                children: [
                  CircleAvatar(
                    radius: 30, // 5. Adjust avatar size
                    backgroundImage: getAvatarImage(user),
                  ),
                  SizedBox(width: 16),
                  Expanded( // 6. Allow username to take up available space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.userName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500, // 7. Use a suitable font weight
                          ),
                        ),
                        // You can add more user details here (e.g., email)
                      ],
                    ),
                  ),
                  _buildFriendButton(user), // 8. Separate button logic
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserResponse> matchUser = allUser.where((user) => user.userName.toLowerCase().contains(query.toLowerCase())).toList();

    // 8. Separate function for friend button logic
    Widget _buildFriendButton(UserResponse user) {
      return FutureBuilder<bool?>(
        future: service.checkFriendStatus(user.userName),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            bool? isRequest = snapshot.data;
            return ElevatedButton(
              onPressed: () async {
                // ... (Your existing friend request/unfriend logic)
              },
              style: ElevatedButton.styleFrom(
                // 9. Customize button style
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
                backgroundColor: user.isFriend
                    ? Colors.red
                    : (isRequest == true ? Colors.orange : Colors.green),
              ),
              child: Text(
                user.isFriend
                    ? 'Unfriend'
                    : (isRequest == true ? 'Request Sent' : 'Add Friend'),
              ),
            );
          }
        },
      );
    }

    return ListView.builder(
      itemCount: matchUser.length,
      itemBuilder: (context, index) {
        var user = matchUser[index];
        return Card( // 1. Encapsulate each result in a Card
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 2, // 2. Add subtle elevation for depth
          child: InkWell( // 3. Make the entire card tappable
            onTap: () {
              // TODO: Navigate to user profile or details page
              Get.to(() => profile.ProfileScreen(user: mapToUserResponse(user))); 
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // 4. Center vertically
                children: [
                  CircleAvatar(
                    radius: 30, // 5. Adjust avatar size
                    backgroundImage: getAvatarImage(user),
                  ),
                  SizedBox(width: 16),
                  Expanded( // 6. Allow username to take up available space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.userName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500, // 7. Use a suitable font weight
                          ),
                        ),
                        // You can add more user details here (e.g., email)
                      ],
                    ),
                  ),
                  _buildFriendButton(user), // 8. Separate button logic
                ],
              ),
            ),
          ),
        );
      },
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

