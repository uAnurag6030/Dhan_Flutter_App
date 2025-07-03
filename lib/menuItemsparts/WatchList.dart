import 'dart:async';
import 'dart:math' as math;

import 'package:firstone/menuItemsparts/sort_order.dart';
import 'package:flutter/material.dart';
import '../cont.dart';
import '../data.dart';


class Watchlist extends StatefulWidget {
  final String searchText;

  const Watchlist({
    super.key,
    required this.searchText,
  });

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
   bool showSortButton = false;
   SortOrder sortOrder = SortOrder.none;
   NameSort nameSort = NameSort.none;
   ScrollController scrollController = ScrollController();
   Timer? _scrollTimer;

  void cycleNameSort(){
    setState(() {
      switch(nameSort){
        case NameSort.none:
          nameSort = NameSort.AtoZ;
          break;

        case NameSort.AtoZ:
          nameSort = NameSort.ZtoA;
          break;

        case NameSort.ZtoA:
          nameSort = NameSort.AtoZ;
      }
      sortOrder=SortOrder.none;
      showSortButton= true;
    });
    _scrollTimer= Timer(Duration(seconds: 2), (){
      setState(() {
        showSortButton= false;
      });
    });
  }

  void cycleSortOrder() {
    setState(() {
      switch (sortOrder) {
        case SortOrder.none:
          sortOrder = SortOrder.ltpAsc;
          break;
        case SortOrder.ltpAsc:
          sortOrder = SortOrder.ltpDesc;
          break;
        case SortOrder.ltpDesc:
          sortOrder = SortOrder.ltpAsc;
          break;
      }
      showSortButton = true;
      nameSort=NameSort.none;
    });
    _scrollTimer?.cancel();
    _scrollTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        showSortButton = false;
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
    switch (sortOrder) {
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
    // TODO: implement initState
    super.initState();
    scrollController.addListener((){
      if(showSortButton==false){
        setState(() {
          showSortButton=true;
        });
      }
      _scrollTimer = Timer(Duration(seconds: 3), (){
        setState(() {
          showSortButton=false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> allBanks = [
      'SBI',
      'HDFC',
      'ICICI',
      'AXIS',
      'KOTAK',
      'PNB',
      'BOB',
      'CANARA',
      'UNION',
      'IDBI',
      'IDFC FIRST',
      'YES BANK',
      'INDUSIND',
      'AU SFB',
      'UCO',
      'INDIAN BANK',
      'CENTRAL BANK',
      'BANK OF MAHARASHTRA',
      'SOUTH INDIAN',
      'KARNATAKA BANK',
      'DCB',
      'RBL',
      'J&K BANK',
      'FEDERAL',
      'BANDHAN',
      'KARUR VYSYA',
      'TMB',
      'CITY UNION',
      'DENA',
      'VIJAYA',
      'CORPORATION BANK',
      'ANDHRA BANK',
      'SYNDICATE',
      'ALLAHABAD',
      'ORIENTAL BANK',
      'LAKSHMI VILAS',
      'NAINITAL BANK',
      'SARASWAT CO-OP',
      'SVC CO-OP',
      'TJSB',
      'NKGSB CO-OP',
      'APNA SAHAKARI',
      'ABHYUDAYA BANK',
      'MAHARASHTRA GRAMIN',
      'VIDARBHA KONKAN GRAMIN',
      'PRAGATHI KRISHNA GRAMIN',
      'BARODA RAJASTHAN KSHETRIYA',
      'BARODA UP BANK',
      'BARODA GUJARAT GRAMIN',
      'UTKAL GRAMIN BANK',
      'KASHI GOMTI SAMYUT',
      'PURVANCHAL BANK',
      'ARYAVART BANK',
      'MALWA GRAMIN',
      'PUDUVAI BHARATHIAR',
      'MEGHALAYA RURAL BANK',
      'TRIPURA GRAMIN',
      'ASSAM GRAMIN',
      'MANIPUR RURAL',
      'MIZORAM RURAL',
      'NAGALAND RURAL BANK',
      'ARUNACHAL PRADESH RURAL',
      'SIKKIM CO-OP',
      'GOA STATE CO-OP',
      'DELHI STATE CO-OP',
      'RAJASTHAN STATE CO-OP',
      'GUJARAT STATE CO-OP',
      'HIMACHAL PRADESH CO-OP',
      'UTTARAKHAND STATE CO-OP',
      'BIHAR STATE CO-OP',
      'JHARKHAND STATE CO-OP',
      'CHHATTISGARH RAJYA GRAMIN',
      'ODISHA STATE CO-OP',
      'TELANGANA GRAMEENA',
      'AP GRAMEENA VIKAS',
      'MAHARASHTRA STATE CO-OP',
      'PUNJAB STATE CO-OP',
      'TAMILNADU MERCANTILE CO-OP',
      'WB STATE CO-OP',
      'KERALA STATE CO-OP',
      'PUNE JANATA SAHAKARI',
      'AHMEDABAD MERCANTILE CO-OP',
      'KALUPUR COMMERCIAL CO-OP',
      'RAJKOT NAGRIK SAHAKARI',
      'NAGPUR NAGRIK',
      'VASAI VIKAS SAHAKARI',
      'JANATA SAHAKARI PUNE',
      'MODEL CO-OP',
      'BHARAT CO-OP',
      'RATNAKAR BANK',
      'SHIVALIK SMALL FINANCE',
      'ESAF SMALL FINANCE',
      'JANA SMALL FINANCE',
      'UJJIVAN SMALL FINANCE',
      'SURYODAY SMALL FINANCE',
      'EQUITAS SMALL FINANCE',
      'NORTH EAST SMALL FINANCE',
      'CAPITAL SMALL FINANCE',
      'FINCARE SMALL FINANCE',
      'UNITY SMALL FINANCE',
    ];

    List<String> filteredBanks = [];

    if (widget.searchText.isEmpty) {
      filteredBanks = allBanks;
    } else {
      for (String bank in allBanks) {
        if (bank.toLowerCase().contains(widget.searchText.toLowerCase())) {
          filteredBanks.add(bank);
        }
      }
    }

    List<BankEntry>nameFilteredBank=[];
    for(int i=0;i<allBanks.length;i++){
      final nameSortedBank = allBanks[i];
      final ltp = double.parse(
          '${900 + i}.${(i * 13 % 100).toString().padLeft(2, '0')}',);
      if(filteredBanks.contains(nameSortedBank)){
        nameFilteredBank.add(BankEntry(name: nameSortedBank, ltp: ltp, index: i));
      }
    }

    // List<BankEntry> filteredBankEntry = [];
    // for (int i = 0; i < allBanks.length; i++) {
    //   final bankName = allBanks[i];
    //   final ltp = double.parse(
    //     '${900 + i}.${(i * 13 % 100).toString().padLeft(2, '0')}',
    //   );
    //   if (filteredBanks.contains(bankName)) {
    //     filteredBankEntry.add(BankEntry(name: bankName, ltp: ltp, index: i));
    //   }
    // }

if(nameSort!= NameSort.none){
    if(nameSort == NameSort.AtoZ){
      nameFilteredBank.sort((a,b)=>a.name.compareTo(b.name));
    }else if(nameSort==NameSort.ZtoA){
      nameFilteredBank.sort((a,b)=>b.name.compareTo(a.name));
    }
}

if(sortOrder!=SortOrder.none){
    if (sortOrder == SortOrder.ltpAsc) {
      nameFilteredBank.sort((a, b) => a.ltp.compareTo(b.ltp));
    } else if (sortOrder == SortOrder.ltpDesc) {
      nameFilteredBank.sort((a, b) => b.ltp.compareTo(a.ltp));
    }
}

    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      body:  Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(top: 165),
            itemCount: filteredBanks.length,
            itemBuilder: (context, index) {
              final entry = nameFilteredBank[index];
              final i = entry.index;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BankData(
                        Ltp: entry.ltp,
                        bankName: entry.name,
                        myHoldings: '${index % 3 == 0 ? 10 : 3}',
                        clickindex: index,
                        Exchange: index % 2 == 0 ? 'NSE' : 'BSE',

                        stockCondition: entry.ltp - 902.26,

                        MyWallet:
                            entry.ltp * (i % 3 == 0 ? 10 : 3) -
                            (i % 3 == 0 ? 10 : 3) *
                                (i % 3 == 0
                                    ? 700 + i % 5
                                    : i % 3 == 1
                                    ? 0
                                    : 1000 + i % 12),
                      ),
                    ),
                  );
                },
                child: MyContain(
                  holdingBank: (i % 2 == 0 ? 'NSE' : 'BSE'),
                  buyingPrice: i % 3 == 0
                      ? 700 + i % 5
                      : i % 3 == 1
                      ? 0
                      : 1000 + i % 12,
                  ltp: entry.ltp,
                  startText: entry.name.length > 8
                      ? '${entry.name.substring(0,8)}...'
                      : entry.name,
                  closeValue: 902.26,
                  stockHoldings: index % 3 == 0 ? 10 : 3,
                ),
              );
            },
          ),

      Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(28,0,20,50),
          child: Row(
              children:[ AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: showSortButton ? 1.0 : 0.0,
                child:
                ElevatedButton.icon(
                  onPressed: cycleNameSort,
                  icon: SortNameIcon(),
                  label: Text(nameSort==NameSort.none?'Name':nameSort==NameSort.AtoZ?'A to Z':'Z to A', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    backgroundColor: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
                SizedBox(width: 10,),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: showSortButton ? 1.0 : 0.0,
                  child:
                  ElevatedButton.icon(
                    onPressed: cycleSortOrder,
                    icon: SortIcon(),
                    label: Text('LTP', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),

              ]
          ),
        ),
      ),
     ]
    ),

    );
  }
}

class BankEntry {
  final String name;
  final double ltp;
  final int index;
  BankEntry({required this.name, required this.ltp, required this.index});
}
