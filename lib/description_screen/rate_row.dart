import 'package:flutter/material.dart';

class RateRow extends StatelessWidget {
  final String age;
  final String rate;
  final List<String> genre;

  RateRow({
    required this.age,
    required this.rate,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          categoryContainer(age.toString(), false),
          categoryContainer(rate.toString(), true),
          for (int i = 0; i < genre.length; i++)
            categoryContainer(genre[i].toString(), false),
        ],
      ),
    );
  }

  Widget categoryContainer(String title, bool isRate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white30,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          child: Row(
            children: [
              Text(title),
              if (isRate)
                Icon(
                  Icons.star,
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
