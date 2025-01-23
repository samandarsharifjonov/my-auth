import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> register({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> resetPassword({required BuildContext context, required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Parolni tiklash uchun email yuborildi')),
      );
      notifyListeners();
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Xatolik: $error')),
      );
    }
  }
}
