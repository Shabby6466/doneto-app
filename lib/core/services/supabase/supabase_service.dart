// import 'package:doneto/core/di/di.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// abstract class SupabaseService {
//   const SupabaseService();
//
//   Future<void> signUp({required String name, required String email, required String password});
//
//   Future<void> signIn({required String email, required String password});
//
//   Future<void> signOut();
//
//   Future<void> signInWithGoogle();
//
//   User? get currentUser;
// }
//
// @Singleton(as: SupabaseService)
// class SupabaseServiceImp implements SupabaseService {
//   final SupabaseClient _client;
//
//   SupabaseServiceImp(this._client);
//
//   @override
//   Future<void> signUp({required String name, required String email, required String password}) async {
//     try {
//       final AuthResponse res = await _client.auth.signUp(email: email, password: password);
//
//       final user = res.user;
//       if (user == null) {
//         throw Exception('No user returned from supabase.auth.signUp()');
//       }
//
//       // 2) Insert into your `public.users` table
//       await _client.from('users').insert({
//         'id': user.id,
//         'name': name,
//         'email': email,
//       });
//     } on AuthException catch (e) {
//       sl<Logger>().e('SIGN UP SUPABASE AUTH ERROR | $e');
//       throw Exception(e.message);
//     } on PostgrestException catch (e) {
//       sl<Logger>().e('SIGN UP SUPABASE POSTGRESS ERROR | $e');
//     }
//   }
//
//   @override
//   Future<void> signIn({required String email, required String password}) async {
//     try {
//       await _client.auth.signInWithPassword(email: email, password: password);
//     } on AuthException catch (e) {
//       sl<Logger>().e('SIGN IN SUPABASE ERROR | $e');
//       throw Exception(e.message);
//     }
//   }
//
//   @override
//   Future<void> signOut() async {
//     try {
//       await _client.auth.signOut();
//     } on AuthException catch (e) {
//       sl<Logger>().e('SIGN OUT SUPABASE ERROR | $e');
//       throw Exception(e.message);
//     }
//   }
//   @override
//   Future<void> signInWithGoogle() async {
//     try {
//       await _client.auth.signInWithOAuth(OAuthProvider.google);
//     } on AuthException catch (e) {
//       sl<Logger>().e('GOOGLE SIGN IN ERROR | $e');
//       throw Exception(e.message);
//     }
//   }
//
//   @override
//   User? get currentUser => _client.auth.currentUser;
// }
