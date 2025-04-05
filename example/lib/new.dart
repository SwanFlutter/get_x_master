
import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen'),
      ),
      body: Center(
        child: Text('Screen'),
      ),
    );
  }
}


class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen2'), 
      ),
      body: Center(
        child: Text('Screen2'),
      ),
    );
  }
}