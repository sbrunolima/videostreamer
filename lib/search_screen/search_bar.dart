import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../search_screen/search_page.dart';

//Search Bar widget
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          //Navigates to SEARCH PAGE
          MaterialPageRoute(
            builder: ((context) => SearchPage()),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white24,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                'What trailer you looking for?',
                style: GoogleFonts.openSans(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
