import 'package:flutter/material.dart';

AppBar buildAppBar(String title, VoidCallback onClose) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 60,
    flexibleSpace: Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFF12327B), // Warna berdasarkan kode hexa
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: onClose,
            padding: EdgeInsets.only(right: 20),
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    ),
  );
}
