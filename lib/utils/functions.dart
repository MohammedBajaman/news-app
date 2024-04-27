import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

String formatDateTime(String inputDate) {

  if(DateTime.tryParse(inputDate) == null){
    return '-';
  }

  initializeDateFormatting('en_GB');
  DateTime date = DateTime.parse(inputDate);
  DateFormat outputFormat = DateFormat('EEE, d MMM yyyy HH:mm \'GMT\'', 'en_GB');
  return outputFormat.format(date);
}

Widget publishedDate(String date){
  return Row(
    children: [
      SvgPicture.asset(
        "assets/calendar.svg",
        height: 17.42.px,
        width: 17.42.px,
      ),
      SizedBox(
        width: 3.87.px,
      ),
      Text(
        formatDateTime(date),
        style: TextStyle(color: const Color(0xffB9B9B9), fontSize: 12.px, fontWeight: FontWeight.w700, overflow: TextOverflow.ellipsis),
      ),
    ],
  );
}

Widget shimmerView() {
  return Container(
    padding: EdgeInsets.only(top: 12.58.px, right: 17.42.px, bottom: 12.58.px, left: 17.42.px),
    margin: EdgeInsets.only(
      left: 20.px,
      top: 4.h,
      right: 20.px,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11.61.px),
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 17.42),
          blurRadius: 85.15,
          spreadRadius: -3.87,
          color: Color.fromRGBO(24, 39, 74, 0.24),
        ),
        BoxShadow(
          offset: Offset(0, 7.74),
          blurRadius: 27.09,
          spreadRadius: -5.81,
          color: Color.fromRGBO(24, 39, 74, 0.19),
        ),
      ],
    ),
    child: Container(
      padding: EdgeInsets.all(7.74.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image shimmer
          Expanded(
            child: Shimmer.fromColors(
              highlightColor: Colors.grey.shade50,
              baseColor: Colors.grey.shade200,
              child: Container(
                height: 96.px,
                width: 96.px,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.px)),
              ),
            ),
          ),

          SizedBox(width: 16.45.px),

          // title | desc | date time
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Shimmer.fromColors(
                  highlightColor: Colors.grey.shade50,
                  baseColor: Colors.grey.shade200,
                  child: Container(
                    color: Colors.white,
                    height: 10,
                    width: 200,
                  ),
                ),

                SizedBox(height: 3.px),

                // desc
                Shimmer.fromColors(
                  highlightColor: Colors.grey.shade50,
                  baseColor: Colors.grey.shade200,
                  child: Container(
                    color: Colors.white,
                    height: 10,
                    width: 300,
                  ),
                ),

                SizedBox(height: 3.px),
                Shimmer.fromColors(
                  highlightColor: Colors.grey.shade50,
                  baseColor: Colors.grey.shade200,
                  child: Container(
                    color: Colors.white,
                    height: 10,
                    width: 150,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}