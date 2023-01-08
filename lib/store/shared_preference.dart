import 'package:shared_preferences/shared_preferences.dart';

///storing the conext data into local preference so we can pick up where we left off

late final SharedPreferences? preferences;

Future<void> initalizeSharedPreference() async {
  preferences = await SharedPreferences.getInstance();
}

class PreferenceKeys {
  static const String CURRENT_SESSION = "current_session";
  static const String ACTIVE_PARTICIPANT = "active_participant";
}
