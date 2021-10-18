import 'package:flutter/material.dart';

void main(){
  runApp(const Mtest());
}

class Mtest extends StatelessWidget{
  const Mtest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MYHome(title: '多少页面'),
    );
  }
}

class MYHome extends StatefulWidget {
  const MYHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MYHome> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MYHome>{

  @override
  Widget build(BuildContext context){
    return const Scaffold(
    );
  }
}

