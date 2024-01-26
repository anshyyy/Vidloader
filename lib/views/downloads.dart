import 'package:flutter/material.dart';
import 'package:vidloader/data/recentDownload.dart';
import 'package:vidloader/domain/fileList.dart';

class DownloadPage extends StatefulWidget {
  String fileUrl;

  DownloadPage({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int downloading = 0;
  @override
  void initState() {
    super.initState();
  }

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
        child: SizedBox(
          child: Center(
            child: Visibility(visible: downloading != 0, child: FileList()),
          ),
        ),
      ),
    );
  }
}
