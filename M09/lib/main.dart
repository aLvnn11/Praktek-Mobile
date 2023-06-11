import 'package:basic/components/music.dart';
import 'package:flutter/material.dart';

import 'components/favorite.dart';
import 'components/saved.dart';
import 'components/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pertemuan09Screen(),
    );
  }
}

class Pertemuan09Screen extends StatefulWidget {
  const Pertemuan09Screen({Key? key}) : super(key: key);

  @override
  State<Pertemuan09Screen> createState() => _Pertemuan09ScreenState();
}

class _Pertemuan09ScreenState extends State<Pertemuan09Screen> {
  buttonSheets(BuildContext context) {
    return Builder(builder: ((context) {
      return Center(
        child: TextButton(
          onPressed: () {
            showBottomSheet(
                enableDrag: true,
                context: context,
                builder: (context) {
                  final theme = Theme.of(context);
                  return Wrap(
                    children: [
                      ListTile(
                        title: Text(
                          'shared link',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        tileColor: theme.colorScheme.primary,
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                      ),
                      ListTile(
                        title: Text('Facebook'),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.copy,
                              color: Colors.black,
                            )),
                      ),
                      ListTile(
                        title: Text('Twitter'),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.copy,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  );
                });
          },
          child: Text('Social Media Share'),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Mengubah jumlah tab menjadi 4
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pertemuan 09'),
          backgroundColor: Color.fromARGB(255, 226, 46, 1),
          bottom: TabBar(isScrollable: true, tabs: [
            Tab(
              child: Text('Music'),
            ),
            Tab(
              child: Text('Favorite'),
            ),
            Tab(
              child: Text('Saved'),
            ),
            Tab(
              child: Text('New Tab'), // Menambahkan tab baru
            ),
          ]),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.all(16.0),
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 226, 46, 1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.asset('img/img.jpeg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Alvin Laia',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'alvinlaia@gmail.com',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                },
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.save),
                title: const Text('Archived'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.download),
                title: const Text('Saved'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Music(), // Menggunakan komponen Music pada tab pertama
            buttonSheets(context),
            Favorite(), // Menggunakan komponen Favorite pada tab kedua
            Saved(), // Menggunakan komponen Saved pada tab ketiga
            Center(
                child: Text('New Tab Content')), // Konten baru pada tab keempat
          ],
        ),
      ),
    );
  }
}
