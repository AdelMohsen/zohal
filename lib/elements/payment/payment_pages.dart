import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/elements/payment/customer_payment.dart';
import 'package:zohal/elements/payment/visa_payment.dart';
import 'package:zohal/elements/payment/vodafone_payment.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HexColor('#072C3F'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Sub total',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#909090')),
                  ),
                ),
                Expanded(
                  child: Text(
                    '2500',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#909090')),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Shopping',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#909090')),
                  ),
                ),
                Expanded(
                  child: Text(
                    '500',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#909090')),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Discount',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#909090')),
                  ),
                ),
                Expanded(
                  child: Text(
                    '50',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#909090')),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Divider(
              thickness: 2,
              color: HexColor('#707070'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F')),
                  ),
                ),
                Expanded(
                  child: Text(
                    '3000',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F')),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add coupon code',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#8ED16F'),
                    ),
                  ),
                  Image.asset('assets/checkout/path.png'),
                ],
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Text(
              'Chose Payment Method',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#072C3F')),
            ),
          ),
          //Payment_Start
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      'assets/checkout/visa.png',
                      height: 33,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      'assets/checkout/vodafoneCash.png',
                      height: 33,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      'assets/checkout/customer.png',
                      height: 33,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Radio(
                      value: 3,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                ],
              ),
            ],
          ),
          //Payment_End

          //Visa_payment_Start
          if (groupValue == 1) buildVisaPaymentMethod(),
          //Visa_payment_End

          //Vodafone_payment_Start
          if (groupValue == 2) buildVodafonePaymentMethod(),
          //Vodafone_payment_End

          //customer_payment_Start
          if (groupValue == 3) buildCustomerPaymentMethod(),
          //customer_payment_End
        ],
      ),
    );
  }
}
