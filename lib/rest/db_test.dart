import 'package:firebase/firebase.dart';
import 'package:scrum_poker/rest/firebase_db.dart';

void main() {
  DatabaseReference ref = ScrumPokerFirebase.instance.dbReference;
  ref.push().set({'name': 'Message', 'comment': 'a good season'});
}
