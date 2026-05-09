# Saujana

A Flutter mobile app for GAD-7 generalized anxiety screening. Fully offline — no backend, no network calls, all data stored locally on-device.

## What it does

- Guides users through the clinically validated GAD-7 questionnaire
- Scores results and explains severity in plain language
- Tracks assessment history over time with a trend chart
- Surfaces next steps and crisis resources for moderate/severe scores
- Sets local reminders to recheck in 2–4 weeks

## Stack

- **Framework:** Flutter (iOS & Android)
- **Local DB:** Hive or Drift (SQLite)
- **State:** Riverpod
- **No backend, no analytics SDK, zero outbound network calls**

## Getting started

```bash
flutter pub get
flutter run
```

Requires Flutter SDK ^3.10.9.

## Documentation

See [PRD.md](PRD.md) for full product requirements.
