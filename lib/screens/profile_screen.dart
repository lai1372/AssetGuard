import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushReplacementNamed('/login');
          }
        }
      } catch (e) {
        if (context.mounted) {
          String errorMessage = 'Error deleting account: $e';

          // Handle re-authentication requirement
          if (e.toString().contains('requires-recent-login')) {
            errorMessage =
                'Please sign out and sign in again before deleting your account.';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.email ?? 'No email',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Account section
          Text(
            'Account',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Email info card
          Card(
            child: ListTile(
              leading: Icon(Icons.email, color: colorScheme.primary),
              title: const Text('Email Address'),
              subtitle: Text(user?.email ?? 'Not available'),
            ),
          ),

          // User ID card
          Card(
            child: ListTile(
              leading: Icon(Icons.fingerprint, color: colorScheme.primary),
              title: const Text('User ID'),
              subtitle: Text(
                user?.uid ?? 'Not available',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Actions section
          Text(
            'Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Sign out button
          Card(
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.orange.shade700),
              title: const Text('Sign Out'),
              subtitle: const Text('Sign out of your account'),
              onTap: () => _signOut(context),
            ),
          ),

          const SizedBox(height: 8),

          // Delete account button
          Card(
            color: Colors.red.shade50,
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text(
                'Permanently delete your account and all data',
              ),
              onTap: () => _deleteAccount(context),
            ),
          ),
        ],
      ),
    );
  }
}
