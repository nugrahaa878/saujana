import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark  => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final bg         = isDark ? AppColors.darkBgBase       : AppColors.bgBase;
    final surface    = isDark ? AppColors.darkBgSurface     : AppColors.bgSurface;
    final primary    = isDark ? AppColors.darkActionDefault : AppColors.actionDefault;
    final onPrimary  = isDark ? AppColors.darkActionOn      : AppColors.actionOn;
    final textPrim   = isDark ? AppColors.darkTextPrimary   : AppColors.textPrimary;
    final textSec    = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final border     = isDark ? AppColors.darkBorderSubtle  : AppColors.borderSubtle;

    final colorScheme = ColorScheme(
      brightness:       brightness,
      primary:          primary,
      onPrimary:        onPrimary,
      secondary:        isDark ? AppColors.darkActionSubtle : AppColors.actionSubtle,
      onSecondary:      primary,
      error:            AppColors.rose400,
      onError:          AppColors.stone50,
      surface:          surface,
      onSurface:        textPrim,
      surfaceContainerHighest: isDark ? AppColors.darkBgSurfaceAlt : AppColors.bgSurfaceAlt,
    );

    return ThemeData(
      useMaterial3:    true,
      brightness:      brightness,
      colorScheme:     colorScheme,
      scaffoldBackgroundColor: bg,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor:       textPrim,
        displayColor:    textPrim,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor:  bg,
        foregroundColor:  textPrim,
        elevation:        0,
        scrolledUnderElevation: 0,
        centerTitle:      true,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrim,
        ),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color:        surface,
        elevation:    0,
        shape:        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side:         BorderSide(color: border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:  primary,
          foregroundColor:  onPrimary,
          minimumSize:      const Size(double.infinity, 56),
          shape:            StadiumBorder(),
          textStyle:        GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrim,
          minimumSize:     const Size(double.infinity, 56),
          shape:           StadiumBorder(),
          side:            BorderSide(color: border, width: 1.5),
          textStyle:       GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle:       GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color:     border,
        thickness: 1,
        space:     0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled:          true,
        fillColor:       isDark ? AppColors.darkBgSurfaceAlt : AppColors.bgSurfaceAlt,
        border:          OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide:   BorderSide(color: border),
        ),
        enabledBorder:   OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide:   BorderSide(color: border),
        ),
        focusedBorder:   OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide:   BorderSide(color: primary, width: 2),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: textSec,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:   surface,
        shape:             RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS:     CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
