// import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PDFViewerPage extends StatefulWidget {
//   String? stringUrl;
//   PDFViewerPage(this.stringUrl);
//   // const PDFViewerPage({Key? key, this.stringUrl}) : super(key: key);

//   @override
//   State<PDFViewerPage> createState() => _PDFViewerPageState();
// }

// class _PDFViewerPageState extends State<PDFViewerPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Viewer PDF",
//           style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
//         ),
//         actions: [
//           InkWell(
//             onTap: _launchURL,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Icon(
//                 Icons.picture_as_pdf,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//           // 'http://www.pdf995.com/samples/pdf.pdf'
//           child: SfPdfViewer.network(widget.stringUrl.toString() ?? "")),
//     );
//   }

//   _launchURL() async {
//     final Uri url = Uri.parse('${widget.stringUrl.toString()}');
//     if (!await launchUrl(url)) {
//       throw Exception('Could not launch ${widget.stringUrl.toString()}');
//     }
//   }
// }
