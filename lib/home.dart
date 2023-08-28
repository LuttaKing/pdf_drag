// ignore_for_file: prefer_const_constructors


import 'package:flutter/foundation.dart';
import 'package:pdf_drag/utils.dart';
import 'package:printing/printing.dart';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});



  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final pdf = pw.Document();

  PrintingInfo? _printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      _printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(icon: Icon(Icons.picture_as_pdf), onPressed: saveAsFile)
    ];

    return Scaffold(
      
      body: PdfPreview(
        onPrinted: (context) => print('shared'),
        onShared: (context) => print('shared'),
        actions: actions,
        build: (PdfPageFormat format) => generatePdf(),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
