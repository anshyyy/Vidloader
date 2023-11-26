import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:twitter_extractor/twitter_extractor.dart';
import 'package:vidloader/views/downloads.dart';
import 'package:vidloader/views/settings.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  StreamSubscription? _dataStreamSubscription;
  String _sharedText = "";
  final TextEditingController _searchBar = TextEditingController();
  @override
  void initState() {
    super.initState();

    _dataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String text) {
      setState(() {
        _sharedText = text;
      });
    });
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        _sharedText = value!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dataStreamSubscription!.cancel();
    _searchBar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Vidloader",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff014bf4),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.settings_sharp,
                  color: Colors.white,
                ),
                onPressed: (() {
                  // go to setting page

                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Settings()));
                }),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 20),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _searchBar,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.link_sharp),
                      fillColor: Colors.white,
                      hintText: "Paste Your URL....",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 0,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          _sharedText = _searchBar.text.toString();
                        });
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: DownloadPage(
                                  fileUrl: _sharedText,
                                  pushed: 1,
                                )));
                      },
                      color: const Color(0xff014bf4),
                      child: const Center(
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(
                _sharedText,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
