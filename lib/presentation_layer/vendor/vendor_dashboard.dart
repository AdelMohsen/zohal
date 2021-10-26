import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zohal/constance/strings.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar
    (backgroundColor: Colors.white,elevation: 0.0,
      centerTitle: true,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);}, icon:const Icon(Icons.arrow_back,color: Colors.deepOrange,)),
      title: AutoSizeText('DashBoard',minFontSize: 16,maxFontSize: 18,style: TextStyle(color: primaryColor),),
    ),
      body: const Center(
        child: Icon(FontAwesomeIcons.wrench,size: 64,color: Colors.deepOrange)),
    );
  }
}
