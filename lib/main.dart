import 'package:flutter/material.dart';
import 'home.dart';
import 'loading.dart';

void main(){
  runApp(  MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => const LoadingActivity(),
      "/home": (context) => const Home(),
      "/loading":(context)=> const LoadingActivity()
    },
  )
  );
}

