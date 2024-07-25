import 'package:flower_store/constants/colors.dart';
import 'package:flower_store/models/authorize/signup.model.dart';
import 'package:flower_store/screens/welcome/login.screen.dart';
import 'package:flower_store/services/authorize.service.dart';
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flower_store/screens/welcome/login.screen.dart';
import 'package:flower_store/shared/components/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerForm = GlobalKey<FormBuilderState>();
  static AuthorizeService authorizeService = AuthorizeService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: gradientBackground),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Image.asset(
                    'assets/images/logo_shop.png',
                    width: 200,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Đăng Ký',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilder(
                    key: _registerForm,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: getRegisterForm()
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getRegisterForm() {
    return [
      genericFieldContainer(
        field: FormBuilderTextField(
          name: 'name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          decoration: genericInputDecoration(
            label: 'Tên',
            prefixIcon: Icons.person_2_outlined,
          ),
        ),
      ),
      genericFieldContainer(
        field: FormBuilderTextField(
          name: 'email',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
          decoration: genericInputDecoration(
            label: 'Email',
            prefixIcon: Icons.email_outlined,
          ),
        ),
      ),
      genericFieldContainer(
        field: FormBuilderTextField(
          name: 'phone',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.maxLength(12),
            FormBuilderValidators.minLength(10),
            FormBuilderValidators.numeric(),
          ]),
          decoration: genericInputDecoration(
            label: 'Số Điện Thoại',
            prefixIcon: Icons.phone_android_outlined,
          ),
        ),
      ),
      genericFieldContainer(
        field: FormBuilderTextField(
          name: 'password',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ]),
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: genericInputDecoration(
            label: 'Mật Khẩu',
            prefixIcon: Icons.password_outlined,
          ),
        ),
      ),
      const SizedBox(height: 20),
      MaterialButton(
        color: const Color(0xFFFFEED0),
        minWidth: double.infinity,
        padding: const EdgeInsets.all(15),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        elevation: 10,
        focusElevation: 5,
        onPressed: () {
          // Validate and save the form values
          if(_registerForm.currentState!.saveAndValidate()) {
            AccountModel data = AccountModel();
            data.fromJsonMapping(_registerForm.currentState!.value);

            authorizeService.signup(data)
            .then((val) => Navigator
                .of(context)
                .push(MaterialPageRoute(builder: (context) => const LoginScreen())))
            .catchError((onError) => debugPrint(onError.toString())); 
            
          }
        },
        child: const Text(
          'Đăng Ký',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginScreen()),
          );
        },
        child: const Text(
          'Đã có tài khoản ?',
          style: TextStyle(color: Color(0xff920000)),
          textAlign: TextAlign.right,
        ),
      ),
    ];
  }
}
