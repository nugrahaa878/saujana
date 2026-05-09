import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Display: DM Serif Display (score number only) ───────────────────────
  static TextStyle displayXl({Color? color}) => GoogleFonts.dmSerifDisplay(
        fontSize: 64,
        fontWeight: FontWeight.w400,
        height: 1.1,
        color: color,
      );

  static TextStyle display({Color? color}) => GoogleFonts.dmSerifDisplay(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        height: 1.15,
        color: color,
      );

  // ── UI: Plus Jakarta Sans (everything else) ─────────────────────────────
  static TextStyle h1({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      );

  static TextStyle h2({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color,
      );

  static TextStyle h3({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      );

  static TextStyle bodyLarge({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color,
      );

  static TextStyle body({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color,
      );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: color,
      );

  static TextStyle label({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.5,
        color: color,
      );

  static TextStyle caption({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color,
      );
}
