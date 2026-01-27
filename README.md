# Echo Ledger

![Tests Passing](https://img.shields.io/badge/tests-18%20passing-brightgreen)
![Serverpod](https://img.shields.io/badge/built%20with-Serverpod%203-blue)

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
Echo Ledger's value compounds over time. 
That requires:
​- Persistent state across months/years
- Longitudinal analysis of user patterns​
- Future: scheduled re-evaluation, trend detection​
Serverpod is not optional infrastructure — it is the product.

## Why Deterministic (No AI)?

Echo Ledger intentionally uses deterministic calculations instead of AI for three reasons:

1. **Transparency**: You can see exactly how your projection is calculated
   - Overrun % = (avg actual − perceived) / perceived
   - Regret likelihood = reflections with score ≥ 3 / total reflections
   - Drop-off week = most frequent skipped week

2. **Trust**: No "black box" predictions or hallucinations
   - Every metric is derived from your own logged data
   - No external models or training data influencing results

3. **Debuggability**: When something seems wrong, you can verify the data
   - Seed endpoint shows example data structure
   - Integration tests validate calculations
   - No "the model said so" explanations

Future versions may add AI for *explaining patterns* (e.g. optional Gemini integration), but core projections remain deterministic and verifiable.

## Repository Structure
- `server/echo_ledger_flutter` – Flutter client
- `server/echo_ledger_server` – Serverpod backend
- `server/echo_ledger_client` – generated client


