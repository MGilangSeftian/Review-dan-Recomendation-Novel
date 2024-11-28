import 'package:flutter/material.dart';
import 'package:reccomendation_novel/models_novel/novels_models.dart';

class ItemCard extends StatefulWidget {
  final Novel novel;
  const ItemCard({super.key, required this.novel});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(5),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(widget.novel.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
            child: Text(
              widget.novel.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              widget.novel.author
            ),
          )
        ],
      ),
    );
  }
}

