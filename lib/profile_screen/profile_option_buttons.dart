import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Profile Options buttom
class OptionButton extends StatelessWidget {
  final String title;

  OptionButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.arrow_forward_ios_sharp, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
