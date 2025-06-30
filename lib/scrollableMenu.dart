import 'package:flutter/material.dart';

class Scrollablemenu extends StatefulWidget {
  final  Function(String) onMenuTap;

   Scrollablemenu({super.key, required this.onMenuTap});

  @override
  State<Scrollablemenu> createState() => _ScrollablemenuState();
}

class _ScrollablemenuState extends State<Scrollablemenu> {
  bool isUnderlined = false;
  String selected = "";
  @override
  Widget build(BuildContext context) {
    List<String> titles= ["WatchList","News","CA","Movers","Markets","Crypto"];
    List<Widget> menuitems= [];

    menuitems.add(
      Padding
        (
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Color(0xFF016124),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.person,color: Colors.white,),
          ),
        )
      )
    );

    for(String title in titles){
      menuitems.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            widget.onMenuTap(title);
            setState(() {
              selected=title;
            });
          },
          child: Column(
            children: [
              AnimatedContainer(
                duration: selected==title?Duration(milliseconds: 300):Duration(milliseconds: 0),
                curve: Curves.easeIn,
                child: Text(
                  title,
                  style: TextStyle(
                    color: selected==title?Colors.black:Colors.black54,
                    fontSize: selected==title?18:17,
                    fontWeight: selected==title?FontWeight.bold:FontWeight.normal,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                height: 2,
                width: selected==title?40:0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF016124),
                ),
                //color:
              )

              
            ],
          ),
        ),
      ),
      );

    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menuitems,
      ),
    );
  }
}
