import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RealtimeDatabaseTestFirebaseUser {
  RealtimeDatabaseTestFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

RealtimeDatabaseTestFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RealtimeDatabaseTestFirebaseUser>
    realtimeDatabaseTestFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<RealtimeDatabaseTestFirebaseUser>(
            (user) => currentUser = RealtimeDatabaseTestFirebaseUser(user));
