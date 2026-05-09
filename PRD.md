# PRD — Saujana: GAD-7 Anxiety Screening App

**Version:** 1.2  
**Date:** 2026-05-09  
**Status:** Draft  
**Author:** Product Team  

---

## 1. Executive Summary

Saujana is a fully offline, zero-backend mobile application (Flutter, iOS & Android) that helps users recognize and track generalized anxiety symptoms using the clinically validated GAD-7 screening instrument. The app guides users through the 7-question assessment, provides a scored result with contextual interpretation, tracks results over time on-device, and surfaces clear next steps — including when to seek professional help.

**Architectural constraint:** Saujana has no backend, no server, no network dependency, and no cloud sync — permanently. All data lives exclusively on the user's device in a local database. This is a product and architectural decision, not a deferral.

**Zero friction, zero gates:** There is no login, no sign-up, no onboarding form, no email, no account of any kind — ever. The user opens the app, takes the assessment, and gets their result. That is the entire entry flow. Any feature proposal that requires identity must be rejected.

The name *Saujana* (Malay/Indonesian: "as far as the eye can see") reflects the goal: giving users perspective on their own mental state that they could not see clearly on their own.

---

## 2. Problem Statement

### The Real Problem (Mom Test Validated)

> The Mom Test principle: don't ask "would you use this?" — look at what people already do.

Observable behaviors that confirm the problem exists — specific to our target cohort (Gen Z and Millennials in 9-5 work):

- People search "am I anxious test", "anxiety quiz", and "GAD-7 online" millions of times per month — mostly on their phones after work hours, self-diagnosing with low-quality, un-scored web pages.
- The "Sunday scaries" is a widely recognized phenomenon: anxiety that peaks Sunday evening dreading the work week. Users describe it as a recurring pattern but do not connect it to clinical anxiety.
- Workers in always-on office cultures (Slack after hours, after-hours emails) report feeling unable to mentally leave work, but dismiss it as "just being busy" rather than anxiety symptoms.
- Sandwich generation users — simultaneously caring for aging parents and raising children — report feeling guilty asking for help for themselves because everyone else's needs feel more urgent.
- People track mood in Notes or journaling apps with no clinical framework. Data exists but produces no actionable insight.
- Indonesian mental health waitlists are long; online therapy is expensive relative to median salary. Users need something between "nothing" and "weekly therapy."
- Gen Z and Millennials heavily use TikTok and Instagram to validate their emotional experiences — they already consume mental health content there but get no personalized, scored result.

### What People Do Today (Current Behavior)

| Behavior | Pain it reveals |
|---|---|
| Search anxiety symptoms at 11pm after doom scrolling | Self-diagnosing with no framework; comparing to worst-case scenarios online |
| Vent to close friends on WhatsApp | Vague and socially filtered; friends validate but cannot quantify |
| Fill paper GAD-7 at a clinic visit | Infrequent, no history, no context — and many never reach the clinic |
| Download generic wellness apps (meditation, journaling) | Doesn't answer "how bad is it actually?" — the core question |
| Push through and say "I'm just tired" | Delays recognition until symptoms are severe |
| Sandwich gen: prioritize everyone else's health appointments before their own | Their own mental health check is always the last item on the list |

### What We Are NOT Solving

- Therapy or clinical diagnosis (we are a screening tool, not a clinician)
- Replacing GP or psychiatrist visits
- Crisis intervention (we will always surface emergency resources but that is not our core loop)

---

## 3. Target Users

### Primary: The Burnt-Out 9-5 Worker (Gen Z & Millennial, Ages 22–38)

**Profile:**
- Works a standard office or hybrid job; commutes or WFH but mentally never fully off-clock
- Grew up with smartphones — expects any app interaction to be fast, frictionless, and honest
- Aware that mental health matters (has consumed mental health content on TikTok/Instagram) but hasn't translated awareness into action for themselves
- Experiencing recurring anxiety symptoms — restlessness, trouble relaxing, sleep disruption — but attributes them to "work stress" or "just being busy"
- Will not book a therapy appointment without first validating that their experience is clinically significant ("I don't want to bother a therapist with something that's probably normal")
- Time-poor: the app must be completable during a lunch break or the commute home

**Key insight from Mom Test framing:** They already know they're stressed. What they don't know is whether it's *enough* to act on. The GAD-7 score is the permission slip. Write everything as if speaking to someone who is smart, self-aware, and tired — not someone who needs to be convinced that mental health is real.

**Trigger moments (when they are most likely to open the app):**
- Sunday evening (pre-work-week anxiety spike)
- After a stressful meeting or performance review
- End of a bad week
- Lying in bed unable to sleep

---

### Secondary: The Sandwich Generation Caregiver (Millennial, Ages 28–42)

**Profile:**
- Simultaneously managing: a 9-5 job, aging parent(s) who need regular support, and their own children or younger siblings
- Financial pressure from both ends — supporting parents and children on a single or dual income
- Chronically time-poor and emotionally depleted; their own self-care is the first thing they sacrifice
- Cognitively overwhelmed: always running a mental checklist of other people's needs
- Likely to score Moderate or Severe on GAD-7 but hasn't noticed because their baseline has been elevated for so long it feels normal
- High guilt around self-focus: "everyone else is struggling more than I am"

**Key insight from Mom Test framing:** They will not open an app that feels like another task to manage. The framing must be: "this takes 2 minutes and you owe yourself at least that." The result must validate their experience without catastrophizing — they're already carrying enough.

**Trigger moments:**
- After putting the kids to bed (the only quiet moment in the day)
- After a difficult conversation with an aging parent
- During a rare moment alone (commute, waiting room)

---

### Out-of-Scope Users

- Users in acute psychiatric crisis (we will redirect, not serve)
- Children under 18 (GAD-7 not validated for this group)
- Clinical professionals (different product, different regulatory path)
- Users looking for a general wellness or meditation app — Saujana is a screening tool, not a mood tracker

---

## 4. Goals & Success Metrics

### Product Goals

| Goal | Why It Matters |
|---|---|
| Users complete the GAD-7 in under 3 minutes | Our users have a lunch break, a commute, or 2 minutes before the next family demand — the entire flow must fit |
| Users understand their score without reading a manual | If they need to Google the result, we failed |
| Users return to take the assessment again in 2–4 weeks | Single-shot use = no retention, no value from tracking |
| Users who score Moderate+ know a concrete next step | Impact requires action, not just awareness |
| Copy never makes users feel judged or broken | Burnt-out Gen Z/Millennials are allergic to corporate wellness language and self-blame framing |

### North Star Metric

**Monthly Retained Screeners:** number of users who complete at least 2 GAD-7 assessments within a 30-day window.

### Supporting KPIs

| Metric | Target (Month 3) |
|---|---|
| Assessment completion rate | ≥ 85% of users who start, finish |
| 2nd assessment rate (≥14 days later) | ≥ 40% of users who completed first |
| "Next step tapped" rate (for Moderate/Severe scores) | ≥ 60% |
| App store rating | ≥ 4.4 |
| Crash-free sessions | ≥ 99.5% |

---

## 5. User Stories

### Core Flow

**US-01 — Onboarding**  
As a first-time user, I want to understand what the GAD-7 is and why it is credible before I start, so that I trust the result.

**US-02 — Assessment**  
As a user, I want to answer 7 questions about how I have felt over the past 2 weeks, so that I get a scored result that reflects my actual state.

**US-03 — Result Interpretation**  
As a user, I want to see my score (0–21), its severity category, and a plain-language explanation, so that I understand what my number means without needing to research it.

**US-04 — Next Steps**  
As a user with a Moderate or Severe score, I want to see specific, actionable next steps (talk to a GP, check if my employer has an EAP, find an online therapist, crisis line), so that the score leads somewhere useful and not just alarming.

**US-05 — History Tracking**  
As a returning user, I want to see a timeline of my past scores — including what day of the week each was taken — so that I can spot whether my anxiety is consistently higher on certain days (e.g., Mondays or before deadlines).

**US-05b — Sandwich Gen Validation**  
As a sandwich generation user who always puts others first, I want to complete the assessment in under 3 minutes without setting up an account, so that I can check in on myself during the one quiet moment I have without it feeling like another task.

**US-06 — Reminder**  
As a user, I want to set a reminder to retake the assessment in 2 weeks so that I build a consistent tracking habit without relying on memory.

**US-07 — Export / Share**  
As a user in therapy, I want to export or share my score history as a simple summary, so that I can show my therapist without manually recalling dates and scores.

**US-08 — Privacy First**  
As a user, I want my responses and results stored exclusively on my device, so that I never have to worry about my mental health data leaving my phone.

---

## 6. Feature Requirements

### 6.1 Onboarding (Must Have — v1)

- [ ] Single-screen onboarding explaining what GAD-7 is (≤ 3 sentences), who developed it, and what the score means at a high level
- [ ] Copy tone: direct and grounded, not clinical or corporate — write for someone who is smart and tired, not someone who needs to be convinced that anxiety is real
- [ ] Explicitly state "takes about 2 minutes" — critical for time-poor users
- [ ] "Start Assessment" CTA — no account creation, no sign-in of any kind
- [ ] Optional: soft permission prompt for notifications (for reminders), deferred to after first completion

**Permanently out of scope:** Account creation, social login, cloud sync — the app makes zero network calls

---

### 6.2 GAD-7 Assessment (Must Have — v1)

The assessment follows the validated GAD-7 instrument exactly. No modifications to question wording or answer scale are permitted — doing so would invalidate clinical validity.

**Questions (verbatim from Spitzer et al., 2006):**

> Over the *last 2 weeks*, how often have you been bothered by the following problems?

| # | Question |
|---|---|
| 1 | Feeling nervous, anxious, or on edge |
| 2 | Not being able to stop or control worrying |
| 3 | Worrying too much about different things |
| 4 | Trouble relaxing |
| 5 | Being so restless that it is hard to sit still |
| 6 | Becoming easily annoyed or irritable |
| 7 | Feeling afraid as if something awful might happen |

**Answer Scale (verbatim):**

| Label | Score |
|---|---|
| Not at all | 0 |
| Several days | 1 |
| More than half the days | 2 |
| Nearly every day | 3 |

**UX Requirements:**

- [ ] One question per screen (not all on one scroll — reduces cognitive load and abandonment)
- [ ] Progress indicator showing "3 of 7"
- [ ] Back navigation allowed (user can change answers)
- [ ] Selected answer highlighted clearly before moving to next question
- [ ] No timer, no auto-advance — user controls the pace
- [ ] Accessible: minimum tap target 48×48dp, color contrast AA compliant, screen reader labels on all interactive elements

---

### 6.3 Scoring & Result Screen (Must Have — v1)

**Scoring Logic:**

```
Total Score = sum of all 7 answers (0–21)

Severity Categories:
  0–4   → Minimal anxiety
  5–9   → Mild anxiety
  10–14 → Moderate anxiety
  15–21 → Severe anxiety
```

**Result Screen Requirements:**

- [ ] Display numeric score prominently (e.g., "Your score: 12")
- [ ] Display severity label with color coding:
  - Minimal: calm green
  - Mild: amber
  - Moderate: orange
  - Severe: red (not alarming red — warm, not warning-sign red)
- [ ] 2–3 sentence plain-language interpretation for each severity band (written at 8th-grade reading level)
- [ ] For Moderate and Severe: surface "What to do next" section (see 6.4)
- [ ] For Minimal and Mild: affirming message + recommendation to recheck in 2–4 weeks
- [ ] Option to save result (triggers local storage write)
- [ ] Option to set a reminder (opens notification permission + date picker)
- [ ] Date and time of assessment auto-recorded with result

**Interpretation copy examples (to be refined with clinical advisor):**

Copy guidelines for this demographic:
- Validate the systemic pressure (work, family, caregiving), not just the individual symptom
- Never use corporate wellness language ("self-care journey", "wellness check-in")
- Be direct — Gen Z and Millennials respect honesty over comfort
- Acknowledge that their situation is genuinely hard, not just a perception problem
- Avoid self-blame framing; avoid catastrophizing

> **Minimal (0–4):** Things look relatively calm right now. That doesn't mean what you're carrying isn't real — it just means your anxiety symptoms aren't in a clinical range at the moment. Check back in a couple of weeks.

> **Mild (5–9):** You're carrying some anxiety. Given the number of things most people your age are juggling — work, family, everything else — this isn't surprising. It's worth keeping an eye on. Recheck in 2 weeks to see if it's building or passing.

> **Moderate (10–14):** Your score suggests anxiety that's likely affecting how you function day-to-day — not just "being stressed." This is a signal worth acting on. Talking to a GP or therapist is a reasonable next step, and your score gives you something concrete to bring to that conversation.

> **Severe (15–21):** This score reflects a significant level of anxiety. You've probably been running on empty for a while. Please reach out to someone — a GP, a therapist, or a crisis line. You don't have to carry this alone, and you don't have to wait until things get worse.

---

### 6.4 Next Steps (Must Have — v1)

Shown automatically when score ≥ 10 (Moderate or Severe). Accessible via a link for all scores.

- [ ] "Talk to your GP" — with brief script: "I've been tracking anxiety symptoms and my GAD-7 score is [X]. I'd like to talk about what this means." Framed as a conversation starter, not a demand
- [ ] "Check your Employee Assistance Program (EAP)" — many 9-5 employers offer free, confidential therapy sessions via EAP that employees never use because they don't know it exists; surface this prominently for Moderate/Severe scores
- [ ] "Find an online therapist" — prioritize online/telehealth options over walk-in clinics, given target users' time constraints (v1 Indonesia: Into The Light, Yayasan Pulih, Into The Light's online referral)
- [ ] "Crisis support" — always visible at bottom: Into The Light Indonesia (119 ext 8)
- [ ] Emergency resources never hidden behind score threshold — accessible from any screen via a persistent help icon
- [ ] For sandwich generation framing: include a note that "getting help for yourself helps everyone who depends on you" — addresses the guilt barrier around self-focus

---

### 6.5 History & Trends (Must Have — v1)

- [ ] List view of all past assessments: date (including day of week, e.g., "Mon, 5 May"), score, severity label
- [ ] Simple line chart showing score over time (x-axis: date, y-axis: 0–21, severity bands as background shading)
- [ ] Day-of-week label on each data point in the chart — helps 9-5 workers identify patterns (e.g., scores consistently higher on Mondays or Fridays before deadline)
- [ ] Tap a past entry to see full result breakdown
- [ ] Delete individual entry (with confirmation dialog)
- [ ] All data stored in local SQLite database (Hive or Drift); no network calls, no sync of any kind — ever

---

### 6.6 Reminders (Should Have — v1)

- [ ] After completing assessment, prompt: "Would you like a reminder to check in again?" with date picker defaulting to +14 days
- [ ] Default reminder time: 7:30 PM on a weekday — after work hours, after dinner, when our users finally have a quiet moment; NOT 9 AM (they're in standup) or 12 PM (they're eating at their desk)
- [ ] Suggested default day: Sunday evening (7:30 PM Sunday) — captures the pre-week anxiety window that is the most common trigger for our primary persona
- [ ] Local push notification at selected time
- [ ] Notification copy should not feel like a task: avoid "Complete your check-in!" — prefer "Hey, how are you doing this week?" or "Two minutes for yourself."
- [ ] Manage reminders screen (view, edit, delete)
- [ ] No more than 1 pending reminder at a time (simplicity over power-user features)

---

### 6.7 Export / Share (Nice to Have — v1, deprioritize if time constrained)

- [ ] Generate a simple text summary: app name, date range, list of scores, trend note
- [ ] Share via iOS Share Sheet / Android Intent (email, notes, messaging)
- [ ] No PDF generation in v1 (added complexity, low incremental value)

---

### 6.8 Privacy & Data (Must Have — v1)

This section reflects a permanent architectural decision, not a v1 constraint.

- [ ] All assessment data stored on-device only in local SQLite — no network calls made by the app under any circumstances
- [ ] No account, no login, no email collection of any kind
- [ ] No third-party analytics SDK, no crash reporting SDK, no ad SDK — zero external data transmission
- [ ] Crash diagnostics handled entirely via device-level OS logs (available to developers via Xcode / Android Studio for debugging; never sent automatically)
- [ ] Privacy policy surfaced in onboarding and settings (policy must accurately state: "no data ever leaves your device")
- [ ] Settings: "Delete all my data" option wipes local SQLite database with confirmation dialog
- [ ] SQLite database file excluded from iCloud and Google auto-backup via `NSURLIsExcludedFromBackupKey` (iOS) and `android:allowBackup="false"` on sensitive data paths (Android)

---

## 7. Technical Architecture

### Guiding Constraint

> **Zero backend. Zero network calls. All state lives in local SQLite on the device.**

This is a hard architectural constraint, not a cost-saving measure. It eliminates an entire class of privacy risk for a sensitive health use case. Any future feature proposal that requires a network call must be rejected or spun into a separate product.

### Local Database

- **Library:** Hive (preferred for simplicity and pure Dart) or Drift (if relational queries are needed for history filtering)
- **Schema:** Two tables — `assessments` (id, timestamp, answers JSON, total_score, severity_label) and `reminders` (id, scheduled_at, assessment_id)
- **Migration:** Version the schema from day one using the chosen library's migration API — even if there is only one version, this prevents a painful retrofit later
- **Encryption:** Evaluate `hive_flutter` AES encryption or `sqflite_sqlcipher` before launch — decision owned by Tech Lead (see Open Questions)

### No Network Policy

- No `http`, `dio`, or `connectivity_plus` packages added to the project
- No Firebase, Supabase, Amplify, or any BaaS SDK
- No analytics SDK (Mixpanel, Amplitude, Firebase Analytics, etc.)
- The app must pass a network traffic audit (Charles Proxy / mitmproxy) showing zero outbound requests during normal use
- The only outbound action the app takes is launching an external URL (deep-link to crisis resources) via the OS — which is a system action, not an app network call

### State Management

- **Recommended:** Riverpod (works well with local-only async data, testable without mocking a backend)
- All app state derived from the local database; no in-memory global state that diverges from the DB

---

## 8. Non-Functional Requirements

| Category | Requirement |
|---|---|
| Performance | Cold start < 2s on mid-range Android (2022 hardware) |
| Offline | Fully functional with zero network — this is the only operating mode |
| Network calls | Zero outbound requests from the app (verified via traffic audit before launch) |
| Accessibility | WCAG 2.1 AA — contrast, touch targets, screen reader |
| Dark mode | Full dark mode support required — our users are on their phones late at night (post-bedtime doom scroll is a primary trigger moment) |
| Localization | v1: Indonesian (id) + English (en); architecture must support adding more |
| Platform | iOS 14+ and Android 8+ |
| Storage | App size < 30MB installed; local DB expected to stay < 1MB for typical user |
| Security | No sensitive data in logs; SQLite file excluded from iCloud/Google auto-backup |

---

## 9. Information Architecture

```
App
├── Onboarding (first launch only)
│   └── → Assessment
├── Home
│   ├── [Take Assessment] CTA
│   └── Last result summary (if any)
├── Assessment Flow
│   ├── Question 1–7 (individual screens)
│   └── Result Screen
│       ├── Next Steps (if score ≥ 10)
│       └── Set Reminder
├── History
│   ├── Score list
│   └── Score chart
└── Settings
    ├── Reminders
    ├── Language
    ├── Privacy policy
    └── Delete all data
```

---

## 10. Design Direction

### Principles

1. **Calm, not clinical** — The aesthetic should feel like a trusted friend who happens to know what GAD-7 means, not a hospital form or a corporate wellness portal.
2. **Score is the hero** — Every screen either leads to the score or helps the user act on it. No filler.
3. **Respect the 2 minutes** — Every flow is designed for someone who stole time from a busy day. No unnecessary screens, no padding, no upsell moments.
4. **No dark patterns** — No guilt-trip notifications ("you haven't checked in!"), no streaks, no badges, no artificially alarming score colors.
5. **Honest, direct copy** — Gen Z and Millennials have strong BS detectors. Write like someone who validates their experience without catastrophizing or minimizing. Avoid corporate wellness clichés ("your wellness journey", "check in with yourself").
6. **Anti-hustle, anti-self-blame** — Copy acknowledges that systemic pressures (work culture, caregiving load) are real contributors to anxiety, not just individual mindset failures.

### Visual Direction

- **Dark mode:** Required from day one — late night is a primary trigger moment for our users; the app must not blast them with a white screen at 11 PM
- **Background:** Deep slate or warm dark in dark mode; warm off-white (#F8F4F0) in light mode
- **Primary action:** Muted teal or forest green — calm authority, not corporate blue or alarming red
- **Severity colors:** Derived from an accessibility-safe palette; avoid traffic-light defaults (red/yellow/green carry too much cultural baggage for an anxiety context)
- **Typography:** System font (SF Pro on iOS, Roboto on Android) — no decorative fonts, no weight-adding custom loading
- **Motion:** Minimal, purposeful transitions only — no bouncy animations that feel playful in a context that should feel grounded

---

## 11. Out of Scope

| Feature | Reason |
|---|---|
| Cloud sync / account system | Permanently excluded — architectural principle, not a timing call |
| Any backend service or API | Zero network calls is a hard constraint |
| Analytics or crash reporting SDKs | All require outbound network; excluded by the no-backend constraint |
| AI-generated advice or chatbot | Requires backend inference; also carries regulatory and liability risk |
| Community or social features | Requires backend; anxiety users value privacy |
| In-app purchases | Monetization is post-PMF |
| PHQ-9 (depression) or other instruments | Focus; v2 candidate (local-only, same architecture) |
| Wearable integration | Scope; v2 candidate |
| Clinician-facing dashboard | Different product, different regulatory path |

---

## 12. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| User misinterprets score as a diagnosis | High | High | Explicit disclaimer on every result screen; copy written with clinical advisor |
| User in crisis is not adequately served | Low | Critical | Crisis resources visible from all screens; result screen detects severe score and leads with crisis line |
| Data breach of sensitive mental health data | Very Low | High | No network calls = no remote attack surface; local DB excluded from cloud backup; delete-all wipes device storage |
| User loses data when switching devices | Medium | Medium | Expected trade-off of the no-backend decision; disclosed upfront in onboarding; export/share partially mitigates |
| App Store rejection for health claims | Medium | Medium | Do not claim diagnostic capability; describe as "screening tool" per App Store Health guidelines |
| Low retention (single-use tool) | High | High | Reminder system, history/trend chart, and framing around "track over time" from onboarding |
| Incorrect GAD-7 implementation | Low | High | Use verbatim wording from Spitzer et al. 2006; have clinical advisor review before launch |
| Future team member adds a network call "just for analytics" | Medium | High | No-network constraint documented here and enforced in code review; traffic audit in CI before each release |

---

## 13. Milestones

| Milestone | Deliverable | Target |
|---|---|---|
| M0 — Foundation | Flutter project setup, routing, local SQLite (Hive/Drift), design tokens, no-network lint rule | Week 1 |
| M1 — Core Loop | Onboarding → Assessment → Result (no history, no reminder) | Week 3 |
| M2 — Retention | History screen, chart, reminders, settings | Week 5 |
| M3 — Polish | Accessibility audit, localization (id/en), copy review with clinical advisor | Week 6 |
| M4 — Launch Prep | App Store / Play Store assets, privacy policy, network traffic audit (zero outbound calls verified), beta testing (TestFlight / internal track) | Week 7 |
| Launch | Public release | Week 8 |

---

## 14. Open Questions

| # | Question | Owner | Due |
|---|---|---|---|
| 1 | Do we need a clinical advisor to review result copy before launch? | PM | Week 1 |
| 2 | Which crisis resources and EAP platforms are most common among Indonesian employers (for the 9-5 worker persona)? | PM | Week 1 |
| 3 | Is local SQLite sufficient or should we plan for encrypted SQLite (sqlcipher) from day one? | Tech Lead | Week 1 |
| 4 | Will we localize into Bahasa Indonesia first or ship English-only in beta? Given primary persona is Indonesian, Bahasa Indonesia should be default | PM | Week 2 |
| 5 | Who owns content updates if crisis line numbers change? | PM | Before launch |
| 6 | Should the history chart distinguish weekday vs weekend data points to help users identify work-week anxiety patterns? | Design | Week 3 |
| 7 | What is the right default notification time — 7:30 PM weekday or Sunday evening? Validate with 5 users from target persona before shipping reminders | PM | Week 5 |

---

## 15. References

- Spitzer, R.L., Kroenke, K., Williams, J.B.W., & Löwe, B. (2006). A brief measure for assessing generalized anxiety disorder. *Archives of Internal Medicine*, 166(10), 1092–1097.
- GAD-7 is free to use for non-commercial purposes. Pfizer holds copyright; permission is granted for clinical, educational, and research use.
- Into The Light Indonesia: [https://www.intothelightid.org](https://www.intothelightid.org)
- Indonesia mental health crisis line: 119 extension 8

---

*This PRD is a living document. Changes require a version bump and a note in the changelog below.*

## Changelog

| Version | Date | Author | Change |
|---|---|---|---|
| 1.0 | 2026-05-09 | Product Team | Initial draft |
| 1.1 | 2026-05-09 | Product Team | Hardened no-backend constraint throughout; added §7 Technical Architecture; updated Out of Scope, Risks, and all v1-qualified language to permanent decisions |
| 1.2 | 2026-05-09 | Product Team | Refined target users to Gen Z/Millennial 9-5 workers and sandwich generation; updated Problem Statement, copy tone, next steps (EAP), reminders (default time), history (day-of-week), and Design Direction (dark mode, anti-corporate-wellness principles) |
