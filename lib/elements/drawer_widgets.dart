import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';

buildProgramAndFeaturesSection() => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            'Programs & Feature',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor('#072C3F'),
            ),
          ),
        ),
        ListTile(
          title: drawerText(text: 'About website'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Services'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Contact us'),
          trailing: drawerIcon(),
        ),
      ],
    );

buildShopByDepartmentSection() => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            'Shop By Department',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor('#072C3F'),
            ),
          ),
        ),
        ListTile(
          title: drawerText(text: 'Home'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Women'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Men'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Children'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Toys'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Sports'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'Health and beauty'),
          trailing: drawerIcon(),
        ),
      ],
    );

buildHelpAndSettingsSection() => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            'Help & Setting',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor('#072C3F'),
            ),
          ),
        ),
        ListTile(
          title: drawerText(text: 'Your Account'),
          trailing: drawerIcon(),
        ),
        ListTile(
          title: drawerText(text: 'English'),
          leading: IconButton(
              onPressed: null, icon: Image.asset('assets/home/outline.png')),
        ),
        ListTile(
          title: drawerText(text: 'Egypt'),
          leading: IconButton(
              onPressed: null, icon: Image.asset('assets/home/egypt.png')),
        ),
        ListTile(
          title: drawerText(text: 'Customer Services'),
        ),
        ListTile(
          title: drawerText(text: 'Sign Out'),
        ),
      ],
    );
