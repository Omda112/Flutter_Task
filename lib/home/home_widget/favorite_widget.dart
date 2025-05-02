import 'package:flutter/material.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key});
  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  bool click = false;
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      setState(() {
        click =! click;
      });
    },
        icon: Icon(Icons.favorite, color:click ? Colors.red : Colors.grey ,));
  }
}