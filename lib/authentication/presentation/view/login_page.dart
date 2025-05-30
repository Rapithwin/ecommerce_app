import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/authentication/presentation/bloc/login_bloc.dart';
import 'package:e_commerce/authentication/presentation/view/signup_page.dart';
import 'package:e_commerce/extensions.dart';
import 'package:e_commerce/profile/presentation/widgets/custom_form_field.dart';
import 'package:e_commerce/root/view/root.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<LoginPage> route() {
    return MaterialPageRoute(
      builder: (_) => const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        context.read<AuthRepository>(),
        context.read<AuthBloc>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "ورود",
            textDirection: TextDirection.rtl,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            final errorMessage = state.error;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    errorMessage.authErrorTranslate,
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onError,
                    ),
                  ),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacement(context, RootPage.route());
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: <Widget>[
                  CustomFormField(
                    labelName: "ایمیل",
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  CustomFormField(
                    labelName: "رمز عبور",
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 1,
                    obscureText: true,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final bool isLoading = state is LoginLoading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  final UserModel userData = UserModel(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<LoginBloc>().add(
                                        LoginSubmitted(userData),
                                      );
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Visibility(
                                visible: isLoading,
                                child: const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                              Text(
                                "ورود",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      SignupPage.route(),
                    ),
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(
                        theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.tertiaryFixed,
                        ),
                      ),
                    ),
                    child: const Text(
                      "حساب کاربری ندارید؟ ثبت نام کنید.",
                      textDirection: TextDirection.rtl,
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

  String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "این فیلد نباید خالی باشد";
    }
    return null;
  }
}
