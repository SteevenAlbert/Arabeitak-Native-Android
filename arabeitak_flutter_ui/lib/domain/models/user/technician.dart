import 'user.dart';

class Technician extends User {
  Technician(uid, name, email, password)
      : super(
            uid: uid,
            name: name,
            email: email,
            password: password,
            type: 'technician');
}
