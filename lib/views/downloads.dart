import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DownloadPage extends StatefulWidget {
  int pushed;
  String fileUrl;

  DownloadPage({
    Key? key,
    required this.pushed,
    required this.fileUrl,
  }) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Downloads",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff014bf4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(widget.fileUrl,
                          style: TextStyle(color: Colors.black)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
