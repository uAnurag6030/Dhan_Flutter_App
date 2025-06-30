import 'package:flutter/material.dart';

class BankData extends StatefulWidget {
  final int clickindex;
  final String Exchange;
  final String myHoldings;
  final String bankName;
  final double Ltp;
  final double stockCondition;
  final double MyWallet;


  const BankData({
    super.key,
    required this.clickindex,
    required this.myHoldings,
    required this.Exchange,
    required this.bankName,
    required this.Ltp, required this.stockCondition, required this.MyWallet,
  });

  @override
  State<BankData> createState() => _BankDataState();
}

class _BankDataState extends State<BankData> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Detail Page"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.5),
          ),
          height: 300,
          width: 300,
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 2,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Exchange", style: TextStyle(fontSize: 20)),
                    Text(widget.Exchange, style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),

              Container(
                color: Colors.black.withOpacity(0.5),
                height: 2,
                width: screenWidth * 0.75,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 2,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bank Name", style: TextStyle(fontSize: 20)),
                    Text(widget.bankName.length>8?widget.bankName.substring(0,11)+'...':widget.bankName, style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),

              Container(
                color: Colors.black.withOpacity(0.5),
                height: 2,
                width: screenWidth * 0.75,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 2,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Holdings", style: TextStyle(fontSize: 20)),
                    Text(widget.myHoldings, style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),

              Container(
                color: Colors.black.withOpacity(0.5),
                height: 2,
                width: screenWidth * 0.75,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 2,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("LTP", style: TextStyle(fontSize: 20)),
                    Text(
                      widget.Ltp.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.black.withOpacity(0.5),
                height: 2,
                width: screenWidth * 0.75,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 2,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Stock Condition", style: TextStyle(fontSize: 20)),
                    Text(
                      widget.stockCondition.toStringAsFixed(2),
                      style: TextStyle(fontSize: 20,
                      color: widget.stockCondition>=0?Colors.green:Colors.red,),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.black.withOpacity(0.5),
                height: 2,
                width: screenWidth * 0.75,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Wallet", style: TextStyle(fontSize: 20)),
                    Text(
                      widget.MyWallet.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20,
                        color: widget.MyWallet >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
