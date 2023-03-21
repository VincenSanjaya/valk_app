import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final Function onPressed;
  final double height;
  final double width;
  const RoundedButton({Key? key, required this.name, required this.onPressed, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF8A8888),

      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(name, style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),),
      )
    );
  }
}
