import 'package:flutter/material.dart';

class DataPrivacyScreen extends StatelessWidget {
  const DataPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Privacy & Usage'),
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Right to Be Informed',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We believe in transparency. Here\'s exactly how we collect, use, and protect your information.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // What We Collect
            _DataSection(
              title: 'What Information We Collect',
              colorScheme: colorScheme,
              items: [
                _DataItem(
                  icon: Icons.description,
                  title: 'Report Content',
                  description:
                      'Title, description, and timestamps of reports you create or edit.',
                ),
                _DataItem(
                  icon: Icons.account_circle,
                  title: 'Account Information',
                  description:
                      'Your email address and authentication data for secure login.',
                ),
                _DataItem(
                  icon: Icons.history,
                  title: 'Activity Records',
                  description:
                      'Actions taken on reports (create, update, delete) for audit and security purposes. Your personal data is not associated with these logs, and they are stored separately from your report data.',
                ),
                _DataItem(
                  icon: Icons.access_time,
                  title: 'Timestamps',
                  description:
                      'When you create and modify reports to track changes over time. Your personal data is not associated with these timestamps, and they are stored separately from your report data.',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Why We Collect It
            _DataSection(
              title: 'Why We Collect This Information',
              colorScheme: colorScheme,
              items: [
                _DataItem(
                  icon: Icons.security,
                  title: 'Security & Trust',
                  description:
                      'Audit logs help us detect unauthorized access and maintain system integrity.',
                ),
                _DataItem(
                  icon: Icons.settings,
                  title: 'System Functionality',
                  description:
                      'Your data is essential to provide core features like saving and editing reports.',
                ),
                _DataItem(
                  icon: Icons.build,
                  title: 'Improvements',
                  description:
                      'Usage patterns help us identify bugs, improve performance, and enhance features.',
                ),
                _DataItem(
                  icon: Icons.gavel,
                  title: 'Legal Compliance',
                  description:
                      'We maintain records to comply with data protection and privacy regulations.',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // How We Use It
            _DataSection(
              title: 'How Your Data is Used',
              colorScheme: colorScheme,
              items: [
                _DataItem(
                  icon: Icons.cloud,
                  title: 'Cloud Storage',
                  description:
                      'Your reports are stored securely in Firebase Firestore, encrypted in transit and at rest.',
                ),
                _DataItem(
                  icon: Icons.assessment,
                  title: 'Audit Logging',
                  description:
                      'Each action is logged to an audit trail for accountability and troubleshooting.',
                ),
                _DataItem(
                  icon: Icons.block,
                  title: 'What We Don\'t Do',
                  description:
                      'We never sell, share, or use your data for advertising. No third-party analytics.',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Data Retention
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.orange.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Data Retention Policy',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your active reports are kept indefinitely while your account is active. Upon account deletion, all personal data is removed within 30 days, except where legally required to retain records.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Contact & Support
            Card(
              color: colorScheme.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Questions or Concerns?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'If you have questions about your privacy or how we use your data, please contact us at: privacy@assetguard.app',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'To exercise any of your rights, email: support@assetguard.app',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Last Updated
            Center(
              child: Text(
                'Last updated: April 2026',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DataSection extends StatelessWidget {
  final String title;
  final ColorScheme colorScheme;
  final List<_DataItem> items;

  const _DataSection({
    required this.title,
    required this.colorScheme,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => _DataItemWidget(item: item)).toList(),
      ],
    );
  }
}

class _DataItem {
  final IconData icon;
  final String title;
  final String description;

  _DataItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _DataItemWidget extends StatelessWidget {
  final _DataItem item;

  const _DataItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item.icon,
            size: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
