// import 'package:flutter/material.dart';
// import 'web_view_container.dart';

// class Home extends StatelessWidget {
//   final _links = ['https://strikemakercron.cmeta.de/'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewContainer("https://strikemakercron.cmeta.de/"),
//     );
//   }

//   Widget _urlButton(BuildContext context, String url) {
//     return Container(
//         padding: EdgeInsets.all(20.0),
//         child: FlatButton(
//           color: Theme.of(context).primaryColor,
//           padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
//           child: Text(url),
//           onPressed: () => _handleURLButtonPress(context, url),
//         ));
//   }

//   void _handleURLButtonPress(BuildContext context, String url) {
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => WebViewContainer(url)));
//   }
// }

import 'package:flutter/material.dart';
import 'package:strikemaker/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _key = UniqueKey();
  bool _isLoadingPage = true;
  WebViewController? controller;
  int _selectedIndex = 0;

  List<String> arr_links = [
    'https://strikemakercron.cmeta.de/',
    'https://strikemakercron.cmeta.de/produkte/',
    'https://strikemakercron.cmeta.de/warenkorb/',
    'https://strikemakercron.cmeta.de/kontakt/',
  ];

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: WebView(
              key: _key,
              initialUrl: arr_links[_selectedIndex],
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controller = webViewController;
              },
              onPageStarted: (finish) {
                setState(() {
                  _isLoadingPage = false;
                });
              },
              onPageFinished: (finish) {
                setState(() {
                  _isLoadingPage = false;
                });
              },
            ),
          ),
          _isLoadingPage
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.black.withOpacity(
                      0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
                )
              : Stack()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: whiteColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: appColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // icon: Image.asset('assets/Home.png'),
            icon: ImageIcon(
              AssetImage("assets/Home.png"),
              // color: Color(0xFF3A5A98),
            ),

            label: "",
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/product.png"),
                // color: Color(0xFF3A5A98),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/cart.png"),
                // color: Color(0xFF3A5A98),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/contact.png"),
                // color: Color(0xFF3A5A98),
              ),
              label: ""),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isLoadingPage = true;
      controller!.loadUrl(arr_links[_selectedIndex]);
    });
  }
}
