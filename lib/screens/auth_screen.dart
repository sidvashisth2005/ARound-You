import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  bool _isLoading = false;
  String? _errorMessage;

  void _trySubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState?.save();
      setState(() { _isLoading = true; _errorMessage = null; });
      try {
        if (_isLogin) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        } else {
          final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'username': _username, 'email': _email, 'createdAt': Timestamp.now(), 'badges': [],
          });
        }
      } on FirebaseAuthException catch (err) {
        setState(() { _errorMessage = err.message ?? 'An error occurred.'; });
      } catch (err) {
        setState(() { _errorMessage = 'An unexpected error occurred. Please try again.'; });
      } finally {
        if (mounted) { setState(() { _isLoading = false; }); }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ARound You', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -2)),
              const SizedBox(height: 8),
              Text('Discover the world around you.', style: TextStyle(fontSize: 16, color: Colors.grey.shade400)),
              const SizedBox(height: 48),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isLogin ? 'Welcome Back' : 'Create Account', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        if (_errorMessage != null)
                          Container(
                            width: double.infinity, padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                            child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent)),
                          ),
                        if (!_isLogin)
                          TextFormField(
                            key: const ValueKey('username'), decoration: const InputDecoration(labelText: 'Username'),
                            validator: (v) => (v == null || v.trim().length < 4) ? 'Username must be at least 4 characters long.' : null,
                            onSaved: (v) => _username = v ?? '',
                          ),
                        const SizedBox(height: 12),
                        TextFormField(
                          key: const ValueKey('email'), decoration: const InputDecoration(labelText: 'Email Address'), keyboardType: TextInputType.emailAddress,
                          validator: (v) => (v == null || !v.contains('@')) ? 'Please enter a valid email address.' : null,
                          onSaved: (v) => _email = v ?? '',
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          key: const ValueKey('password'), decoration: const InputDecoration(labelText: 'Password'), obscureText: true,
                          validator: (v) => (v == null || v.length < 7) ? 'Password must be at least 7 characters long.' : null,
                          onSaved: (v) => _password = v ?? '',
                        ),
                        const SizedBox(height: 24),
                        if (_isLoading) const CircularProgressIndicator()
                        else ElevatedButton(
                          onPressed: _trySubmit, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                          child: Text(_isLogin ? 'Log In' : 'Sign Up'),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => setState(() { _isLogin = !_isLogin; _errorMessage = null; }),
                          child: Text(_isLogin ? 'Create new account' : 'I already have an account', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 