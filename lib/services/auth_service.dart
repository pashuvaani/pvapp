import '../models/user_model.dart';

class AuthService {
  UserModel? _currentUser = UserModel(
    id: 'usr_101',
    name: 'Rajesh Kumar',
    email: 'rajesh.k@pashuvaani.com',
    phone: '+91 9876543210',
    role: 'Farmer / Cattle Owner',
    address: 'Anand District, Gujarat',
  );

  UserModel? get currentUser => _currentUser;

  Future<bool> login(String phoneOrEmail, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }

  Future<bool> signup(UserModel newUser) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _currentUser = newUser;
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }
}
