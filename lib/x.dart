// import 'dart:ui';
// import 'package:firstone/Searchbarnew.dart';
// import 'package:firstone/menuItemsparts/Movers.dart';
// import 'package:firstone/menuItemsparts/News.dart';
// import 'package:firstone/menuItemsparts/WatchList.dart';
// import 'package:flutter/material.dart';
// import 'package:firstone/scrollableMenu.dart';
//
// import 'menuItemsparts/CA.dart';
// import 'menuItemsparts/Crypto.dart';
// import 'menuItemsparts/Markets.dart';
//
// class Page1 extends StatefulWidget {
//   const Page1({super.key});
//
//   @override
//   State<Page1> createState() => _PageState();
// }
//
// class _PageState extends State<Page1> {
//   String selected = "";
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white.withOpacity(0.9),
//       body: Stack(
//         children: [Padding(
//           padding: EdgeInsets.fromLTRB(1,2,1,1),
//           child: GoToselected(),
//         ),
//
//           ClipRect(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(
//                 sigmaY: 5,sigmaX: 5,
//               ),
//               child:Container(
//                 color: Colors.white38,
//                 height: 155,
//                 width: screenWidth,
//               ),
//             ),
//           ),
//
//           Container(
//             decoration: BoxDecoration(
//                 boxShadow: [BoxShadow(
//                   color: Colors.grey.withAlpha(40),
//                   blurRadius: 10,
//                   spreadRadius: 10,
//                 )]
//             ),
//             // color: Colors.white.withOpacity(0.5),
//             height: 160,
//             width: screenWidth,
//             padding: EdgeInsets.fromLTRB(20,30,20,10),
//             child: Column(
//               children: [
//                 Scrollablemenu(
//                     onMenuTap: (title) {
//                       setState(() {
//                         selected=title;
//                       });
//                     }
//                 ),
//                // Searchbarnew(focusNode: ,),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget GoToselected(){
//     switch(selected){
//       case "WatchList":
//         return Watchlist(controller: ,);
//
//       case "News":
//         return News();
//
//       case "Crypto":
//         return Crypto();
//
//       case "Markets":
//         return Markets();
//
//       case "Movers":
//         return Movers();
//
//       case "CA":
//         return CA();
//
//       default :
//         return Watchlist();
//     }
//   }
//
// }
