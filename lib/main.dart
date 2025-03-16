import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_hive/screens/add_product.dart';
import 'package:todo_hive/inventary_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  await Hive.openBox('inventaryBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicación de inventarios',
      routes: {
        '/addProduct': (context) => const AddProduct(),
        
      },
      home: const InventaryPage(),      
      //agregar un boton flotante
      
    );
  }
}
