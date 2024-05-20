import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:werehouse/theme.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              '',
              style: TextStyle(
                fontSize: 18, // Ubah ukuran font di sini
                fontWeight: FontWeight.bold, // Tambahkan tebal
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          
        ],
      ),
    );
  }
}
