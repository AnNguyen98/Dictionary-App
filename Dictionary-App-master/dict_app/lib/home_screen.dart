import 'dart:io';
import 'package:dictionary_app/constants.dart';
import 'package:dictionary_app/word.dart';
import 'package:dictionary_app/word_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchController;
  Database database;
  List<Word> words = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    getData();
  }

  //Copy file database and get Path
  Future<String> getPath() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "anh_viet.db");
    //Delete any existing database:
    await deleteDatabase(dbPath);
    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("data/anh_viet.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    return dbPath;
  }

  Future<List<Word>> getData() async {
    // Get a reference to the database.
    var dbPath = await getPath();
    var db = await openDatabase(dbPath);
    // Query the table for all Words.
    final List<Map<String, dynamic>> maps = await db.query(e_v_tablename);
    for (int i = 0; i < maps.length; i++) {
      var word = Word(
        id: maps[i]["id"],
        word: maps[i]['word'],
        content: maps[i]['content'],
      );
      setState(() {
        words.add(word);
      });
    }
    return words;
  }

  handleDrawerMenu() {
    _scaffoldKey.currentState.openDrawer();
  }

  handleSearch(String text) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        margin: EdgeInsets.only(top: 60),
        width: 300,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "Dictionary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                "English-Vietnamese",
              ),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "English-English",
              ),
              leading: Icon(Icons.library_books),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Vietnamese-English",
              ),
              leading: Icon(Icons.edit),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Favorites",
              ),
              leading: Icon(Icons.favorite_border),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Your words",
              ),
              leading: Icon(Icons.book),
              onTap: () {},
            ),
            Divider(),
            Text("Communicate"),
            ListTile(
              title: Text(
                "Share",
              ),
              leading: Icon(Icons.share),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Help",
              ),
              leading: Icon(Icons.help),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("ENG-VIET"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: handleDrawerMenu,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.only(top: 6, bottom: 5, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (text) {
                  handleSearch(text);
                },
                decoration: InputDecoration(
                  hintText: "Nhập từ kiểm tra...",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                initialData: words,
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        var word = words[index];
                        return Card(
                          child: MaterialButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WordScreen(word: word),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(word.word),
                                    Text("(thông tục) loại a, hạng nhất")
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.volume_up),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
