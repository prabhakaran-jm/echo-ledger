# Echo Ledger

Echo Ledger is a Flutter + Serverpod application that helps users make sustainable commitments by confronting optimism with evidence.

Instead of asking “Can I do this?”, Echo Ledger asks:
> “What actually happened last time you tried something like this?”

## Core Concept
Echo Ledger builds a personal historical ledger of commitments and uses that data to generate a **Historical Friction Projection** when a user considers a new commitment.

The system highlights:
- historical effort deviation
- consistency decay patterns
- spillover costs
- regret likelihood based on the user’s own past behavior

No advice. No judgment. Just evidence.

## Tech Stack
- Flutter (client)
- Serverpod 3 (stateful Dart backend)
- Dart (shared models and logic)
- Optional: Gemini API for pattern explanation (non-core)

## Why Serverpod
Echo Ledger’s value increases over time.
That requires:
- persistent state
- longitudinal analysis
- backend workflows
- scheduled re-evaluation logic

Serverpod is not optional infrastructure — it is the product.

## Repository Structure
- `/flutter_app` – Flutter client
- `/server` – Serverpod backend and generated client
- `/docs` – architecture, data model, demo script


