import 'package:firebase_storage/firebase_storage.dart';

class FBStorage {
  static Future<String> uploadPhoto(List<int> data) async {
    try {
      final reference = FirebaseStorage.instance.ref().child("images");
      final upload = reference.putData(data);
      final subscription = upload.events.listen(print);
      final snapshot = await upload.onComplete;
      subscription.cancel();
      return (await snapshot.ref.getDownloadURL()).toString();
    } catch (e) {
      print(e);
      return "";
    }
  }
}
