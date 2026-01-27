import 'package:flutter/material.dart';

/// Intro "Story Mode" screen shown on first load.
/// Explains the problem and value prop before the projection UI.
class OnboardingScreen extends StatelessWidget {
  final VoidCallback onDone;

  const OnboardingScreen({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heading = theme.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Echo Ledger', style: heading),
                const SizedBox(height: 24),
                Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ever commit to something, then quit?\n"
                          "Same commitment, same week, every time?\n\n"
                          "You're not lazy. You're optimistic.",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Echo Ledger confronts optimism with evidence.\n\n'
                          'Before committing, see:\n'
                          '  • Your actual effort vs. perceived effort\n'
                          '  • When you typically give up\n'
                          '  • How often you regretted starting\n\n'
                          'No advice. No judgment. Just your data.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: onDone,
                  child: const Text('Try Demo (Seed Data Included)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
