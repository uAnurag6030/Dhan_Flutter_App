import 'package:flutter/material.dart';

class MyContain extends StatelessWidget {
  final double? ltp;
  final String? startText;
  final double? closeValue;
  final String? holdingBank;
  final double? buyingPrice;
  final int? stockHoldings;

  const MyContain({
    super.key,
    this.ltp,
    this.closeValue,
    this.holdingBank,
    this.buyingPrice, this.startText, this.stockHoldings,
  });

  @override
  Widget build(BuildContext context) {
    String? endText = "";
    String? endText2 = "";
    String? endText3 = "";
    int?  myValue = (buyingPrice!.toInt()*stockHoldings!);
    double? myProfit =(ltp!*stockHoldings!)- myValue.toDouble();

     String? startText2=holdingBank;
     String? startText3=buyingPrice!.toStringAsFixed(1);
    double difference = ltp! - closeValue!;
    double percentage = (difference.abs() / closeValue!) * 100;
    return ClipRect(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1.0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (startText != null)
                  Text(
                    startText!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 4),
                if (startText2 != null)
                  Row(
                    children: [
                      if (startText2 != null)
                        Text(
                          startText2,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),

                      if (startText2 != '' && startText3 == '0.0')
                        Container(width: 20,color: Colors.red,),

                      if (startText2 != "" && startText3 != "0.0")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.business_center,
                            size: 14,
                            color: Colors.black,
                          ),
                        ),

                      if (startText3 != '0.0')
                        Text(stockHoldings.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      if (startText3 != '0.0')
                        Text(
                          ' x ${buyingPrice!.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),

                    ],
                  ),
                const SizedBox(height: 4),
                Text(myProfit>=0
                  ?'My profit is : ₹ ${myProfit.toStringAsFixed(2)}'
                  :'My loss is : ₹ ${myProfit.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: myProfit>=0?Colors.green:Colors.red
                  ),
                )

              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ltp.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      difference.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: difference >= 0 ? Colors.green : Colors.red,
                      ),
                    ),

                    Text(
                      "(${percentage.toStringAsFixed(2)}%)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: difference < 0 ? Colors.red : Colors.green,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Icon(
                        difference >= 0
                            ? Icons.trending_up
                            : Icons.trending_down,
                        size: 15,
                        color: difference >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
