import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String name;
  final String imageUrl;
   int quantity;

  ItemCard({super.key, 
    required this.name, 
    required this.imageUrl,
    required this.quantity,
    });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {


  bool loading = false;

  void _increment() {
    setState(() {
      widget.quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (widget.quantity > 0) {
        widget.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              widget.imageUrl,
              height: 70,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),

          Text(
                widget.name,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),



          
        ],
      ),
    );
  
  
  }
}