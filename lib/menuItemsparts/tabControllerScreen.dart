import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:firstone/blurmaker.dart';
import 'package:firstone/menuItemsparts/CA.dart';
import 'package:firstone/menuItemsparts/Crypto.dart';
import 'package:firstone/menuItemsparts/Markets.dart';
import 'package:firstone/menuItemsparts/News.dart';
import 'package:firstone/menuItemsparts/Movers.dart';
import 'package:firstone/menuItemsparts/WatchList.dart';
import 'package:firstone/menuItemsparts/sort_order.dart';
import 'package:flutter/material.dart';

class Tabcontrollerscreen extends StatefulWidget {
  const Tabcontrollerscreen({super.key});

  @override
  State<Tabcontrollerscreen> createState() => _TabcontrollerscreenState();
}

class _TabcontrollerscreenState extends State<Tabcontrollerscreen>with SingleTickerProviderStateMixin {
  ScrollController scrollController= ScrollController();
  //bool showSortButton = false;
  //Timer? _scrollTimer;
  late TabController _tabController;
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  String searchText = "";
  //SortOrder sortOrder = SortOrder.none;
  //NameSort nameSort = NameSort.none;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);



    _tabController.animation?.addListener(() {
      final currentValue = _tabController.animation!.value;
      if (currentValue != _tabController.index.toDouble()) {

        if(_tabController.index!=currentValue){
          setState(() {
            searchController.clear();
            searchText="";
          });
        }

      }
    });


  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
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
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          searchText="";
                        });
                      },
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
                  setState(() {
                    searchController.clear();
                    searchText="";
                  });
                  _tabController.animateTo(0);
                  Navigator.pop(context);
                },
              ),
            ),
            divider(screenWidth),

            Builder(
              builder: (BuildContext context) => ListTile(
                title: const Text('Movers'),
                onTap: () {
                  _tabController.animateTo(1);
                  Navigator.pop(context);
                },
              ),
            ),
            divider(screenWidth),

            Builder(
              builder: (BuildContext context) => ListTile(
                title: const Text('CA'),
                onTap: () {
                  _tabController.animateTo(2);
                  Navigator.pop(context);
                },
              ),
            ),
            divider(screenWidth),

            Builder(
              builder: (BuildContext context) => ListTile(
                title: const Text('Crypto'),
                onTap: () {
                  _tabController.animateTo(3);
                  Navigator.pop(context);
                },
              ),
            ),
            divider(screenWidth),

            Builder(
              builder: (BuildContext context) => ListTile(
                title: const Text('News'),
                onTap: () {
                  _tabController.animateTo(4);
                  Navigator.pop(context);
                },
              ),
            ),
            divider(screenWidth),

            Builder(
              builder: (BuildContext context) => ListTile(
                title: const Text('Markets'),
                onTap: () {
                  _tabController.animateTo(5);
                  Navigator.pop(context);
                },
              ),
            ),
            divider(screenWidth),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(134),
        child: BlurMaker(
          tabController: _tabController,
          focusNode: focusNode,
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body:
          Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller:_tabController,
                  children: [
                    Watchlist(
                      searchText: searchText,
                    ),
                    Movers(
                      moversSearchText:searchText ,
                    ),
                    const CA(),
                    const Crypto(),
                    const News(),
                    const Markets(),
                  ],
                ),
              ),
            ],
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

