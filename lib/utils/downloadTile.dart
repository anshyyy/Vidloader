import 'package:flutter/material.dart';
import 'package:vidloader/domain/urlController.dart';
import 'package:vidloader/utils/downloadSpeed.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DownloadTile extends StatefulWidget {
  String url;
  DownloadTile({super.key, required this.url});

  @override
  State<DownloadTile> createState() => _DownloadTileState();
}

class _DownloadTileState extends State<DownloadTile> {
  // double progressOfDownload = 0.0; // Progress value between 0.0 and 1.0
  String title = DateTime.now().millisecondsSinceEpoch.toString();
  String downloadAbleUrl = "";
  double _progress = 0;
  void startDownload() async {
    String urlFromBackend = await Http(url: widget.url).fetchUrlOfTheVideo();

    setState(() {
      downloadAbleUrl = urlFromBackend;
      fileDownload();
    });
  }

  bool isUrl(String input) {
    // Regular expression for a simple URL pattern
    RegExp urlRegex = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
    );

    return urlRegex.hasMatch(input);
  }

  void fileDownload() {
    if (isUrl(downloadAbleUrl)) {
      try {
        FileDownloader.downloadFile(
            url: downloadAbleUrl,
            name: "$title.mp4", //(optional)
            onProgress: (String? fileName, double progress) {
              print('Download progress for file $fileName: $progress');
              setState(() {
                _progress = progress;
              });
            },
            onDownloadCompleted: (String path) {
              print('FILE DOWNLOADED TO PATH: $path');
            },
            onDownloadError: (String error) {
              print('DOWNLOAD ERROR: $error');
            });
      } catch (err) {
        print("Something went wrong");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    startDownload();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(
                  4.0,
                  1.0,
                ),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: downloadAbleUrl == ""
              ? Center(child: CircularProgressIndicator())
              : Row(
                  children: [
                    Container(
                      width: 80,
                      child: const Icon(
                        Icons.file_copy,
                        size: 32,
                      ),
                    ),
                    const VerticalDivider(color: Colors.black, thickness: 2),
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Progress: $_progress%"),
                          Container(
                            child: const DownloadSpeed(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: MediaQuery.of(context).size.width / 1.8,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey, // Initial grey color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 2.2 * _progress,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFF39FF14), // Green color as download progresses
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
