import 'dart:math';

import 'package:flower_store/screens/forgot_password/otp.dart';
import 'package:flower_store/services/authorize.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final authorizeService = AuthorizeService();
  String? error;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20.0, 
                        height: 20.0, 
                        decoration: const BoxDecoration(
                          color: Color(0xffECECEC),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/back_icon.svg',
                            height: 20, // Adjusted icon size
                            width: 20, // Adjusted icon size
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Quên mật khẩu',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Nhập Email của bạn để tạo mật khẩu mới',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff989898),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Email của bạn',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(width: 2, color: Color(0xffE1E1E1)),
                      ),
                      hintText: 'contact@gmail.com',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xff545454),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (error != null) 
                    Center(
                      child: Text(
                        error!,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xfff56789),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        String email = _emailController.text;
                        authorizeService.getByEmail(email)
                          .then((val) {
                            setState(() {
                              error = null;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(account: val),
                              ),
                            );
                          })
                          .catchError((onError) {
                            setState(() {
                              error = 'Email không tồn tại';
                            });
                          });
                      },
                      child: Text(
                        'Tạo mật khẩu mới',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
