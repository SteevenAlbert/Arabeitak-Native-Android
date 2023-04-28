import 'package:arabeitak_flutter_ui/domain/models/car.dart';

import 'user.dart';

class Owner extends User {
  List<Car>? cars;

  Owner(uid, name, email, password)
      : super(
            uid: uid,
            name: name,
            email: email,
            password: password,
            type: 'owner');
}
