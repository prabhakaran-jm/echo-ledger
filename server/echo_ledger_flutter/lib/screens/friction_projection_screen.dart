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

  String _selectedCategory = 'Health';

  bool _isLoading = false;
  String? _errorMessage;
  FrictionProjection? _projection;

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
      body: Padding(
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
            const SizedBox(height: 16),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (_projection != null && _errorMessage == null)
              _ProjectionResultView(projection: _projection!),
          ],
        ),
      ),
    );
  }
}

class _ProjectionResultView extends StatelessWidget {
  final FrictionProjection projection;

  const _ProjectionResultView({required this.projection});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historical Friction Projection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
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
                  value: '${projection.similarCommitmentCount}',
                ),
                _MetricCard(
                  label: 'Avg overrun',
                  value:
                      '${projection.avgWeeklyEffortOverrunPct.toStringAsFixed(1)}%',
                ),
                _MetricCard(
                  label: 'Drop-off week',
                  value: projection.mostCommonDropOffWeek?.toString() ?? 'None',
                ),
                _MetricCard(
                  label: 'Regret likelihood',
                  value: '${projection.regretLikelihoodPct}%',
                ),
              ],
            ),
          ],
        ),
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
