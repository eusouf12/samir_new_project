// import 'dart:typed_data';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:http/http.dart' as http;
//
// class PdfService {
//   //capitalize first letter
//   static String _capitalizeWords(String text) {
//     if (text.isEmpty) return text;
//     return text
//         .split(' ')
//         .map((word) =>
//     word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : word)
//         .join(' ');
//   }
//
//   //Generates the PDF document formatted like SingleView
//   static Future<Uint8List> generateOcrPdf({
//     required String displayImageUrl,
//     required String title,
//     required Map<String, String> dataMap,
//   }) async {
//     final pdf = pw.Document();
//     final capitalizedTitle = _capitalizeWords(title);
//
//     pw.MemoryImage? pdfImage;
//     try {
//       if (displayImageUrl.isNotEmpty) {
//         final response = await http.get(Uri.parse(displayImageUrl));
//         if (response.statusCode == 200) {
//           pdfImage = pw.MemoryImage(response.bodyBytes);
//         } else {
//           print("Failed to download image. Status: ${response.statusCode}");
//         }
//       }
//     } catch (e) {
//       print("Error loading image for PDF: $e");
//     }
//
//     // 2. === Build the PDF Page Layout ===
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Title Header
//               pw.Center(
//                 child: pw.Text(
//                   capitalizedTitle,
//                   style: pw.TextStyle(
//                     fontSize: 22,
//                     fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.blueGrey900,
//                   ),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//
//               // Image Section (Visual representation)
//               if (pdfImage != null)
//                 pw.Container(
//                   height: 250,
//                   width: double.infinity,
//                   decoration: pw.BoxDecoration(
//                     borderRadius: pw.BorderRadius.circular(12),
//                     border: pw.Border.all(color: PdfColors.grey300),
//                     image: pw.DecorationImage(
//                       image: pdfImage,
//                       fit: pw.BoxFit.cover,
//                     ),
//                   ),
//                 )
//               else
//                 pw.Container(
//                   height: 100,
//                   width: double.infinity,
//                   alignment: pw.Alignment.center,
//                   decoration: pw.BoxDecoration(
//                     borderRadius: pw.BorderRadius.circular(12),
//                     border: pw.Border.all(color: PdfColors.grey300),
//                     color: PdfColors.grey100,
//                   ),
//                   child: pw.Text("Image could not be loaded",
//                       style: const pw.TextStyle(color: PdfColors.grey700)),
//                 ),
//
//               pw.SizedBox(height: 25),
//               pw.Divider(color: PdfColors.grey300),
//               pw.SizedBox(height: 15),
//
//               // Data Section (Key : Value list from OCR)
//               if (dataMap.isEmpty)
//                 pw.Center(
//                   child: pw.Text("No extracted text data found.",
//                       style: const pw.TextStyle(color: PdfColors.grey600)),
//                 )
//               else
//                 ...dataMap.entries.map((e) {
//                   return pw.Padding(
//                     padding: const pw.EdgeInsets.only(bottom: 8),
//                     child: pw.Row(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         // Key
//                         pw.Container(
//                           width: 140,
//                           child: pw.Text(
//                             "${_capitalizeWords(e.key)}:",
//                             style: pw.TextStyle(
//                               fontSize: 12,
//                               fontWeight: pw.FontWeight.bold,
//                               color: PdfColors.black,
//                             ),
//                           ),
//                         ),
//                         // Value
//                         pw.Expanded(
//                           child: pw.Text(
//                             _capitalizeWords(e.value),
//                             style: const pw.TextStyle(
//                               fontSize: 12,
//                               color: PdfColors.grey800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//
//               // Footer
//               pw.Spacer(),
//               pw.Divider(color: PdfColors.grey300),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text("Generated by ICE Verify Digital ID",
//                       style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey)),
//                   pw.Text(
//                     DateTime.now().toString().substring(0, 16),
//                     style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//
//     return pdf.save();
//   }
// }