import 'package:apps_newspaper/models/newsInfo.dart';
import 'package:apps_newspaper/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Berita Hari Ini"),
        backgroundColor: Colors.blue[400],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
              accountName: Text('Hafidz Fadhillah'), 
              accountEmail: Text('hafidzfadhillah606@gmail.com'),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.dashboard),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/kategori'),
              title: Text('List Kategori'),
              leading: Icon(Icons.sort),
            ),
              ListTile(
              title: Text('Berita Terbaru'),
              leading: Icon(Icons.event_note_rounded),
            ),
            ListTile(
              title: Text('Kamu Sukai'),
              leading: Icon(Icons.bookmark),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10),
              child: Text('Labels',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
            ),
            ListTile(
              title: Text('Akun'),
              leading: Icon(Icons.account_box_rounded),
            ),
            ListTile(
              title: Text('Pengaturan'),
              leading: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];
                    return Container(
                      height: 110,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                article.urlToImage,
                                fit: BoxFit.cover,
                              )),
                          ),
                          SizedBox(width: 14),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                    article.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,  
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text (
                                    "Author: " + article.author, 
                                  ),
                                ),
                                 Text("Desc: " +
                                  article.content, 
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          )
                        ]
                      ),
                    );
                  });
            } else
              return Center(
                child: SpinKitCubeGrid(
                  color: Colors.blue[400],
                  size: 100.0,
                )
              );
          },
        ),
      ),
    );
  }
}
