import 'package:flutter/material.dart';

class Season extends StatelessWidget {
  final String url;
  final String text;
  const Season({required this.text,required this.url,super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
            height: 130,width: 130,fit:BoxFit.cover,
            url),
        Text(text ,style: TextStyle(color:Colors.white,fontSize:25),
        )
      ],
    );
  }
}