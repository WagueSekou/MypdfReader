import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {

  late PdfControllerPinch pdfControllerPinch;
  int totalPageCount = 0, currenntPage = 1; 

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(document: PdfDocument.openAsset('assets/pdfs/PDF_SE3B.pdf'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("PDF Viuew", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
        ),
        backgroundColor: Colors.purple[200],
      ),
        body: _buidUI(),
    );
  }


Widget _buidUI(){
  return Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total Pages: ${totalPageCount}"),

          IconButton(
            onPressed: (){
              pdfControllerPinch.previousPage(
                duration: Duration(microseconds: 200), 
                curve: Curves.linear);
            }, 
            icon: Icon(Icons.arrow_back)),

          Text("Current Page: ${currenntPage}"),

          IconButton(
            onPressed: (){
              pdfControllerPinch.nextPage(
                duration: Duration(microseconds: 200), 
                curve: Curves.linear);
            }, 
            icon: Icon(Icons.arrow_forward)),
        ],
      ),
      _pdfView(),
    ],
  );
}


Widget _pdfView(){
  return Expanded(
    child: PdfViewPinch(
      scrollDirection: Axis.vertical,
      controller: pdfControllerPinch,
      onDocumentLoaded: (document) {
        setState(() {
          totalPageCount = document.pagesCount;
        });
      },
      onPageChanged: (page) {
        setState(() {
          currenntPage = page;
        });
      },
      ),
    );
}
}