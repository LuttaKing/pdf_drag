// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

Future<void> saveAsFile(BuildContext context, LayoutCallback build,
    PdfPageFormat pageFormat) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print('save as file ${file.path}...');
  await file.writeAsBytes(bytes);

  await OpenFile.open(file.path);
}

Future<Uint8List> generatePdf() async {
  final doc = pw.Document(title: 'Some Title');

  doc.addPage(pw.MultiPage(
      //use Page for one page
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
         page1(),
         page2(),
        ];
      }));

  return doc.save();
}

 page1() {
  return pw.Center(
    child: pw.Column(children:[
      pw.Text(
        "ChromeProxyService: Initializing expression compiler \n for main_module.bootstrap.js with sound null safety: true",
        style: pw.TextStyle(fontSize: 10, color: PdfColor.fromHex('#b74093'))),
    ]),
  );
}

page2() {
  return pw.Center(
    child: pw.Column(children:[
      pw.SizedBox(height: 700),
      pw.Text(
        "ChromeProxyService: Initializing expression compiler \n for main_module.bootstrap.js with sound null safety: true",
        style: pw.TextStyle(fontSize: 10, color: PdfColor.fromHex('#b74093'))),
    ]),
  );
}


