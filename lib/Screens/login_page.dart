import 'package:flutter/material.dart';
import '../components/CustomTextField.dart';
import '../styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      passController.addListener(() {
        if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
          setState(() {
            isValid = true;
          });
        } else {
          setState(() {
            isValid = false;
          });
        }
      });
    });
    passController.addListener(() {
      emailController.addListener(() {
        if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
          setState(() {
            isValid = true;
          });
        } else {
          setState(() {
            isValid = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE8E9ED),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/bg.png'),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Вход',
                          style: buttonTextStyle,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(2, 28, 96, 0.2),
                                spreadRadius: 10,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          height: 348,
                          width: 327,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 230,
                                child: CustomTextField(
                                  label: 'Email',
                                  custController: emailController,
                                  custObscure: false,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 230,
                                child: CustomTextField(
                                  label: 'Пароль',
                                  custController: passController,
                                  custObscure: true,
                                ),
                              ),
                              const SizedBox(
                                height: 56,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(230, 38),
                                  backgroundColor: isValid
                                      ? primaryColor
                                      : primaryColor.withOpacity(0.5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Войти',
                                  style: secondaryTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

// ignore: must_be_immutable
