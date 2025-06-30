import 'dart:async';
import 'package:flutter/material.dart';

class FilterOnScrollExample extends StatefulWidget {
  @override
  _FilterOnScrollExampleState createState() => _FilterOnScrollExampleState();
}

class _FilterOnScrollExampleState extends State<FilterOnScrollExample> {
  double _opacity = 0.0;
  Timer? _timer;
  bool isAscending = true;

  List<String> items = List.generate(50, (index) => "Item $index");

  void _handleScroll() {
    setState(() {
      _opacity = 1.0;
    });

    _timer?.cancel();
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  void _toggleSortDirection() {
    setState(() {
      isAscending = !isAscending;
      _sortItems();
    });
  }

  void _sortItems() {
    items.sort((a, b) {
      int aIndex = int.parse(a.split(" ").last);
      int bIndex = int.parse(b.split(" ").last);
      return isAscending ? aIndex.compareTo(bIndex) : bIndex.compareTo(aIndex);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          _handleScroll();
          return false;
        },
        child: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(items[index]),
              ),
            ),

            // Bottom-left Sort Button
            Positioned(
              bottom: 30,
              left: 20,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 400),
                child: GestureDetector(
                  onTap: _toggleSortDirection,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sort",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
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
}
