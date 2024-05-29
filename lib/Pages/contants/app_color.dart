import 'package:flutter/material.dart';

class AppColor {

  static const sheetColor = Color(0xFF00070f);
  static const backgroundColorDark = Color(0xFF141622);

  static const primaryColor = Color(0xFF0000FF);
  static const backgroundColor = Color(0xFFF0F0F0);
  static const appBarColor = Color(0xFFDBD9D9);
  static const colorGrey = Color(0xFFADACAC);
  static const cardColor = Color(0xFFF3E5F5);
  static const hintColor = Color(0xFF455A64);
  static const errorColor = Color(0xFFF44336);
  static const colorWhite = Color(0xFFFFFFFF);
  static const fillColor = Color(0xFFD1C4E9);

  static const Color primary = Color(0xFF242476);
  static const Color primarySoft = Color(0xFFfdfef9);
  static const Color secondary = Color(0xFF0A0E2F);
  static const Color accent = Color(0xFFFABA3E);
  static const Color border = Color(0xFFD3D3E4);
  static const Color primaryDark = Color(0xFF40ACA1);
  static const Color primaryLight = Color(0xFF6CDAFF);

  static const Color secondaryDark = Color(0xFF507DFF);
  static const Color secondaryLight = Color(0xFF60A6FF);

  static const Color fontDark = Color(0xFF5C6E8D);
  static const Color fontLight = Color(0xFFB3C7E0);

  static  const Color accent1 = Color(0xFF8A4D52);
  static const Color background = Color(0xFFF1F2F5);
  static Color get primary1 => const Color(0xff5E00F5);
  static Color get primary500 => const Color(0xff7722FF );
  static Color get primary20 => const Color(0xff924EFF);
  static Color get primary10 => const Color(0xffAD7BFF);
  static Color get primary5 => const Color(0xffC9A7FF);
  static Color get primary0 => const Color(0xffE4D3FF);

  static Color get secondary2 => const Color(0xffFF7966);
  static Color get secondary50 => const Color(0xffFFA699);
  static Color get secondary0 => const Color(0xffFFD2CC);

  static Color get secondaryG => const Color(0xff00FAD9);
  static Color get secondaryG50 => const Color(0xff7DFFEE);


  static Color get gray => const Color(0xff0E0E12);
  static Color get gray80 => const Color(0xff1C1C23);
  static Color get gray70 => const Color(0xff353542);
  static Color get gray60 => const Color(0xff4E4E61);
  static Color get gray50 => const Color(0xff666680);
  static Color get gray40 => const Color(0xff83839C);
  static Color get gray30 => const Color(0xffA2A2B5);
  static Color get gray20 => const Color(0xffC1C1CD);
  static Color get gray10 => const Color(0xffE0E0E7);

  static Color get border1 => const Color(0xffCFCFFC);
  static Color get primaryText => Colors.white;
  static Color get secondaryText => gray60;

  static Color get white => Colors.white;

  /// dimensions
  static const double defaultSpacing = 16.0;
  static const double defaultRadius = 12.0;

  static const double fontSizeHeading = 18.0;
  static const double fontSizeTitle = 16.0;
  static const double fontSizeBody = 13.0;

  static const kPrimaryGradient = LinearGradient(
    colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
//  static const Color primarygreen = Color.fromRGBO(21,54,36,1.0);
  static const Color primarygreen = Color.fromRGBO(38,151,129,1.0);

  static const List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];

}
ButtonStyle primaryBtn = ElevatedButton.styleFrom(
  backgroundColor: AppColor.primarygreen,
  padding: EdgeInsets.only(top: 13, bottom: 13),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0)
  )

);
const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFF5C6E8D);
const Color pinkClr = Color(0xFF8A4D52);

const Color CardPurple1 = Color(0xFF990099);
const Color CardPurple2 = Color(0xFF660066);