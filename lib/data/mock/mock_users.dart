import '../../models/user_model.dart';

class MockUsers {
  static final UserModel currentUser = UserModel(
    id: 'usr_1',
    name: 'Rajesh Kumar',
    email: 'rajesh.k@pashuvaani.com',
    phone: '+91 9876543210',
    role: 'Farmer / Livestock Owner',
    address: 'Anand District, Gujarat - 388001',
    preferredLanguage: 'English',
  );
}
