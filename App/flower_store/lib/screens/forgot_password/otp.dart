import 'dart:math';

import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:flower_store/screens/forgot_password/newpassword.dart';
import 'package:flower_store/services/mail.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyCodeScreen extends StatefulWidget {
  final AccountModel account;
  const VerifyCodeScreen({super.key, required this.account});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late List<int> codes = [];
  late String email = '';
  String? error;
  final _codeController =
      List<TextEditingController>.generate(5, (i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    if (codes.isEmpty) send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Xác thực Email',
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
                'Chúng tôi đã gửi mã OTP tới "${widget.account.email}" hãy nhập 5 mã số được gửi vào Email của bạn',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xff989898),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _codeController[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color(0xffE1E1E1),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 25),
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
                    bool correct = true;
                    for (var i = 0; i < _codeController.length; i++) {
                      correct = int.parse(_codeController[i].text) == codes[i];
                    }
                    if (correct) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdatePasswordScreen(account: widget.account),
                        ),
                      );
                    } else {
                      setState(() {
                        error = 'Sai mã OTP';
                      });
                    }
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
              const SizedBox(height: 20),
              GestureDetector(
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Mã chưa được gửi vào Email? ',
                          style: GoogleFonts.inter(
                            color: const Color(0xff989898),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Gửi lại',
                          style: GoogleFonts.inter(
                            color: const Color(0xfff56789),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xfff56789),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => send(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void send() {
    String code = '';
    codes = List.generate(5, (i) => Random().nextInt(10));
    for (var n in codes) {
      code = '$code$n';
    }
    sendEmail(widget.account.email, _emailTemplate(code, widget.account.name), 'Đặt lại mật khẩu').then(
      (a) => setState(() {}),
    );
  }

  String _emailTemplate(String code, String name) {
    return '''<!DOCTYPE html>
      <html>
      <head>
        <style>
          .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 10px;
            font-family: Arial, sans-serif;
            color: #333;
          }
          .header {
            background-color: #F56789;
            color: white;
            padding: 10px;
            text-align: center;
            border-radius: 8px 8px 0 0;
          }
          .content {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 0 0 8px 8px;
          }
          .footer {
            text-align: center;
            padding: 10px 0;
            background-color: #f1f1f1;
            margin-top: 20px;
            border-radius: 8px;
          }
          .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4CAF50;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>Đặt lại mật khẩu</h1>
          </div>
          <div class="content">
            <p>Xin chào $name,</p>
            <p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Đây là mã OTP để đặt lại mật khẩu: <span style="color: red">$code</span></p>
            <p>Nếu không phải bạn yêu cầu, bạn có thể bỏ qua email này.</p>
            <p>Xin cảm ơn,<br>4 MAN FLOWER</p>
          </div>
          <div class="content">
            <p>Hello $name,</p>
            <p>We received a request to reset your password for your account. This is the OTP to reset your password: <span style="color: red">$code</span></p>
            <p>If you did not request a password reset, please ignore this email or contact support if you have questions.</p>
            <p>Thanks,<br>4 MAN FLOWER</p>
          </div>
          <div class="footer">
            <p>&copy; 2024 4 MAN FLOWER. All rights reserved.</p>
          </div>
        </div>
      </body>
      </html>
    ''';
  }
}
