import 'package:firstone/menuItemsparts/sort_order.dart';
import 'package:flutter/material.dart';
import '../cont.dart';
import '../data.dart';


class Watchlist extends StatefulWidget {
  final ScrollController scrollController;
  final String searchText;
  final SortOrder sortOrder;
  const Watchlist({
    super.key,
    required this.searchText,
    required this.sortOrder,
    required this.scrollController,
  });

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    late ScrollController scrollController;
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

    List<BankEntry> filteredBankEntry = [];
    for (int i = 0; i < allBanks.length; i++) {
      final bankName = allBanks[i];
      final ltp = double.parse(
        '${900 + i}.${(i * 13 % 100).toString().padLeft(2, '0')}',
      );
      if (filteredBanks.contains(bankName)) {
        filteredBankEntry.add(BankEntry(name: bankName, ltp: ltp, index: i));
      }
    }

    if (widget.sortOrder == SortOrder.ltpAsc) {
      filteredBankEntry.sort((a, b) => a.ltp.compareTo(b.ltp));
    } else if (widget.sortOrder == SortOrder.ltpDesc) {
      filteredBankEntry.sort((a, b) => b.ltp.compareTo(a.ltp));
    }

    return Scaffold(
      body: ListView.builder(
        controller: widget.scrollController,
        padding: EdgeInsets.only(top: 160),
        itemCount: filteredBanks.length,
        itemBuilder: (context, index) {
          final entry = filteredBankEntry[index];
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
              startText: entry.name.length > 10
                  ? '${entry.name.substring(0, 10)}...'
                  : entry.name,
              closeValue: 902.26,
              stockHoldings: index % 3 == 0 ? 10 : 3,
            ),
          );
        },
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
