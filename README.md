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

## Try it

- **Web app:** https://echo-ledger.serverpod.space/app  
- **API:** https://echo-ledger.api.serverpod.space  

Seed demo data (magic-wand icon), then run a projection with User ID 1, Category Learning, Perceived effort 5.

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
- `server/echo_ledger_flutter` – Flutter client
- `server/echo_ledger_server` – Serverpod backend
- `server/echo_ledger_client` – generated client


