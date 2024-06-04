import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:buzz_hub/modules/profile/views/profile.dart';

class MySearchBarApp extends StatefulWidget {
  @override
  _MySearchBarAppState createState() => _MySearchBarAppState();
}

class _MySearchBarAppState extends State<MySearchBarApp> {
  final TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = "Search query"; // Initial search query

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
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
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
                readOnly: true,
                onTap: () {
                  showSearch(
                    context: context, 
                    delegate: CustomSearchDelegate(),
                  );
                },
                controller: _searchQueryController,
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
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
                  suffixIcon: Icon(Icons.search),
                ),
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
                    return AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(child: Text('Article ${index + 1}')),
                    ),
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
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // Replace this with your actual data
                    child: Center(child: Text('Video ${index + 1}')),
                  );
                }),
              ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
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
  Widget buildResults(BuildContext context) {
    return SearchResultPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class SearchResultPage extends StatelessWidget {
  final String query;

  SearchResultPage({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(child: Text('Hots'), onPressed: () {}),
                ElevatedButton(child: Text('Pictures'), onPressed: () {}),
                ElevatedButton(child: Text('Videos'), onPressed: () {}),
                ElevatedButton(child: Text('Accounts'), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // Your search result goes here
            ),
          ),
        ],
      ),
    );
  }
}