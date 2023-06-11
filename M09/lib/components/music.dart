import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Music extends StatefulWidget {
  Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return ListTile(
          leading: const CircleAvatar(),
          title: Text("Goun-toubun nohanoyome"),
          subtitle: Text('YOASOBI'),
        );
      },
      itemCount: 5,
    );
  }
}
