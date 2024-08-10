import 'package:events_dashboard/core/config/extensions/context_extensions.dart';
import 'package:events_dashboard/core/config/extensions/string_extensions.dart';
import 'package:events_dashboard/core/config/extensions/widget_extensions.dart';
import 'package:events_dashboard/core/utils/main_text_field.dart';
import 'package:events_dashboard/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:events_dashboard/features/main/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _userNameController =
        TextEditingController(text: 'omar1234kaialy@gmail.com');
    _passwordController = TextEditingController(text: '12345678');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocProvider(
          create: (context) => AuthBloc(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (c, s) {
              if (s.status == CubitStatus.success) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const MainScreen();
                }));
              }
            },
            builder: (BuildContext context, AuthState state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Text(
                        'Chic Events Dash',
                        style: TextStyle(
                          color: context.primaryColor,
                          fontFamily: 'Pacifico',
                          fontSize: 50,
                        ),
                      ).center(),
                    ),
                    MainTextField(
                      text: 'E-mail',
                      validator: (e) {
                        if (e.validateEmail()) {
                        } else {
                          return 'Please Add A Valid Email';
                        }
                        return null;
                      },
                      controller: _userNameController,
                    ),
                    20.verticalSpace,
                    MainTextField(
                      text: 'Password',
                      isPassword: true,
                      validator: (p) {
                        if (p.isValidPassword) {
                        } else {
                          return 'Please Add A Valid Password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      text: 'Login',
                      color: context.primaryColor,
                      width: context.width(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(LoginEvent(
                              email: _userNameController.text,
                              password: _passwordController.text));
                        }
                      },
                    ),
                    /*const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(serviceLocator<LocalizationClass>().appLocalizations!.orContinueWith),
                      const SizedBox(height: 5),
                      MainButton(
                        text: 'Google',
                        color: Colors.red,
                        width: context.width,
                        onPressed: () {
                          Helper.setNotFirstTimeOpeningApp();
                        },
                      ),
                      const SizedBox(height: 10),
                      MainButton(
                        text: 'Facebook',
                        color: Colors.blue,
                        width: context.width,
                        onPressed: () => Helper.setNotFirstTimeOpeningApp(),
                      ),
                    ],
                  ),*/
                  ],
                ),
              );
            },
          ),
        ).paddingAll(25).scrollable());
  }
}
