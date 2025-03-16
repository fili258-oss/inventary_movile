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

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          title: Text(
                            product['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.attach_money, size: 18, color: Colors.green),
                                  Text(
                                    product['price'].toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.shopping_cart, size: 18, color: Colors.blue),
                                  Text(
                                    ' ${product['quantity']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              inventaryBox!.deleteAt(index);
                              _loadBox();
                            },
                          ),
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
