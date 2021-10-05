import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';

buildShoppingAddressPage() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(
          hintText: '*First Name',
          hintStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: '*Last Name',
          hintStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: '  *Phone Number',
          hintStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
          prefixStyle:
          TextStyle(fontSize: 13, color: HexColor('#072C3F')),
          prefixText: 'EG +20',
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: '*State/Province',
          hintStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: '*City',
          hintStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: '*Post/Zip Code',
          hintStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Street, Adress, Company Name, ',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          labelText: '*Address line1',
          labelStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Apartment, Suit, Unit, Balding, Floor ',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          labelText: '*Post/Zip Code',
          labelStyle: TextStyle(
            fontSize: 14,
            color: HexColor('#909090'),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 40.0, bottom: 100.0, left: 20.0, right: 20.0),
        child: orangeButton(
            function: () {},
            child: const Text(
              'CHECK OUT',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )),
      )
    ],
  ),
);