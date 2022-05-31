import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({
    Key? key,
    required this.filePath,
    required this.circular,
  }) : super(key: key);
  final String filePath;
  final String circular;

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  void initState() {
    super.initState();
    print("file path is ${widget.filePath}");
    // loadPdf(widget.url);
  }

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular No: ${widget.circular} PDF'),
      ),
      body: SfPdfViewer.file(
        File(
          widget.filePath,
        ),
        scrollDirection: PdfScrollDirection.vertical,
        initialZoomLevel: 1.2,
      ),
    );
  }
}
