import 'user.dart';

class Admin extends User {
  Admin(uid, name, email, password)
      : super(
            uid: uid,
            name: name,
            email: email,
            password: password,
            type: 'admin');
}
