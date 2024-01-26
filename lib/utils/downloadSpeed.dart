import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

class DownloadSpeed extends StatefulWidget {
  const DownloadSpeed({super.key});

  @override
  State<DownloadSpeed> createState() => _DownloadSpeedState();
}

class _DownloadSpeedState extends State<DownloadSpeed> {
  final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();

  bool _testInProgress = false;
  double _downloadRate = 0;
  String _downloadProgress = '0';
  int _downloadCompletionTime = 0;
  bool _isServerSelectionInProgress = false;

  String _unitText = 'Mbps';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      reset();
    });
    if (!_testInProgress) {
      //do Something....
      startDownload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  Text('Progress: $_downloadProgress%'),
                Text('Download Rate: $_downloadRate $_unitText'),
                if (_downloadCompletionTime > 0)
                  Text(
                      'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startDownload() async {
    reset();
    await internetSpeedTest.startTesting(
        onStarted: () {
          setState(() => _testInProgress = true);
        },
        onCompleted: (TestResult download, TestResult upload) {
          if (kDebugMode) {
            print(
                'the transfer rate ${download.transferRate}, ${upload.transferRate}');
          }
          setState(() {
            _downloadRate = download.transferRate;
            _unitText = download.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
            _downloadProgress = '100';
            _downloadCompletionTime = download.durationInMillis;
          });
        },
        onProgress: (double percent, TestResult data) {
          if (kDebugMode) {
            print('the transfer rate $data.transferRate, the percent $percent');
          }
          setState(() {
            _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
            if (data.type == TestType.download) {
              _downloadRate = data.transferRate;
              _downloadProgress = percent.toStringAsFixed(2);
            } else {}
          });
        },
        onError: (String errorMessage, String speedTestError) {
          if (kDebugMode) {
            print(
                'the errorMessage $errorMessage, the speedTestError $speedTestError');
          }
          reset();
        },
        onDefaultServerSelectionInProgress: () {
          setState(() {
            _isServerSelectionInProgress = true;
          });
        },
        onDefaultServerSelectionDone: (Client? client) {},
        onDownloadComplete: (TestResult data) {
          setState(() {
            _downloadRate = data.transferRate;
            _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
            _downloadCompletionTime = data.durationInMillis;
          });
        },
        onUploadComplete: (TestResult data) {},
        onCancel: () {
          reset();
        });
  }

  void reset() {
    setState(() {
      {
        _testInProgress = false;
        _downloadRate = 0;

        _downloadProgress = '0';

        _unitText = 'Mbps';
        _downloadCompletionTime = 0;
      }
    });
  }
}
