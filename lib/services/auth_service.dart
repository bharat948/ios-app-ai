import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current Firebase user
  User? get currentFirebaseUser => _auth.currentUser;

  // Convert Firebase User to UserModel
  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    
    return UserModel(
      id: user.uid,
      name: user.displayName ?? _getNameFromEmail(user.email ?? ''),
      email: user.email ?? '',
      joinDate: user.metadata.creationTime ?? DateTime.now(),
      accountType: 'Free',
    );
  }

  // Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;

  // Sign in with email and password
  Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign up with email and password
  Future<String?> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      // Update display name
      await userCredential.user?.updateDisplayName(name);
      
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return 'Google Sign-In was cancelled.';
      }
      
      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      // Create credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in to Firebase with Google credential
      await _auth.signInWithCredential(credential);
      
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _getErrorMessage(e);
    } catch (e) {
      return 'Failed to sign in with Google: ${e.toString()}';
    }
  }

  // Sign out
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // Legacy methods for backward compatibility
  Future<bool> login(String email, String password) async {
    final error = await signInWithEmailAndPassword(email, password);
    return error == null;
  }

  Future<bool> signup(String name, String email, String password) async {
    final error = await signUpWithEmailAndPassword(name, email, password);
    return error == null;
  }

  Future<void> logout() async {
    await signOut();
  }

  // Update user profile
  Future<bool> updateProfile(String name, String email) async {
    try {
      await _auth.currentUser?.updateDisplayName(name);
      // Note: Email updates require re-authentication
      return true;
    } catch (e) {
      return false;
    }
  }

  // Helper: Get readable error messages
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  // Helper: Extract name from email
  String _getNameFromEmail(String email) {
    final name = email.split('@').first;
    return name.isNotEmpty
        ? name.substring(0, 1).toUpperCase() + name.substring(1)
        : 'User';
  }
}
