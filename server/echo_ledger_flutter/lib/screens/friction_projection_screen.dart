import 'package:flutter/material.dart';

import 'package:echo_ledger_client/server_client.dart';
import '../services/serverpod_client.dart';

class FrictionProjectionScreen extends StatefulWidget {
  const FrictionProjectionScreen({super.key});

  @override
  State<FrictionProjectionScreen> createState() =>
      _FrictionProjectionScreenState();
}

class _FrictionProjectionScreenState extends State<FrictionProjectionScreen> {
  final _userIdController = TextEditingController(text: '1');
  final _perceivedEffortController = TextEditingController(text: '5');

  final List<String> _categories = <String>[
    'Health',
    'Work',
    'Learning',
    'Finance',
  ];

  String _selectedCategory = 'Learning';

  bool _isLoading = false;
  bool _isSeeding = false;
  bool _isClearing = false;
  String? _errorMessage;
  String? _seedMessage;
  FrictionProjection? _projection;

  Future<void> _clearDemoData() async {
    setState(() {
      _isClearing = true;
      _seedMessage = null;
      _errorMessage = null;
      _projection = null;
    });
    try {
      final result = await client.seed.clearDemoData();
      setState(() {
        _seedMessage = result;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _seedMessage = 'Error: $e';
      });
    } finally {
      if (mounted) {
        setState(() => _isClearing = false);
      }
    }
  }

  Future<void> _seedDemoData() async {
    setState(() {
      _isSeeding = true;
      _seedMessage = null;
      _errorMessage = null;
    });

    try {
      final result = await client.seed.seedDemoData();
      setState(() {
        _seedMessage = result;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _seedMessage = 'Error: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSeeding = false;
        });
      }
    }
  }

  Future<void> _runProjection() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userId = int.tryParse(_userIdController.text);
      final perceivedWeeklyEffort = double.tryParse(
        _perceivedEffortController.text,
      );

      if (userId == null || perceivedWeeklyEffort == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Please enter valid numeric values.';
        });
        return;
      }

      final result = await client.frictionProjection.project(
        userId,
        _selectedCategory,
        perceivedWeeklyEffort,
      );

      setState(() {
        _projection = result;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _perceivedEffortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historical Friction Projection'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'User ID',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              items: _categories
                  .map(
                    (c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(c),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                });
              },
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _perceivedEffortController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Perceived weekly effort (hours)',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _runProjection,
                child: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Run projection'),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Demo:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                TextButton.icon(
                  onPressed: _isClearing ? null : _clearDemoData,
                  icon: _isClearing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.delete_sweep_outlined, size: 18),
                  label: const Text('Clear demo data'),
                ),
                TextButton.icon(
                  onPressed: _isSeeding ? null : _seedDemoData,
                  icon: _isSeeding
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_fix_high, size: 18),
                  label: const Text('Seed demo data'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_seedMessage != null)
              Card(
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _seedMessage!,
                    style: TextStyle(color: Colors.green[900]),
                  ),
                ),
              ),
            if (_seedMessage != null) const SizedBox(height: 8),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (_projection != null && _errorMessage == null)
              _ProjectionResultView(
                projection: _projection!,
                perceivedWeeklyEffort: double.tryParse(
                  _perceivedEffortController.text,
                ),
                onAdjustParameters: () => setState(() => _projection = null),
                onProceedAnyway: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Noted. Good luck with your commitment!"),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _ProjectionResultView extends StatelessWidget {
  final FrictionProjection projection;
  final double? perceivedWeeklyEffort;
  final VoidCallback? onAdjustParameters;
  final VoidCallback? onProceedAnyway;

  const _ProjectionResultView({
    required this.projection,
    this.perceivedWeeklyEffort,
    this.onAdjustParameters,
    this.onProceedAnyway,
  });

  bool get _hasHighFriction =>
      projection.avgWeeklyEffortOverrunPct >= 20 ||
      projection.regretLikelihoodPct >= 50;

  String get _frictionLevel =>
      _hasHighFriction ? 'High' : (projection.similarCommitmentCount > 0 ? 'Moderate' : 'Low');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final n = projection.similarCommitmentCount;
    final overrun = projection.avgWeeklyEffortOverrunPct;
    final dropWeek = projection.mostCommonDropOffWeek;
    final regret = projection.regretLikelihoodPct;
    final perceived = perceivedWeeklyEffort ?? 0.0;
    final avgActual = perceived > 0
        ? perceived * (1 + overrun / 100)
        : 0.0;

    if (n == 0) {
      return Card(
        margin: const EdgeInsets.only(top: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No historical data yet',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Echo Ledger learns from your experience. '
                'Complete a commitment in this category and log it, then return '
                'for a personalized friction projection.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (_hasHighFriction)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.warning_amber_rounded,
                        color: theme.colorScheme.error, size: 24),
                  ),
                Expanded(
                  child: Text(
                    'Historical Friction: $_frictionLevel',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _hasHighFriction
                          ? theme.colorScheme.error
                          : theme.textTheme.titleMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _narrativeBullet(
              icon: Icons.insights,
              title: "You've tried this $n time${n == 1 ? '' : 's'} before",
            ),
            if (perceived > 0 && n > 0) ...[
              const SizedBox(height: 8),
              _narrativeBullet(
                icon: Icons.schedule,
                title: 'Effort reality check',
                body: 'You think: ${perceived.toStringAsFixed(0)} hrs/week · '
                    'You actually spent: ~${avgActual.toStringAsFixed(1)} hrs/week (+${overrun.toStringAsFixed(0)}%)\n'
                    '→ Consider planning for ${avgActual.toStringAsFixed(0)}–${(avgActual + 1).toStringAsFixed(0)} hours instead.',
              ),
            ],
            if (dropWeek != null) ...[
              const SizedBox(height: 8),
              _narrativeBullet(
                icon: Icons.trending_down,
                title: 'Consistency risk',
                body: 'Typical drop-off: Week $dropWeek\n'
                    '→ Schedule an accountability check-in for Week $dropWeek.',
              ),
            ],
            if (regret > 0) ...[
              const SizedBox(height: 8),
              _narrativeBullet(
                icon: Icons.sentiment_dissatisfied_outlined,
                title: 'Regret likelihood: $regret%',
                body: regret >= 100 && n > 0
                    ? 'In past attempts you reflected that you regretted starting.'
                    : 'Based on your reflections, $regret% of the time you regretted starting.',
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Pattern at a glance',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _MetricCard(
                  label: 'Similar commitments',
                  value: '$n',
                ),
                _MetricCard(
                  label: 'Avg overrun',
                  value: '${overrun.toStringAsFixed(1)}%',
                ),
                _MetricCard(
                  label: 'Drop-off week',
                  value: dropWeek?.toString() ?? 'None',
                ),
                _MetricCard(
                  label: 'Regret likelihood',
                  value: '$regret%',
                ),
              ],
            ),
            if (onAdjustParameters != null || onProceedAnyway != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onAdjustParameters != null)
                    TextButton(
                      onPressed: onAdjustParameters,
                      child: const Text('Adjust parameters'),
                    ),
                  if (onProceedAnyway != null) ...[
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: onProceedAnyway,
                      child: const Text('Proceed anyway'),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _narrativeBullet({
    required IconData icon,
    required String title,
    String? body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (body != null && body.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
