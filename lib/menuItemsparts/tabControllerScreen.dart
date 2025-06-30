import 'dart:async';
import 'dart:ui';
import 'package:firstone/blurmaker.dart';
import 'package:firstone/menuItemsparts/CA.dart';
import 'package:firstone/menuItemsparts/Crypto.dart';
import 'package:firstone/menuItemsparts/Markets.dart';
import 'package:firstone/menuItemsparts/Movers.dart';
import 'package:firstone/menuItemsparts/News.dart';
import 'package:firstone/menuItemsparts/WatchList.dart';
import 'package:firstone/menuItemsparts/sort_order.dart';
import 'package:flutter/material.dart';

class Tabcontrollerscreen extends StatefulWidget {
  const Tabcontrollerscreen({super.key});

  @override
  State<Tabcontrollerscreen> createState() => _TabcontrollerscreenState();
}

class _TabcontrollerscreenState extends State<Tabcontrollerscreen> {
   ScrollController scrollController= ScrollController();
  bool showSortButton = false;
  Timer? _scrollTimer;
  late TabController tabController;
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  String searchText = "";
  SortOrder sortOrder = SortOrder.none;

   void _cycleSortOrder() {
     setState(() {
       switch (sortOrder) {
         case SortOrder.none:
           sortOrder = SortOrder.ltpAsc;
           break;
         case SortOrder.ltpAsc:
           sortOrder = SortOrder.ltpDesc;
           break;
         case SortOrder.ltpDesc:
           sortOrder = SortOrder.none;
           break;
       }
       showSortButton = true;
     });
     _scrollTimer?.cancel();
     _scrollTimer = Timer(Duration(seconds: 2), () {
       setState(() {
         showSortButton = false;
       });
     });
   }


   Icon SortIcon() {
     switch (sortOrder) {
       case SortOrder.ltpAsc:
         return Icon(Icons.arrow_upward, color: Colors.white);
       case SortOrder.ltpDesc:
         return Icon(Icons.arrow_downward, color: Colors.white);
       case SortOrder.none:
       default:
         return Icon(Icons.horizontal_rule_rounded, color: Colors.white);
     }
   }


   @override
  void initState() {
    super.initState();
    //scrollController = ScrollController();

    scrollController.addListener(() {
      if (!showSortButton) {
        setState(() {
          showSortButton = true;
        });
      }

      _scrollTimer?.cancel();
      _scrollTimer = Timer(Duration(seconds: 2), () {
        setState(() {
          showSortButton = false;
        });
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        drawer: Drawer(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF016124),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good Afternoon", style: TextStyle(fontSize: 20)),
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 3, 3, 3),
                          color: Colors.grey.withOpacity(0.5),
                          height: 1,
                          width: screenWidth * 0.4,
                        ),
                        Text(
                          "User",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Builder(
                builder: (BuildContext context) => ListTile(
                  title: const Text('WatchList'),
                  onTap: () {
                    DefaultTabController.of(context).animateTo(0);
                    Navigator.pop(context);
                  },
                ),
              ),
              divider(screenWidth),

              Builder(
                builder: (BuildContext context) => ListTile(
                  title: const Text('News'),
                  onTap: () {
                    DefaultTabController.of(context).animateTo(1);
                    Navigator.pop(context);
                  },
                ),
              ),
              divider(screenWidth),

              Builder(
                builder: (BuildContext context) => ListTile(
                  title: const Text('CA'),
                  onTap: () {
                    DefaultTabController.of(context).animateTo(2);
                    Navigator.pop(context);
                  },
                ),
              ),
              divider(screenWidth),

              Builder(
                builder: (BuildContext context) => ListTile(
                  title: const Text('Crypto'),
                  onTap: () {
                    DefaultTabController.of(context).animateTo(3);
                    Navigator.pop(context);
                  },
                ),
              ),
              divider(screenWidth),

              Builder(
                builder: (BuildContext context) => ListTile(
                  title: const Text('Movers'),
                  onTap: () {
                    DefaultTabController.of(context).animateTo(4);
                    Navigator.pop(context);
                  },
                ),
              ),
              divider(screenWidth),

              Builder(
                builder: (BuildContext context) => ListTile(
                  title: const Text('Markets'),
                  onTap: () {
                    DefaultTabController.of(context).animateTo(5);
                    Navigator.pop(context);
                  },
                ),
              ),
              divider(screenWidth),
            ],
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: BlurMaker(
            focusNode: focusNode,
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      Watchlist(
                        searchText: searchText,
                        sortOrder: sortOrder,
                        scrollController: scrollController,
                      ),
                      const News(),
                      const CA(),
                      const Crypto(),
                      const Movers(),
                      const Markets(),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(28,0,20,28),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: showSortButton ? 1.0 : 0.0,
                  child: ElevatedButton.icon(
                    onPressed: _cycleSortOrder,
                    icon: SortIcon(),
                    label: Text("LTP", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider(double screenWidth) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 3, 3, 3),
      color: Colors.black.withOpacity(0.5),
      height: 1,
      width: screenWidth * 0.1,
    );
  }
}

