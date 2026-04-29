import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:asset_guard/firebase_options.dart';
import 'api/api_client.dart';
import 'repositories/report_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Start Firebase and handle any potential errors during startup to ensure the app can still run even if Firebase fails, provide feedback in the console for debugging purposes
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  // Enable Firestore offline persistence with unlimited cache size to allow users to create and view reports even when they are offline, and ensure that data is synced when they come back online
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MyApp());
}
// Main application widget that initializes the ApiClient and ReportRepository, and sets up routing and authentication state management to show the appropriate screens based on whether the user is logged in or not
class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final api = ApiClient();
    final reportRepository = ReportRepository(apiClient: api);

    return MaterialApp(
      title: 'Asset Guard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Still loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // User is logged in
          if (snapshot.hasData) {
            return HomeScreen(reportRepository: reportRepository);
          }

          // User is not logged in
          return const LoginScreen();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(reportRepository: reportRepository),
      },
    );
  }
}
