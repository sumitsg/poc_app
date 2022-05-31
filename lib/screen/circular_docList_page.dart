// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poc_app/screen/pdf_viewer_page.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:universal_html/html.dart' as html;
// import 'dart:html' as html;

import '../model/CircularDetailsModel.dart';
import 'package:download/download.dart';

const debug = true;

class CircularDocListPage extends StatefulWidget {
  CircularDocListPage({
    Key? key,
    required this.title,
    required this.circularNumber,
    required this.isCircularNum,
    required this.isLatest,
  }) : super(key: key);
  String title;
  bool isCircularNum;
  bool isLatest;
  String circularNumber;

  @override
  State<CircularDocListPage> createState() => _CircularDocListPageState();
}

class _CircularDocListPageState extends State<CircularDocListPage> {
  Dio dio = Dio();

  List<CircularDetailModel> dummyData = CircularDetailModel.dummyData();
  List<CircularDetailModel> resultData = [];

  // final pdfUrl = "https://www.hq.nasa.gov/alsj/a17/A17_FlightPlan.pdf";
  final pdfUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  // List<_TaskInfo>? _tasks;
  bool isDownloading = false;
  bool fileExist = false;
  int progress = -1;
  late int count = 0;
  String fileName = "download";

  Directory? externalDir;

  // static downloadingcallback(id, status, progress) {
  //   // looking up for send port
  //   SendPort? sendPort = IsolateNameServer.lookupPortByName('downloading');

  //   sendPort?.send([id, status, progress]);
  // }

  // ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    if (!widget.isLatest) {
      sortList(widget.circularNumber, widget.isCircularNum);
    } else {
      resultData = dummyData;
    }
  }

  sortList(String cNumber, bool isNum) {
    if (isNum) {
      resultData = dummyData
          .where((element) => element.circularNo.contains(cNumber))
          .toList();
    } else {
      resultData = dummyData
          .where((element) =>
              element.subject.toLowerCase().contains(cNumber.toLowerCase()))
          .toList();
    }
  }

  Future<void> downloadFile(String cNumberFile) async {
    print('IN Download function');

    if (!kIsWeb) {
      var status = await Permission.storage.request();
      print("after permission");
      if (status.isGranted) {
        String dirloc = "";
        if (Platform.isAndroid) {
          dirloc = "/sdcard/download/";
        } else {
          dirloc = (await getApplicationDocumentsDirectory()).path;
        }

        FileUtils.mkdir([dirloc]);
        print(dirloc);

        while (await File('$dirloc${cNumberFile}_${++count}.pdf').exists()) {}

        String fileNameTemp = '${cNumberFile}_$count.pdf';
        try {
          await dio.download(
            pdfUrl,
            '$dirloc/$fileNameTemp',
            onReceiveProgress: ((received, total) {
              if (received != -1) {
                // setState(() {
                progress = (received / total * 100).toInt();
                // if (progress == 100) {
                //   isDownloading = false;
                // }
                print("progress is $progress");
                // });
                print((received / total * 100).toStringAsFixed(0) + "%");
              }
            }),
          );
        } on DioError catch (e) {
          print('in dio error');
          print(e.message);
        }
      } else if (status.isPermanentlyDenied) {
        // await Permission.storage.request();
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text('Please enable storage access from setting'),
                ));
      }
    } else {
      launchUrl(Uri.parse(pdfUrl));
    }
  }

  Future<String> viewPdf(String cNumberFile) async {
    if (!kIsWeb) {
      var status = await Permission.storage.request();
      String pathToFile = '';

      if (status.isGranted) {
        String dirloc = "";
        if (Platform.isAndroid) {
          dirloc = "/sdcard/download/";
        } else {
          dirloc = (await getApplicationDocumentsDirectory()).path;
        }

        FileUtils.mkdir([dirloc]);

        for (int i = 0; i < 10; i++) {
          pathToFile = '$dirloc${cNumberFile}_$i.pdf';
          if (await File(pathToFile).exists()) {
            // fileExist = true;
            return pathToFile;
          }
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text('Please enable storage access from setting'),
                ));
      }
    } else {
      print('app running in web ');
      return pdfUrl;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: resultData.length == 0
          ? const Center(
              child: Text(
                'NO DATA FOUND...',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.separated(
              separatorBuilder: ((context, index) {
                return const Divider(
                  thickness: 2,
                );
              }),
              shrinkWrap: true,
              itemCount: resultData.length,
              itemBuilder: (context, index) {
                // if (!isDownloading) {
                //   return listData(index, context);
                // } else if (isDownloading) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
                return listData(index, context);
              }),
    );
  }

  Widget listData(int index, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        "Circular No: ${resultData[index].circularNo} ",
                        style: TextStyle(
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        resultData[index].type,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  resultData[index].subject,
                  style: const TextStyle(),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(top: 8, right: 5),
            height: 120,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () async {
                        String circularNum = resultData[index].circularNo;
                        // setState(() {
                        //   isDownloading = true;
                        // });
                        await downloadFile(circularNum);
                      },
                      child: const Text(
                        'Download',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () async {
                        String circularNum = resultData[index].circularNo;
                        if (kIsWeb) {
                          launchUrl(Uri.parse(pdfUrl));
                        } else {
                          String result = await viewPdf(circularNum);
                          result.isNotEmpty
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PdfViewerPage(
                                      circular: resultData[index].circularNo,
                                      filePath: result)))
                              : showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                        title: Text(
                                            'File is not Exist. Please Download first'),
                                      ));
                        }
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
