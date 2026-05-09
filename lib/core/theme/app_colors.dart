import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primitives: Warm Stone ──────────────────────────────────────────────
  static const stone50  = Color(0xFFFAF7F4);
  static const stone100 = Color(0xFFF2EDE7);
  static const stone200 = Color(0xFFE4DAD0);
  static const stone300 = Color(0xFFC9BDB1);
  static const stone400 = Color(0xFFA89589);
  static const stone500 = Color(0xFF7D6E64);
  static const stone600 = Color(0xFF5C5049);
  static const stone700 = Color(0xFF3D342E);
  static const stone800 = Color(0xFF2A2220);
  static const stone900 = Color(0xFF1C1917);

  // ── Primitives: Sage (Primary) ──────────────────────────────────────────
  static const sage100  = Color(0xFFE8F0E5);
  static const sage200  = Color(0xFFC8DCC3);
  static const sage300  = Color(0xFFA5C4A0);
  static const sage400  = Color(0xFF82AB7C);
  static const sage500  = Color(0xFF638F5D);
  static const sage600  = Color(0xFF4E7249);
  static const sage700  = Color(0xFF3A5636);
  static const sage800  = Color(0xFF273B24);

  // ── Primitives: Terracotta (Moderate severity) ──────────────────────────
  static const terra100 = Color(0xFFF5E8DF);
  static const terra300 = Color(0xFFD8A88A);
  static const terra400 = Color(0xFFC4845A);
  static const terra700 = Color(0xFF653A23);

  // ── Primitives: Amber (Mild severity) ──────────────────────────────────
  static const amber100 = Color(0xFFFDF3DC);
  static const amber300 = Color(0xFFEEC86A);
  static const amber400 = Color(0xFFD4A83A);
  static const amber600 = Color(0xFF8A6A14);

  // ── Primitives: Clay Rose (Severe severity — warm, not alarm red) ───────
  static const rose100  = Color(0xFFF5E4DF);
  static const rose300  = Color(0xFFD4897A);
  static const rose400  = Color(0xFFBD5E4B);
  static const rose600  = Color(0xFF7A3228);

  // ── Semantic: Light Mode ────────────────────────────────────────────────
  static const bgBase          = stone50;
  static const bgSurface       = Color(0xFFFFFFFF);
  static const bgSurfaceAlt    = stone100;

  static const textPrimary     = stone800;
  static const textSecondary   = stone500;
  static const textDisabled    = stone300;
  static const textInverse     = stone50;

  static const borderSubtle    = stone200;
  static const borderDefault   = stone300;

  static const actionDefault   = sage500;
  static const actionHover     = sage600;
  static const actionSubtle    = sage100;
  static const actionOn        = stone50;

  // ── Semantic: Dark Mode ─────────────────────────────────────────────────
  static const darkBgBase       = stone900;
  static const darkBgSurface    = stone800;
  static const darkBgSurfaceAlt = stone700;

  static const darkTextPrimary   = stone100;
  static const darkTextSecondary = stone400;
  static const darkTextDisabled  = stone600;

  static const darkBorderSubtle  = stone700;
  static const darkBorderDefault = stone600;

  static const darkActionDefault = sage400;
  static const darkActionHover   = sage300;
  static const darkActionSubtle  = sage800;
  static const darkActionOn      = stone900;

  // ── Severity (light mode) ───────────────────────────────────────────────
  static const severityMinimal     = sage500;
  static const severityMinimalBg   = sage100;
  static const severityMild        = amber400;
  static const severityMildBg      = amber100;
  static const severityModerate    = terra400;
  static const severityModerateBg  = terra100;
  static const severitySevere      = rose400;
  static const severitySevereBg    = rose100;

  // ── Severity (dark mode) ────────────────────────────────────────────────
  static const darkSeverityMinimal    = sage400;
  static const darkSeverityMinimalBg  = sage800;
  static const darkSeverityMild       = amber300;
  static const darkSeverityMildBg     = amber600;
  static const darkSeverityModerate   = terra300;
  static const darkSeverityModerateBg = terra700;
  static const darkSeveritySevere     = rose300;
  static const darkSeveritySevereBg   = rose600;
}
