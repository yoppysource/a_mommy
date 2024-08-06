import 'package:flutter/material.dart';

abstract class Palette {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;

  static const Color primary1 = Color(0xFFDED3FD);
  static const Color primary2 = Color(0xFFAEBAF8);
  static const Color primary3 = Color(0xFFBB96FB);
  static const Color primary4 = Color(0xFFC973FF);
  static const Color primary5 = Color(0xFF553CFF);
  static const Color accent1 = Color(0xFFF9EDFF);
  static const Color accent2 = Color(0xFFFFB8E1);
  static const Color accent3 = Color(0xFFFF78C5);

  static const Color gray1 = Color(0xFFF8F9FB);
  static const Color gray2 = Color(0xFFEEEEEE);
  static const Color gray3 = Color(0xFFD1D1D1);
  static const Color gray4 = Color(0xFFBCBCBC);
  static const Color gray5 = Color(0xFFACACAC);
  static const Color gray6 = Color(0xFF979797);
  static const Color gray7 = Color(0xFF727272);
  static const Color gray8 = Color(0xFF484848);

  static const Color customGray = Color(0xFFF8F8F8);
  static const Color customGray2 = Color(0xFF4D4D4D);
  static const Color customRed = Color(0xFFFF0000);
  static const Color opacityPurple = Color.fromRGBO(222, 211, 253, 50);

  static const Gradient gradient1 = LinearGradient(
    colors: [Color(0xFFAEBAF8), Color(0xFFBB96FB), Color(0xFFC973FF)],
  );

  static const Gradient gradient2 = RadialGradient(
    colors: [Color(0xFFC973FF), Color(0xFFAEBAF8)],
    radius: 1.0,
  );
  static const Gradient gradient3 = SweepGradient(
    colors: [Color(0xFFC973FF), Color(0xFFAEBAF8)],
  );

  static const Gradient gradient4 = LinearGradient(
    colors: [Color(0xFFDED3FD), Color(0xFFDFB8FD), Color(0xFFB8CEFF)],
  );
}

abstract class TextPreset {
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 22.0,
    height: 1.3,
    letterSpacing: -0.44,
    fontWeight: FontWeight.w700,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 20.0,
    height: 1.3,
    letterSpacing: -0.4,
    fontWeight: FontWeight.w700,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle subTitle1 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 18.0,
    height: 1.3,
    letterSpacing: -0.36,
    fontWeight: FontWeight.w600,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle subTitle2 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 16.0,
    height: 1.3,
    letterSpacing: -0.32,
    fontWeight: FontWeight.w600,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle subTitle3 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 14.0,
    height: 1.3,
    letterSpacing: -0.28,
    fontWeight: FontWeight.w600,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 16.0,
    height: 1.3,
    letterSpacing: -0.28,
    fontWeight: FontWeight.w400,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 14.0,
    height: 1.3,
    letterSpacing: -0.28,
    fontWeight: FontWeight.w400,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 12.0,
    height: 1.3,
    letterSpacing: -0.24,
    fontWeight: FontWeight.w400,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 10.0,
    height: 1.2,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
    leadingDistribution: TextLeadingDistribution.even,
  );
  static const TextStyle toChange = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 10.0,
    height: 1.2,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
    leadingDistribution: TextLeadingDistribution.even,
    color: Colors.red,
  );
}
