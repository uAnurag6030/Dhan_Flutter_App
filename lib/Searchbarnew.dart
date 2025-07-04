import 'package:flutter/material.dart';

class Searchbarnew extends StatefulWidget {
  late FocusNode focusNode;
  late TextEditingController controller;
  final void Function(String) onChanged;

   Searchbarnew({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<Searchbarnew> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbarnew> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller=TextEditingController();
    widget.focusNode= FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.dispose();
    widget.focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 8),
      color: Colors.transparent,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        onTapOutside: (event) => widget.focusNode.unfocus(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10),
          hintText: "Search for companies to invest or trade",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
