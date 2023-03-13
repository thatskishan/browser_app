import 'package:browser_app/bookmarks.dart';
import 'package:browser_app/model/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    routes: {
      '/': (context) => const BrowserApp(),
      'bookmark': (context) => const BookMark(),
    },
  ));
}

class BrowserApp extends StatefulWidget {
  const BrowserApp({Key? key}) : super(key: key);

  @override
  State<BrowserApp> createState() => _BrowserAppState();
}

class _BrowserAppState extends State<BrowserApp> {
  String data = "";
  String myUrl =
      "https://www.google.com/search?q=google&hl=en&sxsrf=AJOqlzWdl2AHzzVxyGWAUozSBYK2nGYe2Q%3A1678524592182&source=hp&ei=sEAMZMC-CNyu2roPy6K9uAs&iflsig=AK50M_UAAAAAZAxOwEOGoJ3Bgjs0fJPP34uC12xskRtA&oq=flu&gs_lcp=Cgdnd3Mtd2l6EAEYADIECCMQJzIECCMQJzIECCMQJzIKCAAQsQMQgwEQQzIECAAQQzIECAAQQzIKCC4QsQMQgwEQQzIECAAQQzIECAAQQzIECAAQQzoHCCMQ6gIQJzoNCC4QxwEQ0QMQ6gIQJzoKCC4QxwEQ0QMQQzoECC4QQ1CDB1inDmCCF2gBcAB4AIABkgGIAakDkgEDMC4zmAEAoAEBsAEK&sclient=gws-wizr";
  bool canGoBack = false;
  bool canGoForward = false;
  String currentUrl = "";
  List history = [];

  double progress = 0;

  late InAppWebViewController myWeb;
  late PullToRefreshController refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myUrl =
        "https://www.google.com/search?q=$data&hl=en&sxsrf=AJOqlzWdl2AHzzVxyGWAUozSBYK2nGYe2Q%3A1678524592182&source=hp&ei=sEAMZMC-CNyu2roPy6K9uAs&iflsig=AK50M_UAAAAAZAxOwEOGoJ3Bgjs0fJPP34uC12xskRtA&oq=flu&gs_lcp=Cgdnd3Mtd2l6EAEYADIECCMQJzIECCMQJzIECCMQJzIKCAAQsQMQgwEQQzIECAAQQzIECAAQQzIKCC4QsQMQgwEQQzIECAAQQzIECAAQQzIECAAQQzoHCCMQ6gIQJzoNCC4QxwEQ0QMQ6gIQJzoKCC4QxwEQ0QMQQzoECC4QQ1CDB1inDmCCF2gBcAB4AIABkgGIAakDkgEDMC4zmAEAoAEBsAEK&sclient=gws-wiz";
    refreshController = PullToRefreshController(
      onRefresh: () {
        setState(() {
          refreshController.endRefreshing();
        });
      },
      options: PullToRefreshOptions(
        enabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return WillPopScope(
      onWillPop: () async {
        if (await myWeb.canGoBack()) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Browser",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  Global.bookMark.contains(currentUrl)
                      ? Global.bookMark.remove(currentUrl)
                      : Global.bookMark.add(currentUrl);
                });
              },
              icon: Icon(
                (Global.bookMark.contains(currentUrl))
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                myWeb.goBack();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: canGoBack ? Colors.blue : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                myWeb.reload();
              },
              icon: const Icon(
                CupertinoIcons.refresh,
              ),
            ),
            IconButton(
              onPressed: () {
                myWeb.goForward();
              },
              icon: Icon(
                CupertinoIcons.forward,
                color: canGoBack ? Colors.blue : Colors.grey,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'bookmark');
                },
                icon: const Icon(Icons.bookmark_add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (v) => setState(() {
                  data = v;
                }),
                onSubmitted: (v) {
                  history.add(data);
                  myUrl =
                      "https://www.google.com/search?q=$data&hl=en&sxsrf=AJOqlzWdl2AHzzVxyGWAUozSBYK2nGYe2Q%3A1678524592182&source=hp&ei=sEAMZMC-CNyu2roPy6K9uAs&iflsig=AK50M_UAAAAAZAxOwEOGoJ3Bgjs0fJPP34uC12xskRtA&oq=flu&gs_lcp=Cgdnd3Mtd2l6EAEYADIECCMQJzIECCMQJzIECCMQJzIKCAAQsQMQgwEQQzIECAAQQzIECAAQQzIKCC4QsQMQgwEQQzIECAAQQzIECAAQQzIECAAQQzoHCCMQ6gIQJzoNCC4QxwEQ0QMQ6gIQJzoKCC4QxwEQ0QMQQzoECC4QQ1CDB1inDmCCF2gBcAB4AIABkgGIAakDkgEDMC4zmAEAoAEBsAEK&sclient=gws-wiz";
                  myWeb.loadUrl(
                    urlRequest: URLRequest(
                      url: Uri.parse(myUrl),
                    ),
                  );
                },
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        history.add(data);
                        myUrl =
                            "https://www.google.com/search?q=$data&hl=en&sxsrf=AJOqlzWdl2AHzzVxyGWAUozSBYK2nGYe2Q%3A1678524592182&source=hp&ei=sEAMZMC-CNyu2roPy6K9uAs&iflsig=AK50M_UAAAAAZAxOwEOGoJ3Bgjs0fJPP34uC12xskRtA&oq=flu&gs_lcp=Cgdnd3Mtd2l6EAEYADIECCMQJzIECCMQJzIECCMQJzIKCAAQsQMQgwEQQzIECAAQQzIECAAQQzIKCC4QsQMQgwEQQzIECAAQQzIECAAQQzIECAAQQzoHCCMQ6gIQJzoNCC4QxwEQ0QMQ6gIQJzoKCC4QxwEQ0QMQQzoECC4QQ1CDB1inDmCCF2gBcAB4AIABkgGIAakDkgEDMC4zmAEAoAEBsAEK&sclient=gws-wiz";
                        myWeb.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse(myUrl),
                          ),
                        );
                      });
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: progress,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: InAppWebView(
                  onWebViewCreated: (con) {
                    myWeb = con;
                  },
                  onProgressChanged: (controller, p) {
                    setState(() {
                      progress = p.toDouble();
                    });
                  },
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(myUrl),
                  ),
                  pullToRefreshController: refreshController,
                  onLoadStart: (con, c) async {
                    Uri? dummy = await myWeb.getUrl();
                    currentUrl = dummy!.scheme;
                    this.currentUrl = c.toString();
                    canGoBack = await myWeb.canGoBack();
                    canGoForward = await myWeb.canGoForward();
                    setState(() {});
                  },
                  onLoadStop: (InAppWebViewController controller, Uri? url) {
                    this.currentUrl = url.toString();
                    refreshController.endRefreshing();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
