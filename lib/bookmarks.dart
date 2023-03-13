import 'package:any_link_preview/any_link_preview.dart';
import 'package:browser_app/model/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Mark", style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: Global.bookMark
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnyLinkPreview(
                      link: e,
                      displayDirection: UIDirection.uiDirectionHorizontal,
                      showMultimedia: false,
                      bodyMaxLines: 5,
                      bodyTextOverflow: TextOverflow.ellipsis,
                      titleStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      bodyStyle:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
