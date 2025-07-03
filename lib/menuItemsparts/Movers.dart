import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';
import 'package:firstone/MoversData.dart';
import 'package:firstone/menuItemsparts/sort_order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movers extends StatefulWidget {
  final String moversSearchText;

  const Movers({
    super.key,
    required this.moversSearchText,

  });

  @override
  State<Movers> createState() => _MoversState();
}

class _MoversState extends State<Movers> {

  Timer? _scrollTimer;
  ScrollController scrollController= ScrollController();
  bool isVisible = false;
  PageController pageController = PageController();
  StreamController moverController = StreamController();
  List<dynamic> movers = [];
  bool isLoading = true;
  int selectedPageIndex = 0;
  bool isFullyScrolled= false;
  String mainDispName="NSE";
  int LTP=0;
  String mainName= "";
  List<int> ltpList=[];
  List<String> nameList=[];
  SortOrder ltpSortOrder = SortOrder.none;
  NameSort nameSort = NameSort.none;


  void cycleNameSort(){
    setState(() {
      switch(nameSort){
        case NameSort.none:
          nameSort=NameSort.AtoZ;
          break;

        case NameSort.AtoZ:
          nameSort= NameSort.ZtoA;
          break;

        case NameSort.ZtoA:
          nameSort= NameSort.AtoZ;
      }
      ltpSortOrder= SortOrder.none;
      isVisible = true;
    });

    _scrollTimer= Timer(Duration(seconds: 2), (){
      setState(() {
        isVisible = false;
      });
    });
  }

  void cycleSortOrder() {
    setState(() {
      switch (ltpSortOrder) {
        case SortOrder.none:
          ltpSortOrder = SortOrder.ltpAsc;
          break;
        case SortOrder.ltpAsc:
          ltpSortOrder = SortOrder.ltpDesc;
          break;
        case SortOrder.ltpDesc:
          ltpSortOrder = SortOrder.ltpAsc;
          break;
      }
      isVisible = true;
      nameSort=NameSort.none;
    });
    _scrollTimer?.cancel();
    _scrollTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  Widget SortNameIcon() {
    IconData myicon = Icons.arrow_back_ios_new_sharp;
    switch (nameSort) {
      case NameSort.AtoZ:
        return Transform.rotate(
            angle: math.pi/2,
            child: Icon(myicon,color: Colors.black)
        );
      case NameSort.ZtoA:
        return Transform.rotate(
            angle: -math.pi/2,
            child: Icon(myicon,color: Colors.black));
      case NameSort.none:
        return Icon(null, color: Colors.black);
    }
  }

  Widget SortIcon() {
    IconData myicon = Icons.arrow_back_ios_new_sharp;
    switch (ltpSortOrder) {
      case SortOrder.ltpAsc:
        return Transform.rotate(
            angle: math.pi/2,
            child: Icon(myicon,color: Colors.black)
        );
      case SortOrder.ltpDesc:
        return Transform.rotate(
            angle: -math.pi/2,
            child: Icon(myicon,color: Colors.black));
      case SortOrder.none:
        return Icon(null, color: Colors.black);
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovers("G");
    scrollController.addListener((){
      if(isVisible == false){
        setState(() {
          isVisible=true;
        });
      }
      _scrollTimer=Timer(Duration(seconds: 3), (){
        setState(() {
          isVisible=false;
        });
      });
     }
    );
    
  }
  
  
  _getMovers(String typeFlag) async {
    HashMap map2 = HashMap();

    ///Required parameter ka map bnaya hai
    HashMap map = HashMap();
    map["ExpCode"] = -1;
    map["SecIdxCode"] = 13;
    map["TypeFlag"] = typeFlag;
    map["Instrument"] = "EQUITY";
    map["DayLevelIndicator"] = 1;
    map["Seg"] = 1;
    map["Count"] = 100;
    map["xyz"] = 1;

    ///Map 2 ke data key ke against upar wale required parameters ka map bhara
    map2["data"] = map;
    String url = 'https://scanx.dhan.co/scanx/daygnl';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {},
        body: jsonEncode(map2),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        movers = decoded['data'] ?? [];
        isLoading = false;
        moverController.add(movers);
        //
      } else {
        print("error: ${response.statusCode}");
        moverController.add([]);
      }
    } catch (e) {
      print("Exception: $e");
      moverController.add([]);
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;


    return Stack(
      children: [
        StreamBuilder(
          stream: moverController.stream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              List<dynamic> allMovers=asyncSnapshot.data;
              List <dynamic> filteredMovers=[];
              if(widget.moversSearchText.isEmpty){
                filteredMovers=movers;
              }else{
                for(var item in allMovers){
                  final dispName= (item["exch"]??'').toString();
                  mainDispName=dispName;
                  final int ltp = item["ltp"]??'';
                  LTP=ltp;
                  ltpList.add(LTP);
                  final name = (item['disp']??'').toString().toLowerCase();
                  mainName= name;
                  nameList.add(mainName);
                  if(name.contains(widget.moversSearchText.toLowerCase())){
                    filteredMovers.add(MoversEntry(name: name, ltp: ltp));
                  }
                }
              }

              if(nameSort!= NameSort.none){
                if(nameSort == NameSort.AtoZ){
                  filteredMovers.sort((a,b)=>a['disp'].compareTo(b['disp']));
                }else if(nameSort==NameSort.ZtoA){
                  filteredMovers.sort((a,b)=>b['disp'].compareTo(a['disp']));
                }
              }

              if(ltpSortOrder!=SortOrder.none){
                if(ltpSortOrder==SortOrder.ltpAsc){
                  filteredMovers.sort((a,b) => a['ltp'].compareTo(b['ltp']));
                }else if(ltpSortOrder==SortOrder.ltpDesc){
                  filteredMovers.sort((a,b) =>b['ltp'].compareTo(a['ltp']));
                }
              }

              return PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: 2,
                itemBuilder: (context, pageindex) {
                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: (){
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(LTP.toString(),style: TextStyle(color: Colors.blueGrey,fontSize: 14,fontWeight: FontWeight.w400),
                      ),
                    ),
                  //  floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
                    backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
                    body: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Stack(
                      children: [ListView.builder(
                            controller: scrollController,
                              padding: const EdgeInsets.only(top: 220),
                              itemCount: filteredMovers.length,
                              itemBuilder: (context, index) {
                                final item = filteredMovers[index];
                                bool isLast = index >= filteredMovers.length-1;
                                  return MoversData(
                                    isLast: isLast,
                                    TypeFlag: selectedPageIndex == 0 ? 'G' : 'L',
                                    displayName: item['disp'],
                                    exchange: item['exch'],
                                    Ltp: (item['ltp'] as num).toDouble(),
                                    change: (item['chng'] as num).toDouble(),
                                    perChange: (item['pchng'] as num).toDouble(),
                                  );
                          
                              },
                            ),

                        AnimatedOpacity(
                          opacity: isVisible==true?1.0:0.0,
                          duration: Duration(milliseconds: 300),
                          child: Align(
                            alignment:Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20,20,20,50),
                              child: Row(
                                children:[
                                  ElevatedButton.icon(
                                    onPressed: cycleSortOrder,
                                    label: Text(ltpSortOrder==SortOrder.none
                                        ?'LTP'
                                        :ltpSortOrder==SortOrder.ltpAsc?'LTP':'LTP'),
                                  icon: SortIcon(),
                                ),
                                  SizedBox(width: 10,),
                          
                                  ElevatedButton.icon(
                                    onPressed: cycleNameSort,
                                    label: Text(nameSort==NameSort.none
                                        ?'Name'
                                        :nameSort==NameSort.AtoZ?'A to Z':'Z to A'),
                                    icon: SortNameIcon(),
                                  ),
                               ]
                              ),
                            )
                           ),
                        )
                        ]
                       ),
                  );
                },
              );
            }
            else {
              return SizedBox(
                width: screenHeight,
                height: screenHeight,
                child: Container(color: Color.fromRGBO(220, 220, 220, 1.0),),
              );
            }
          },
        ),

        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.white.withOpacity(0.1), height: 162),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(top: 160),
          color: Color.fromRGBO(220, 220, 220, 1.0),
          height: 60,
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (selectedPageIndex != 0) {
                      setState(() {
                        selectedPageIndex = 0;
                        _getMovers("G");
                      });
                      pageController.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      //fetchMovers();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    height: selectedPageIndex == 0
                        ? screenHeight * 0.05
                        : screenHeight * 0.04,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: selectedPageIndex == 0
                          ? Colors.white
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: selectedPageIndex == 0 ? 0.8 : 0.5,
                        color: selectedPageIndex == 0
                            ? Colors.green
                            : Colors.black.withOpacity(0.8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Top Gainers",
                        style: TextStyle(
                          fontWeight: selectedPageIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedPageIndex == 0
                              ? Colors.green
                              : Colors.black,
                          fontSize: selectedPageIndex == 0 ? 16 : 13,
                        ),
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    if (selectedPageIndex != 1) {
                      setState(() {
                        selectedPageIndex = 1;
                        _getMovers("L");
                        //body['data']['TypeFlag'] = 'L';
                        //isLoading = true;
                      });
                      pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      //fetchMovers();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    height: selectedPageIndex == 1
                        ? screenHeight * 0.05
                        : screenHeight * 0.04,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: selectedPageIndex == 1
                          ? Colors.white
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: selectedPageIndex == 1 ? 0.8 : 0.5,
                        color: selectedPageIndex == 1
                            ? Colors.green
                            : Colors.black.withOpacity(0.8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Top Losers",
                        style: TextStyle(
                          fontWeight: selectedPageIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedPageIndex == 1
                              ? Colors.green
                              : Colors.black,
                          fontSize: selectedPageIndex == 1 ? 16 : 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class MoversEntry {
  final String name;
  final int ltp;
  MoversEntry({required this.name, required this.ltp});
}

