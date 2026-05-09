# PRD — Saujana: GAD-7 Anxiety Screening App

**Version:** 1.1  
**Date:** 2026-05-09  
**Status:** Draft  
**Author:** Product Team  

---

## 1. Executive Summary

Saujana is a fully offline, zero-backend mobile application (Flutter, iOS & Android) that helps users recognize and track generalized anxiety symptoms using the clinically validated GAD-7 screening instrument. The app guides users through the 7-question assessment, provides a scored result with contextual interpretation, tracks results over time on-device, and surfaces clear next steps — including when to seek professional help.

**Architectural constraint:** Saujana has no backend, no server, no network dependency, and no cloud sync — permanently. All data lives exclusively on the user's device in a local database. This is a product and architectural decision, not a deferral.

The name *Saujana* (Malay/Indonesian: "as far as the eye can see") reflects the goal: giving users perspective on their own mental state that they could not see clearly on their own.

---

## 2. Problem Statement

### The Real Problem (Mom Test Validated)

> The Mom Test principle: don't ask "would you use this?" — look at what people already do.

Observable behaviors that confirm the problem exists:

- People already search "am I anxious test", "anxiety quiz", and "GAD-7 online" millions of times per month — they self-diagnose with low-quality, un-scored web pages.
- Users report describing anxiety symptoms to a GP and being told "you seem fine" because the conversation is unstructured; they leave without validated evidence of what they're experiencing.
- People track mood in Notes, spreadsheets, or journaling apps with no clinical framework — data exists but is not actionable.
- Mental health waitlists in most countries are 3–12 months. Users need something between "nothing" and "weekly therapy."

### What People Do Today (Current Behavior)

| Behavior | Pain it reveals |
|---|---|
| Google symptoms, read WebMD | No personalized scoring or tracking |
| Fill paper GAD-7 at a clinic visit | Infrequent, no history, no context |
| Tell friends "I've been stressed" | Vague; not actionable; social pressure distorts honesty |
| Download generic wellness apps | Meditations don't address the need to know "how bad is it?" |

### What We Are NOT Solving

- Therapy or clinical diagnosis (we are a screening tool, not a clinician)
- Replacing GP or psychiatrist visits
- Crisis intervention (we will always surface emergency resources but that is not our core loop)

---

## 3. Target Users

### Primary: The Undiagnosed Worrier (Ages 18–40)

**Profile:**
- Has experienced recurring anxious thoughts, restlessness, or sleep disruption for weeks
- Has never been formally screened or diagnosed
- Is curious whether what they feel is "normal" or clinically significant
- Will not book a therapy appointment without evidence it is needed ("I don't want to waste a therapist's time")

**Key insight from Mom Test framing:** They don't want to be told they're anxious. They want *permission* — a credible signal that their experience warrants attention. The GAD-7 score gives them that.

### Secondary: The Already-Aware Tracker (Ages 25–50)

**Profile:**
- Has been diagnosed with GAD or depression previously
- Is in or between therapy and wants to self-monitor
- Uses apps habitually to track habits, health, and mood
- Wants to share a score history with their therapist to save session time

### Out-of-Scope Users (for v1)

- Users in acute psychiatric crisis (we will redirect, not serve)
- Children under 18 (GAD-7 not validated for this group)
- Clinical professionals (different product, different regulatory path)

---

## 4. Goals & Success Metrics

### Product Goals

| Goal | Why It Matters |
|---|---|
| Users complete the GAD-7 in under 3 minutes | Completion is the core action; friction kills it |
| Users understand their score without reading a manual | If they need to Google the result, we failed |
| Users return to take the assessment again in 2–4 weeks | Single-shot use = no retention, no value from tracking |
| Users who score Moderate+ know a concrete next step | Impact requires action, not just awareness |

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
As a user with a Moderate or Severe score, I want to see specific, actionable next steps (talk to a GP, find a therapist, crisis line), so that the score leads somewhere useful and not just alarming.

**US-05 — History Tracking**  
As a returning user, I want to see a timeline of my past scores so that I can understand whether my anxiety has improved, worsened, or stayed the same.

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

> **Mild (5–9):** You're experiencing some anxiety symptoms. Many people have periods like this, especially during stressful times. Keeping an eye on how you feel over the next 2 weeks is a good idea.

> **Moderate (10–14):** Your symptoms suggest a moderate level of anxiety that may be affecting your daily life. Talking to a GP or mental health professional is a worthwhile step — your score gives you something concrete to show them.

> **Severe (15–21):** Your score indicates significant anxiety. Please consider reaching out to a healthcare professional soon. This level of anxiety is treatable and you don't have to manage it alone.

---

### 6.4 Next Steps (Must Have — v1)

Shown automatically when score ≥ 10 (Moderate or Severe). Accessible via a link for all scores.

- [ ] "Talk to your GP" — with brief script: "I've been tracking anxiety symptoms and my GAD-7 score is [X]."
- [ ] "Find a therapist" — deep-link to local mental health directory (configurable per region; v1: Indonesia → Into The Light, Yayasan Pulih)
- [ ] "Crisis support" — always visible at bottom: Into The Light Indonesia (119 ext 8), or equivalent for user's locale
- [ ] Emergency resources never hidden behind score threshold — accessible from any screen via a persistent help icon

---

### 6.5 History & Trends (Must Have — v1)

- [ ] List view of all past assessments: date, score, severity label
- [ ] Simple line chart showing score over time (x-axis: date, y-axis: 0–21, severity bands as background shading)
- [ ] Tap a past entry to see full result breakdown
- [ ] Delete individual entry (with confirmation dialog)
- [ ] All data stored in local SQLite database (Hive or Drift); no network calls, no sync of any kind — ever

---

### 6.6 Reminders (Should Have — v1)

- [ ] After completing assessment, prompt: "Would you like a reminder to check in again?" with date picker defaulting to +14 days
- [ ] Local push notification at selected time
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

1. **Calm, not clinical** — The aesthetic should feel like a trusted friend, not a hospital form. Avoid white-coat UI patterns.
2. **Score is the hero** — Every screen either leads to the score or helps the user act on it.
3. **No dark patterns** — No guilt-trip notifications, no streak pressure, no artificially alarming score presentation.
4. **Honest copy** — Write like a knowledgeable friend (Mom Test principle: people trust specific, concrete language over corporate hedging).

### Color Palette Direction

- Background: warm off-white (#F8F4F0 or similar)
- Primary action: muted teal or forest green (calm, not corporate)
- Severity colors: derived from accessibility-safe palette (not the default red/yellow/green traffic light)
- Typography: system font (SF Pro / Roboto) — no custom font loading adds weight without benefit

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
| 2 | Which crisis resources do we list for the Indonesian market by default? | PM | Week 1 |
| 3 | Is local SQLite sufficient or should we plan for encrypted SQLite (sqlcipher) from day one? | Tech Lead | Week 1 |
| 4 | Will we localize into Bahasa Indonesia first or ship English-only in beta? | PM | Week 2 |
| 5 | Who owns content updates if crisis line numbers change? | PM | Before launch |

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
