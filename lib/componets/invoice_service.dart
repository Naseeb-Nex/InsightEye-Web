import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceService {

  Future<Uint8List> createInvoice(List programs, String name, String date, String orgName, String orgType, String orgAddress) async {
    final pdf = pw.Document();
    var image = pw.MemoryImage(
      (await rootBundle.load('assets/icons/appicon.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          int len = 0;
          if (programs.length > 8) {
            len = 8;
          } else {
            len = programs.length;
          }
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        orgName,
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.red),
                      ),
                      pw.Text(orgType,
                          style: const pw.TextStyle(fontSize: 11)),
                      pw.Text(orgAddress,
                          style: const pw.TextStyle(fontSize: 11)),
                    ],
                  ),
                  pw.SizedBox(width: 120, height: 50, child: pw.Image(image))
                ],
              ),
              pw.Divider(color: PdfColors.red),
              pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text("PROGRAM SHEET",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold)),
              ),
              pw.Center(
                child: pw.SizedBox(width: 100, child: pw.Divider(height: 5)),
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("NAME: $name",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.Text("DATE: $date",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.SizedBox(height: 20),
              itemColumn(programs, 0, len),
              pw.SizedBox(height: 15),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('VEHICLE STARTING KM: ',
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.Text('VEHICLE CLOSING KM:                   ',
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text('Authorised Signatory',
                    style: pw.TextStyle(
                        fontSize: 8, fontWeight: pw.FontWeight.bold)),
              ])
            ],
          );
        },
      ),
    );
    if (programs.length > 9) {
      pdf.addPage(
        pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            orgName,
                            style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.red),
                          ),
                          pw.Text(orgType,
                              style: const pw.TextStyle(fontSize: 11)),
                          pw.Text(orgAddress,
                              style: const pw.TextStyle(fontSize: 11)),
                        ],
                      ),
                      pw.SizedBox(
                          width: 120, height: 50, child: pw.Image(image))
                    ],
                  ),
                  pw.Divider(color: PdfColors.red),
                  pw.SizedBox(height: 5),
                  pw.Center(
                    child: pw.Text("PROGRAM SHEET",
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Center(
                    child:
                        pw.SizedBox(width: 100, child: pw.Divider(height: 5)),
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("NAME: $name",
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.Text("Date: $date",
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      ]),
                  pw.SizedBox(height: 20),
                  itemColumn(programs, 8, programs.length),
                  pw.Text('Page : 2',
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold)),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('Authorised Signatory',
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold)),
                      ])
                ],
              );
            }),
      );
    }
    return pdf.save();
  }

  pw.Expanded itemColumn(List elements, int start, int end) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          pw.Row(
            children: [
              pw.Flexible(
                flex: 1,
                fit: pw.FlexFit.tight,
                child: pw.Container(
                  height: 30,
                  alignment: pw.Alignment.center,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Text('SL NO',
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                ),
              ),
              pw.Flexible(
                flex: 11,
                fit: pw.FlexFit.tight,
                child: pw.Container(
                  height: 30,
                  alignment: pw.Alignment.center,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Text('PROGRAM',
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                ),
              ),
              pw.Flexible(
                flex: 6,
                fit: pw.FlexFit.tight,
                child: pw.Container(
                  height: 30,
                  alignment: pw.Alignment.center,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Text('REMARKS',
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                ),
              ),
            ],
          ),
          for (var i = start; i < end; i++) ...[
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Row(
                children: [
                  pw.Flexible(
                    flex: 1,
                    fit: pw.FlexFit.tight,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text('${i + 1}',
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.Flexible(
                    flex: 11,
                    fit: pw.FlexFit.tight,
                    child: pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                              left: pw.BorderSide(
                                  color: PdfColors.black, width: 1),
                              right: pw.BorderSide(
                                  color: PdfColors.black, width: 1)),
                        ),
                        alignment: pw.Alignment.center,
                        child: pw.RichText(
                            softWrap: true,
                            text: pw.TextSpan(children: <pw.TextSpan>[
                              pw.TextSpan(
                                  text: "${elements[i]["name"]}",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.TextSpan(
                                  text: " ${elements[i]["address"]}",
                                  style: const pw.TextStyle(fontSize: 10)),
                              pw.TextSpan(
                                  text: " ${elements[i]["loc"]}",
                                  style: const pw.TextStyle(fontSize: 10)),
                              pw.TextSpan(
                                  text: " ${elements[i]["prospec"]}",
                                  style: const pw.TextStyle(fontSize: 10)),
                              pw.TextSpan(
                                  text: " ${elements[i]["instadate"]}",
                                  style: const pw.TextStyle(fontSize: 10)),
                              pw.TextSpan(
                                  text: " ${elements[i]["phn"]}",
                                  style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.TextSpan(
                                  text: "\n${elements[i]["pgm"]}",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold)),
                            ]))),
                  ),
                  pw.Flexible(
                    flex: 6,
                    fit: pw.FlexFit.tight,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                    ),
                  ),
                ],
              ),
            )
            // Viewpgmcard(
            //   name: elements[i]["name"],
            //   address: elements[i]["address"],
            //   loc: elements[i]["loc"],
            //   pgm: elements[i]["pgm"],
            //   phn: elements[i]["phn"],
            //   type: elements[i]["type"],
            //   upDate: elements[i]["upDate"],
            //   upTime: elements[i]["upTime"],
            //   docname: elements[i]["docname"],
            //   prospec: elements[i]["prospec"],
            //   instadate: elements[i]["instadate"],
            // )
          ]
        ],
      ),
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    fileName = fileName + ".pdf";
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(byteList)}")
      ..setAttribute("download", fileName)
      ..click();
  }
}
