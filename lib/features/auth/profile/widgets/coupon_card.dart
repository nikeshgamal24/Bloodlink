import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/profile/services/coupon_get_services.dart';

class CouponCard extends StatelessWidget {
  final String id;
  final String description;
  final int pointCost, disountPercentage, availablePoints;
  const CouponCard({
    super.key,
    required this.id,
    required this.description,
    required this.pointCost,
    required this.availablePoints,
    required this.disountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final CouponService couponService = CouponService();

    void redeemCoupon(String coupId) {
      couponService.redeemCoupon(context, coupId);
    }

    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(1.0, 1.0),
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
            const BoxShadow(
              color: Color.fromARGB(255, 247, 245, 245),
              offset: Offset(-1.0, -1.0),
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$disountPercentage% off: ',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonBackgroundColor,
                    ),
                    onPressed: () {
                      redeemCoupon(id);
                    },
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Redeem",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$description',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Cost of coupon: $pointCost',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
