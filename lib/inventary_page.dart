import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InventaryPage extends StatefulWidget {
  const InventaryPage({super.key});

  @override
  State<InventaryPage> createState() => _InventaryPageState();
}

class _InventaryPageState extends State<InventaryPage> {
  Box? inventaryBox;
  @override
  void initState() {
    super.initState();
    inventaryBox = Hive.box('inventaryBox');
  }

  void _loadBox() {
    setState(() {
      inventaryBox = Hive.box('inventaryBox');
    });
  }

  Future<void> _navigateToAddProduct() async {
    final result = await Navigator.pushNamed(context, '/addProduct');
    if (result == true) {
      _loadBox();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de productos con Hive'),
        
      ),
      
      body: Column(
        children: [

          Expanded(
            child: inventaryBox != null && inventaryBox!.isNotEmpty
                ? ListView.builder(
                    itemCount: inventaryBox!.length,
                    itemBuilder: (context, index) {
                      final product = inventaryBox!.getAt(index);
                      return ListTile(
                        title: Text(
                          product['title'],                          
                        ),                                                
                      );
                    },
                  )
                : const Center(
                    child: Text('No hay productos registrados'),
                  ),
          ),
        ],
      ),
      //agrega un boton flotante con el signo de add
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddProduct();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
