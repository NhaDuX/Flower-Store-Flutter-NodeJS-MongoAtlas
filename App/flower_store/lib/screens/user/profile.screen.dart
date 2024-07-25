import 'package:flower_store/data/api_repository.dart';
import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flower_store/services/share_pre.dart';
import 'package:flower_store/services/sqlite_pro5.dart';
import 'package:flutter/material.dart';
import 'package:flower_store/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Inter',
    color: Color(0xff000000),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle inputtextStyle = TextStyle(
    fontFamily: 'Inter',
    color: Color(0xff544C4C),
    fontSize: 14,
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  String? _id;
  String? avatarLink;
  bool _isPasswordVisible = false;

  static final APIRepository apiRepository = APIRepository();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  final SQLiteService sqliteService = SQLiteService();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    // Load user info from SharedPreferences
    AccountModel? account = await sharedPreferencesService.getAccountInfo();
    if (account != null) {
      setState(() {
        _id = account.accountID;
        _phoneController.text = account.phone;
        _nameController.text = account.name;
        _emailController.text = account.email;
        _passwordController.text = account.password;
      });
    }

    // Load avatar link from SQLite
    String? link = await sqliteService.getAvatarLink();
    setState(() {
      avatarLink = link;
      if (link != null) {
        _avatarController.text = link;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  Future<void> _saveAvatarLink() async {
    if (_avatarController.text.isNotEmpty) {
      if (avatarLink == null) {
        await sqliteService.saveAvatarLink(_avatarController.text);
      } else {
        await sqliteService.updateAvatarLink(_avatarController.text);
      }
      setState(() {
        avatarLink = _avatarController.text;
      });
    }
  }

  Future<void> _updateProfile() async {
    // Create an AccountModel with the updated data
    AccountModel account = AccountModel()
      ..accountID = _id ?? '' // Use the loaded ID
      ..name = _nameController.text
      ..email = _emailController.text
      ..phone = _phoneController.text
      ..password = _passwordController.text;

    // Call the updateProfile method
    bool success = await apiRepository.updateProfile(account);

    if (success) {
      // Update SharedPreferences with the latest data
      await sharedPreferencesService.saveAccountInfo(account);
      Fluttertoast.showToast(
        msg: "Cập nhật thông tin thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 136, 244, 140),
        textColor: Colors.black,
        fontSize: 16.0
      );
      // Navigate to MainPageScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPageScreen(),
        ),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xffF0F0F0),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xffF0F0F0)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5.0),
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    avatarLink ??
                                        'https://i.pinimg.com/originals/5c/e6/ec/5ce6ec7936ed9aa8c2dd89fe540e36a1.jpg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16.0),
                              const Text('Tên', style: titleStyle),
                              const SizedBox(height: 8.0),
                              TextField(
                                controller: _nameController,
                                style: inputtextStyle,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Text('Email', style: titleStyle),
                              const SizedBox(height: 8.0),
                              TextField(
                                style: inputtextStyle,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Text('Mật khẩu', style: titleStyle),
                              const SizedBox(height: 8.0),
                              TextField(
                                style: inputtextStyle,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !_isPasswordVisible,
                              ),
                              const SizedBox(height: 16.0),
                              const Text('Số điện thoại', style: titleStyle),
                              const SizedBox(height: 8.0),
                              TextField(
                                controller: _phoneController,
                                style: inputtextStyle,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Text('Link hình ảnh', style: titleStyle),
                              const SizedBox(height: 8.0),
                              TextField(
                                controller: _avatarController,
                                style: inputtextStyle,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: iconColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await _saveAvatarLink();
                                        await _updateProfile();
                                      },
                                      child: const Text(
                                        'Lưu và thay đổi',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
