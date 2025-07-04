import 'dart:ui';
import 'package:flutter/material.dart';
import 'Searchbarnew.dart';

class BlurMaker extends StatefulWidget {
  late FocusNode focusNode;
  late TextEditingController controller;
  final void Function(String) onChanged;
  final TabController tabController;

   BlurMaker({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onChanged, required this.tabController,
  });

  @override
  State<BlurMaker> createState() => _BlurMakerState();
}

class _BlurMakerState extends State<BlurMaker> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.focusNode=FocusNode();
    widget.controller=TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.focusNode.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.controller.text.isNotEmpty) {
          widget.controller.clear();
          //focusNode.unfocus();
          widget.onChanged('');
          return false;
        }
        return true;
      },
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: SizedBox(
              height: 130,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            widget.focusNode.unfocus();
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 0,
                                  spreadRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFF016124),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TabBar(
                          controller: widget.tabController,
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.only(left: 8),
                          labelPadding: const EdgeInsets.only(right: 15),
                          labelColor: Colors.black,
                          indicatorColor: const Color(0xFF016124),
                          dividerColor: Colors.transparent,
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          tabs: const [
                            Tab(child: Text("WatchList", style: TextStyle(fontSize: 17))),
                            Tab(child: Text("Movers", style: TextStyle(fontSize: 17))),
                            Tab(child: Text("CA", style: TextStyle(fontSize: 17))),
                            Tab(child: Text("Crypto", style: TextStyle(fontSize: 17))),
                            Tab(child: Text("News", style: TextStyle(fontSize: 17))),
                            Tab(child: Text("Markets", style: TextStyle(fontSize: 17))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Searchbarnew(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
            ),
          ),
        ),
      ),
    );
  }
}
