import '../data/recentDownload.dart';
import 'package:flutter/material.dart';

class FileList extends StatelessWidget {
  const FileList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return TileList(fileUrl: "", title: "");
            }),
      ),
    );
  }
}

class TileList extends StatefulWidget {
  const TileList({super.key, required this.fileUrl, required this.title});
  final String fileUrl;
  final String title;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.shade100,
      child: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.download),
        ),
      ),
    );
  }
}
