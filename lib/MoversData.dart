import 'dart:math' as Math;

import 'package:flutter/material.dart';

class MoversData extends StatefulWidget {
  final String? displayName;
  final String? exchange;
  final double? Ltp;
  final double? change;
  final double? perChange;
  final String TypeFlag;
  bool? isLast = false;

   MoversData({
    super.key,
    this.displayName,
    this.exchange,
    this.Ltp,
    this.change,
    this.perChange,
    required this.TypeFlag,
    this.isLast,
  });

  @override
  State<MoversData> createState() => _MoversDataState();
}

class _MoversDataState extends State<MoversData> {
  @override
  Widget build(BuildContext context) {
    double screenWidth= MediaQuery.sizeOf(context).width;
    double screenHeight= MediaQuery.sizeOf(context).height;
    double? percentage= widget.change!/widget.Ltp!;
     String TypeFlag= widget.TypeFlag;
    return Container(
      height: screenHeight*0.098,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(10,6,10,widget.isLast! ? 150 : 6),
      padding:EdgeInsets.all(8) ,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.displayName!,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
              Text(widget.Ltp!.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ]
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.exchange!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black.withOpacity(0.7)),),
                Row(
                  children: [
                    Text(widget.change!.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: TypeFlag=="G"?Colors.green:Colors.red),),
                    SizedBox(width: 1,),
                    Text('(${widget.perChange!.toStringAsFixed(2)}%)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: TypeFlag=="G"?Colors.green:Colors.red),),
                    SizedBox(width: 1,),
                    Transform.rotate(
                        angle: TypeFlag=="G"?Math.pi/4:3*Math.pi/4,
                        child: Icon(Icons.arrow_upward_outlined,color: TypeFlag=="G"?Colors.green:Colors.red,size: 15,))

                  ],
                )
                 ]
          ),


        ]
      ),
    );
  }
}
