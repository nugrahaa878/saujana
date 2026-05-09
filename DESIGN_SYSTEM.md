# Saujana — Design System

**Version:** 1.0  
**Date:** 2026-05-09  
**Audience:** UI/UX Designer, Flutter Developer  

---

## 1. Design Philosophy

### Why This Color System and Style Exist

Saujana's users are opening this app during some of their worst moments — Sunday night dread, after a brutal week, lying in bed unable to sleep. The design must do one thing before anything else: make them feel safe enough to answer honestly.

Research across environmental psychology, color therapy, and behavioral science consistently shows:

- **Warm, desaturated earth tones lower cortisol** (the stress hormone) and reduce the perception of threat — the opposite of clinical whites and alarm reds.
- **Natural greens evoke safety and calm** through biophilic association. Studies on hospital environments show patients in rooms with green accents report lower anxiety than those in white or blue rooms (Ulrich, 1984; Nanda et al., 2012).
- **Warm neutrals increase self-disclosure** — people are more willing to be honest in warm-toned environments than cold, bright ones. This is critical for a screening tool where honest answers produce accurate scores.
- **Rounded forms and generous space signal "no pressure"** — sharp edges and tight layouts trigger cognitive tension; rounded, airy layouts do not.
- **Dark mode at night reduces stimulation** — our users open the app post-dinner, post-bedtime. A warm dark mode protects the user's natural wind-down and doesn't spike alertness.

The goal is an app that feels like a quiet, warm room — not a clinic, not a corporate HR portal, not a meditation app with stock photos of sunsets.

---

## 2. Color System

### 2.1 Color Palette — "Warm Earth"

The palette is built on warm, low-saturation earth tones. Every color was chosen to feel grounded and honest, not energetic or alarming. Gen Z and Millennial users in 2025 are drawn to this aesthetic — it dominates interior design, fashion, and app UI in this demographic (terracotta, sage, warm stone).

#### Primitive Colors (Raw Tokens)

These are never used directly in components. They exist only to derive semantic tokens.

```
── Neutrals (Warm Stone) ──────────────────────────────────
stone-50:   #FAF7F4    warm near-white
stone-100:  #F2EDE7    warm off-white
stone-200:  #E4DAD0    warm light grey
stone-300:  #C9BDB1    warm medium grey
stone-400:  #A89589    warm grey
stone-500:  #7D6E64    warm mid
stone-600:  #5C5049    warm dark mid
stone-700:  #3D342E    warm dark
stone-800:  #2A2220    warm near-black
stone-900:  #1C1917    warm almost-black (NOT pure #000)

── Sage (Primary Action) ──────────────────────────────────
sage-100:   #E8F0E5
sage-200:   #C8DCC3
sage-300:   #A5C4A0
sage-400:   #82AB7C
sage-500:   #638F5D    primary brand green
sage-600:   #4E7249
sage-700:   #3A5636
sage-800:   #273B24

── Terracotta (Warm Accent) ───────────────────────────────
terra-100:  #F5E8DF
terra-200:  #E8C9B5
terra-300:  #D8A88A
terra-400:  #C4845A    terracotta
terra-500:  #B06540
terra-600:  #8A4E31
terra-700:  #653A23

── Amber (Mild indicator) ─────────────────────────────────
amber-100:  #FDF3DC
amber-200:  #F7E0A8
amber-300:  #EEC86A
amber-400:  #D4A83A    warm amber
amber-500:  #B08820
amber-600:  #8A6A14

── Clay Rose (Severe indicator — warm, not alarming) ──────
rose-100:   #F5E4DF
rose-200:   #E8BCB0
rose-300:   #D4897A
rose-400:   #BD5E4B    warm clay red
rose-500:   #9C4536
rose-600:   #7A3228
```

---

#### Semantic Tokens — Light Mode

```
Background
  bg-base:          stone-50   (#FAF7F4)   main screen background
  bg-surface:       #FFFFFF                cards, sheets
  bg-surface-alt:   stone-100  (#F2EDE7)   secondary cards, input bg
  bg-overlay:       stone-900 @ 40% opacity

Text
  text-primary:     stone-800  (#2A2220)   main readable text
  text-secondary:   stone-500  (#7D6E64)   subtitles, labels
  text-disabled:    stone-300  (#C9BDB1)
  text-inverse:     stone-50   (#FAF7F4)   text on dark surfaces

Border
  border-subtle:    stone-200  (#E4DAD0)
  border-default:   stone-300  (#C9BDB1)
  border-strong:    stone-400  (#A89589)

Action (Primary)
  action-default:   sage-500   (#638F5D)
  action-hover:     sage-600   (#4E7249)
  action-subtle:    sage-100   (#E8F0E5)
  action-on:        stone-50   (#FAF7F4)   text on action bg

Severity (used only for score results — never for generic UI)
  severity-minimal: sage-500   (#638F5D)
  severity-mild:    amber-400  (#D4A83A)
  severity-moderate:terra-400  (#C4845A)
  severity-severe:  rose-400   (#BD5E4B)

  severity-minimal-bg:  sage-100   (#E8F0E5)
  severity-mild-bg:     amber-100  (#FDF3DC)
  severity-moderate-bg: terra-100  (#F5E8DF)
  severity-severe-bg:   rose-100   (#F5E4DF)

Feedback
  success:          sage-500
  warning:          amber-400
  error:            rose-400
  info:             stone-500
```

---

#### Semantic Tokens — Dark Mode

Dark mode uses a warm-dark foundation (stone-900 base), not pure black. Pure black (#000) feels harsh and clinical; warm-dark feels like evening, which is exactly when our users open the app.

```
Background
  bg-base:          stone-900  (#1C1917)
  bg-surface:       stone-800  (#2A2220)
  bg-surface-alt:   stone-700  (#3D342E)
  bg-overlay:       stone-900 @ 60% opacity

Text
  text-primary:     stone-100  (#F2EDE7)
  text-secondary:   stone-400  (#A89589)
  text-disabled:    stone-600  (#5C5049)
  text-inverse:     stone-800  (#2A2220)

Border
  border-subtle:    stone-700  (#3D342E)
  border-default:   stone-600  (#5C5049)
  border-strong:    stone-500  (#7D6E64)

Action (Primary)
  action-default:   sage-400   (#82AB7C)   slightly lighter in dark mode for contrast
  action-hover:     sage-300   (#A5C4A0)
  action-subtle:    sage-800   (#273B24)
  action-on:        stone-900  (#1C1917)

Severity
  severity-minimal: sage-400   (#82AB7C)
  severity-mild:    amber-300  (#EEC86A)
  severity-moderate:terra-300  (#D8A88A)
  severity-severe:  rose-300   (#D4897A)

  severity-minimal-bg:  sage-800   (#273B24)
  severity-mild-bg:     amber-600  (#8A6A14) @ 30% opacity blend
  severity-moderate-bg: terra-700  (#653A23)
  severity-severe-bg:   rose-600   (#7A3228) @ 40% opacity blend
```

---

### 2.2 Color Usage Rules

1. **Severity colors are quarantined to result screens only.** Never use `severity-moderate` or `severity-severe` colors on buttons, navigation, or general UI — they will desensitize users to their meaning.
2. **Never use pure red (#FF0000 or similar) anywhere** in the app. Our severe color is a warm clay red — serious but not panic-inducing.
3. **The primary action color (sage green) signals safety and forward movement**, not urgency. It should appear on the main CTA on every screen.
4. **Backgrounds must always be warm, never pure white or pure black.** `#FFFFFF` is only acceptable for cards in light mode; never as a full-screen background.

---

## 3. Typography

### 3.1 Font Families

| Role | Font | Why |
|---|---|---|
| Display / Score | **DM Serif Display** | Warm, literary, gives the score number weight and humanity. The serif feels considered and honest — the opposite of a cold digital readout. |
| UI / Body | **Plus Jakarta Sans** | Modern, friendly, highly legible. Popular in Gen Z-facing products (Notion, Linear). Has personality without being quirky. |

Both fonts are available on Google Fonts and can be loaded via the `google_fonts` Flutter package.

```yaml
# pubspec.yaml addition
google_fonts: ^6.x
```

Usage in Flutter:
```dart
// Display — score number
GoogleFonts.dmSerifDisplay(fontSize: 64, fontWeight: FontWeight.w400)

// UI text — everything else
GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w400)
```

---

### 3.2 Type Scale

All sizes in `sp` (Flutter scale-independent pixels). Line heights in multipliers.

| Token | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `display-xl` | 64sp | 400 (Regular) | 1.1 | Score number (the hero) |
| `display` | 48sp | 400 (Regular) | 1.15 | Section hero text |
| `heading-1` | 32sp | 700 (Bold) | 1.2 | Screen titles |
| `heading-2` | 24sp | 700 (Bold) | 1.25 | Card titles |
| `heading-3` | 20sp | 600 (SemiBold) | 1.3 | Subsection titles |
| `body-large` | 16sp | 400 (Regular) | 1.6 | Question text, key body copy |
| `body` | 14sp | 400 (Regular) | 1.6 | General body, descriptions |
| `body-medium` | 14sp | 500 (Medium) | 1.5 | Emphasized body text |
| `label` | 12sp | 600 (SemiBold) | 1.4 | Severity labels, badges, chips |
| `caption` | 11sp | 400 (Regular) | 1.4 | Timestamps, footnotes, disclaimers |

**GAD-7 question text uses `body-large` (16sp)** — large enough to read without squinting, without feeling like it's shouting.

---

### 3.3 Typography Rules

1. **Never use font weight below 400 (Regular).** Thin weights feel cold and inaccessible.
2. **Maximum line length: 60–65 characters** on body text. Longer lines increase reading fatigue for anxious users.
3. **Letter spacing:** Default for all weights except labels. Labels: +0.5sp tracking.
4. **Score number uses DM Serif Display only** — this is the single moment a serif appears in UI; it gives the result gravity.

---

## 4. Spacing System

Built on an **8pt base grid**. All layout values are multiples of 4 or 8.

| Token | Value | Usage |
|---|---|---|
| `space-1` | 4dp | Icon-to-label gaps, tight inline spacing |
| `space-2` | 8dp | Between related elements (icon + text) |
| `space-3` | 12dp | Internal card padding (compact) |
| `space-4` | 16dp | Standard internal padding, list item gap |
| `space-5` | 20dp | Between form elements |
| `space-6` | 24dp | Section padding, card padding |
| `space-8` | 32dp | Between cards, major section gaps |
| `space-10` | 40dp | Screen horizontal padding |
| `space-12` | 48dp | Hero section top padding |
| `space-16` | 64dp | Large section separators |

**Screen horizontal padding:** `space-6` (24dp) on all screens. Generous margins reduce visual pressure.

---

## 5. Border Radius

Rounded forms signal safety. Sharp corners signal urgency or precision — neither is right for a mental health app.

| Token | Value | Usage |
|---|---|---|
| `radius-xs` | 6dp | Small chips, tags |
| `radius-sm` | 12dp | Input fields, small buttons |
| `radius-md` | 16dp | Cards, default containers |
| `radius-lg` | 24dp | Bottom sheets, large cards |
| `radius-xl` | 32dp | Modals, score result card |
| `radius-full` | 9999dp | Pill buttons, progress bars, badges |

---

## 6. Elevation & Shadow

Shadows use warm-tinted color (not neutral grey) to stay consistent with the warm-earth palette.

| Token | Offset Y | Blur | Color | Usage |
|---|---|---|---|---|
| `shadow-sm` | 2dp | 8dp | stone-400 @ 8% | Subtle card lift |
| `shadow-md` | 4dp | 16dp | stone-500 @ 10% | Floating cards, answer options |
| `shadow-lg` | 8dp | 32dp | stone-600 @ 12% | Bottom sheets, modals |
| `shadow-none` | — | — | — | Flat surfaces, backgrounds |

In dark mode, reduce all shadow opacity by 50% and shift color to `stone-900 @ 20%`. Dark surfaces need less lift differentiation.

---

## 7. Iconography

- **Style:** Outlined icons (not filled). Filled icons feel heavy and assertive; outlined feels lighter and friendlier.
- **Library:** [Lucide Icons](https://lucide.dev/) — modern, consistent stroke weight, large enough library. Available as `lucide_flutter` package.
- **Size:** 
  - Navigation: 24dp
  - In-line with text: 16dp or 20dp
  - Hero / illustrative: 48dp
- **Color:** Always inherits from text color token (`text-primary` or `text-secondary`). Never use severity colors on icons in navigation.
- **No filled icons except:** the persistent crisis/help button — it uses a filled icon to ensure it is always visually prominent.

---

## 8. Motion & Animation

Motion must be **calm and purposeful**. No bouncy springs, no particle effects, no looping animations. Our users are already overstimulated.

| Interaction | Duration | Easing | Notes |
|---|---|---|---|
| Screen navigation (push/pop) | 300ms | `easeInOut` | Slide from right — standard, predictable |
| Bottom sheet open | 350ms | `easeOut` | Slides up |
| Bottom sheet close | 250ms | `easeIn` | Faster close = less lag feel |
| Answer selection (highlight) | 150ms | `easeOut` | Instant enough to feel responsive |
| Score reveal (count up) | 1200ms | Custom decelerate curve | Counts from 0 to score, slows near target — gives weight to the number |
| Severity label fade in | 400ms | `easeIn` | After score lands, label appears — staged for comprehension |
| Page content fade in | 200ms | `easeIn` | Avoid sudden content pop |
| Button press feedback | 80ms scale to 0.97 | `easeOut` | Subtle, not bouncy |

**No looping animations in the app** (no pulsing indicators, no breathing circles). These increase anxiety, not calm it.

---

## 9. Component Library

### 9.1 Buttons

#### Primary Button
Used for the single most important action on a screen (e.g., "Start Assessment", "Next", "Save Result").

```
Height:          56dp
Border radius:   radius-full (pill)
Background:      action-default (sage-500 / sage-400 dark)
Text:            action-on, body-medium (14sp, 500 weight)
Padding H:       space-8 (32dp)
Min width:       full-width on mobile (stretch to container)
Icon (optional): 20dp, trailing, space-2 gap
```

States:
- Default: `action-default` bg
- Pressed: `action-hover` bg + scale 0.97
- Disabled: `stone-200` bg, `stone-400` text — never hide, always visible

#### Secondary Button (Ghost)
Used for secondary actions (e.g., "Skip", "Back", "Not now").

```
Height:          56dp
Border radius:   radius-full
Background:      transparent
Border:          1.5dp, border-default
Text:            text-primary, body-medium
Padding H:       space-8
```

#### Text Button
Used for tertiary actions and links in copy (e.g., "Learn more about GAD-7").

```
No background, no border
Text:            action-default, body (14sp), underline on press only
Min tap target:  48×48dp (padding compensates for visual size)
```

---

### 9.2 Question Card

The most important component in the app. Must feel like a conversation, not a form.

```
Background:      bg-surface
Border radius:   radius-lg (24dp)
Padding:         space-6 (24dp)
Shadow:          shadow-md

Question number: label (12sp, 600w), text-secondary
                 e.g., "3 of 7"

Question text:   body-large (16sp, 400w), text-primary
                 max 2 lines before wrapping to new line
                 line-height: 1.6 (breathing room)

Spacing between number and question: space-3 (12dp)
```

---

### 9.3 Answer Option

Radio-style selection, full-width tap target. Must feel satisfying to tap — the tap is the core micro-interaction of the whole app.

```
Height:          64dp minimum (never shorter)
Border radius:   radius-md (16dp)
Background:      bg-surface-alt (unselected)
Border:          1.5dp, border-subtle (unselected)
Padding H:       space-6 (24dp)
Padding V:       space-4 (16dp)

Text:            body (14sp, 400w), text-primary

── Selected state ──────────────────────────────────────────
Background:      action-subtle (sage-100 / sage-800 dark)
Border:          2dp, action-default (sage-500)
Text:            action-default
Left indicator:  8dp filled circle, action-default

── Transition ──────────────────────────────────────────────
Duration: 150ms easeOut
Only color and border change — no layout shift
```

Gap between answer options: `space-3` (12dp).

---

### 9.4 Progress Indicator

Shows "3 of 7" context. Must be visible without being distracting.

```
Type:            Segmented bar (7 segments, one per question)
Height:          4dp
Border radius:   radius-full per segment
Gap between:     4dp
Width:           full width minus screen horizontal padding

Completed:       action-default (sage-500)
Current:         action-default @ 60% opacity
Upcoming:        border-subtle (stone-200)

Animation:       150ms fill transition on advance
```

Pair with a text label above: `"Question 3 of 7"` in `caption` size, `text-secondary`.

---

### 9.5 Score Display (Hero)

The most emotionally significant UI element. The score must land with weight.

```
Score number:    display-xl (64sp), DM Serif Display, text-primary
                 Centered, occupies its own visual block

Severity label:  Chip/badge below the number
                 label size (12sp, 600w)
                 Background: severity-*-bg
                 Text: severity-* color
                 Border radius: radius-full
                 Padding: 6dp vertical, 16dp horizontal

Spacing:         space-4 (16dp) between number and badge

Animation:       Count-up 1200ms, then badge fades in at 400ms
```

---

### 9.6 Severity Badge

Used standalone in history list and on result screen.

```
Border radius:   radius-full
Padding:         4dp vertical, 12dp horizontal
Text:            label (12sp, 600w)
Background:      severity-*-bg
Text color:      severity-* 

Sizes:
  sm:  10sp text, 3dp/10dp padding  — for history list items
  md:  12sp text, 4dp/12dp padding  — for result screen (default)
```

---

### 9.7 History List Item

```
Height:          72dp
Background:      bg-surface
Border radius:   radius-md (16dp)
Padding:         space-4 (16dp) horizontal and vertical
Shadow:          shadow-sm

Left:
  Date:          body-medium (14sp, 500w), text-primary
                 e.g., "Mon, 5 May 2026"
  Day context:   caption (11sp), text-secondary
                 e.g., "Monday" — highlights work-week patterns

Right:
  Score number:  heading-3 (20sp, 600w), text-primary
  Severity badge: sm variant

Gap between items: space-3 (12dp)
```

---

### 9.8 Trend Chart

Simple line chart. Does not need to be a full data visualization — it needs to answer "is it getting better or worse?"

```
Chart area height:    180dp
Y-axis range:         0–21 (fixed — never auto-scale, or a score of 5 will look huge)
Y-axis labels:        0, 7, 14, 21 only — minimal visual noise

Severity bands (background shading):
  0–4:   severity-minimal-bg @ 30% opacity
  5–9:   severity-mild-bg @ 30%
  10–14: severity-moderate-bg @ 30%
  15–21: severity-severe-bg @ 30%

Line:              2dp stroke, action-default (sage-500 / sage-400 dark)
Data points:       8dp circle, filled action-default, white/dark stroke 2dp
Hover/tap state:   16dp circle, score tooltip above point

X-axis labels:     caption (11sp), text-secondary
                   Show date + day abbreviation: "5 May · Mon"
                   Max 5 labels, skip intermediate ones if crowded

No grid lines — the severity band shading provides orientation without noise
```

---

### 9.9 Next Step Card

Shown on result screen for Moderate/Severe scores.

```
Background:      bg-surface
Border radius:   radius-lg (24dp)
Padding:         space-6 (24dp)
Border:          1.5dp, border-subtle
Shadow:          shadow-sm

Icon:            32dp, outlined, text-secondary
Title:           heading-3 (20sp, 600w), text-primary
Description:     body (14sp), text-secondary, max 2 lines
CTA label:       body-medium (14sp, 500w), action-default

Tap behavior:    Opens system browser / phone dialer via OS — not in-app WebView
Chevron right:   16dp icon, text-secondary, trailing
```

---

### 9.10 Bottom Sheet (Reminder Prompt)

```
Handle bar:      40dp wide, 4dp tall, stone-300, centered, space-3 from top
Border radius:   radius-xl top corners only (32dp)
Background:      bg-surface
Padding:         space-6 (24dp)
Max height:      60% of screen height

Title:           heading-2 (24sp), text-primary
Subtitle:        body (14sp), text-secondary
CTA:             Primary button, full width
Dismiss:         Text button, "Not now", centered below CTA
```

---

## 10. Screen-by-Screen Design Specs

### 10.1 Onboarding Screen

```
Layout:          Single scroll — no pagination
Top:             space-12 (48dp) from status bar
Illustration:    80dp height, abstract warm-toned line art (not stock photos)
Heading:         heading-1, "Check in with yourself"
Body:            body-large (16sp), ≤ 3 sentences, text-secondary
Time estimate:   Label chip: "Takes about 2 minutes"
                 Background: action-subtle, text: action-default
                 Positioned below heading
CTA:             Primary button, "Get started", pinned to bottom
Privacy note:    caption, text-secondary, centered
                 "Your answers stay on this device. Always."
```

---

### 10.2 Assessment Screen (Per Question)

```
Top bar:         Back arrow (left), "Question X of 7" (center, caption)
Progress bar:    Below top bar, space-4 below
Main content:    Vertically centered in remaining space

Question card:   Full width minus 24dp padding each side
Answer options:  Stack below card, space-3 gap
                 "Next" button appears automatically after selection
                 (no separate tap to confirm — reduces friction)

Next button:     Primary, full width, pinned above keyboard/bottom
                 Disabled until answer selected
                 Label: "Next" (questions 1–6), "See my result" (question 7)
```

---

### 10.3 Result Screen

```
Top:             space-8 from status bar
Score label:     caption, text-secondary, centered: "Your GAD-7 score"
Score number:    display-xl, DM Serif Display, text-primary, centered
Severity badge:  md variant, centered, space-4 below number
Divider:         1dp, border-subtle, space-6 vertical margin

Interpretation:  body-large (16sp), text-primary, centered or left-aligned
                 Max 3 sentences. Warm, direct tone.

Next Steps:      Shown if score ≥ 10. Section heading: heading-3 "What to do next"
                 Stack of Next Step Cards

Save / Reminder: Secondary button "Save result"
                 Text button "Set a reminder" below

Disclaimer:      caption, text-secondary, bottom
                 "This is a screening tool, not a diagnosis."
```

---

### 10.4 Home Screen (Returning User)

```
Greeting:        heading-2, "How are you this week?"
                 NOT "Welcome back" — that's corporate
Last result:     Card with last score, date, severity badge
                 Subtext: "X days ago · [Day of week]"
CTA:             Primary button, "Take the assessment"
History link:    Text button, "See all results →"
```

---

### 10.5 History Screen

```
Header:          heading-1, "Your history"
Chart:           Trend chart component, full width, space-6 below header
List:            History list items, no separator lines between
                 (cards create natural separation)
Empty state:     Illustration + body text: "No results yet. Take your first assessment."
                 Primary CTA: "Start now"
```

---

## 11. Accessibility

| Requirement | Spec |
|---|---|
| Color contrast (text on bg) | Minimum 4.5:1 (AA), target 7:1 (AAA) for body text |
| Color contrast (large text) | Minimum 3:1 |
| Touch targets | Minimum 48×48dp for all interactive elements |
| Focus indicators | 2dp ring, action-default color, visible in both modes |
| Screen reader | All interactive elements have semantic labels |
| Font scaling | Layout must not break at 200% system font size |
| Motion | Respect `prefers-reduced-motion` — disable count-up and transition animations |
| Severity communication | Never rely on color alone — always pair with a text label |

---

## 12. Localization Design Considerations

- **Bahasa Indonesia first:** All UI strings must support Bahasa Indonesia character set (Latin, no extended chars needed).
- **String expansion:** Indonesian strings can be 20–30% longer than English equivalents. All text containers must wrap gracefully — no truncation on question text or result copy.
- **RTL:** Not required for id/en, but architecture should not hard-code `left`/`right` — use `start`/`end` (Flutter `EdgeInsetsDirectional`).
- **Date format:** `d MMM yyyy` in English, `d MMMM yyyy` in Bahasa Indonesia. Day-of-week label: full word ("Senin", "Monday").

---

## 13. Design Tokens — Flutter Implementation

Map design tokens to a Flutter `ThemeData` extension. This ensures both light and dark mode are driven by the same token system.

```dart
// Example token structure (lib/core/theme/app_colors.dart)

class AppColors {
  // Primitives
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

  static const sage500  = Color(0xFF638F5D);
  static const sage400  = Color(0xFF82AB7C);
  static const sage100  = Color(0xFFE8F0E5);
  static const sage800  = Color(0xFF273B24);

  static const terra400 = Color(0xFFC4845A);
  static const terra100 = Color(0xFFF5E8DF);
  static const terra700 = Color(0xFF653A23);

  static const amber400 = Color(0xFFD4A83A);
  static const amber100 = Color(0xFFFDF3DC);

  static const rose400  = Color(0xFFBD5E4B);
  static const rose100  = Color(0xFFF5E4DF);
  static const rose600  = Color(0xFF7A3228);
}
```

```dart
// lib/core/theme/app_theme.dart

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.stone50,
  colorScheme: ColorScheme.light(
    primary: AppColors.sage500,
    surface: Colors.white,
    onPrimary: AppColors.stone50,
    onSurface: AppColors.stone800,
  ),
  // ... full ThemeData mapping
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.stone900,
  colorScheme: ColorScheme.dark(
    primary: AppColors.sage400,
    surface: AppColors.stone800,
    onPrimary: AppColors.stone900,
    onSurface: AppColors.stone100,
  ),
);
```

---

## 14. Do's and Don'ts

### Do
- Use warm, muted tones at every layer
- Give question text generous line-height (1.6) — it slows the pace and reduces overwhelm
- Always pair severity color with a text label
- Show "2 minutes" early and often for time-poor users
- Write UI copy in direct, warm language — first and second person ("You", "Your score")
- Use dark mode warm colors, not pure black

### Don't
- Use alarm red anywhere (not even for errors — use clay rose)
- Use pure white (#FFF) as a full-screen background in light mode
- Use pure black (#000) as a dark mode background
- Add any spring/bounce animation
- Use severity colors on navigation, buttons, or general UI elements
- Write copy that implies user failure or self-blame ("You should have…", "You haven't…")
- Use stock wellness imagery (sunsets, meditating figures, lotus flowers)

---

## Changelog

| Version | Date | Author | Change |
|---|---|---|---|
| 1.0 | 2026-05-09 | Design Team | Initial design system — color, typography, spacing, components, screen specs |
