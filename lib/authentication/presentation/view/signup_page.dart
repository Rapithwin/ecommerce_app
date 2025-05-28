import 'package:e_commerce/authentication/presentation/bloc/register_bloc.dart';
import 'package:e_commerce/authentication/presentation/view/login_page.dart';
import 'package:e_commerce/extensions.dart';
import 'package:e_commerce/profile/presentation/widgets/custom_form_field.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static Route<SignupPage> route() {
    return MaterialPageRoute(
      builder: (_) => SignupPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        context.read<AuthRepository>(),
      ),
      child: SignupView(),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      _passwordController,
      _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
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
            "ثبت نام",
            textDirection: TextDirection.rtl,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
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
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    "ثبت نام با موفقیت انجام شد",
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.labelLarge,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            Navigator.pushReplacement(context, LoginPage.route());
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
                    validator: (String? value) {
                      if (!value!.isEmailValid) {
                        return "ایمیل نامعتبر";
                      }
                      if (value.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      return null;
                    },
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
                    validator: (String? value) {
                      if (value!.length < 8) {
                        return "رمز عبور باید دارای حداقل ۸ کاراکتر باشد";
                      }
                      if (!value.isPasswordValid) {
                        return "رمز عبور باید شامل حروف بزرگ، حروف کوچک، ارقام و کاراکتر مخصوص باشد";
                      }
                      if (value.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      return null;
                    },
                  ),
                  CustomFormField(
                    labelName: "نام",
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.next,
                    controller: _firstNameController,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  CustomFormField(
                    labelName: "نام خانوادگی",
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.next,
                    controller: _lastNameController,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  CustomFormField(
                    labelName: "آدرس پستی",
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.next,
                    controller: _addressController,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  CustomFormField(
                    labelName: "شماره تماس",
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  Container(
                    width: size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        final UserModel userData = UserModel(
                          email: _emailController.text,
                          password: _passwordController.text,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          address: _addressController.text,
                          phoneNumber: _phoneController.text,
                        );
                        final bool isLoading = state is RegisterLoading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<RegisterBloc>().add(
                                        RegisterSubmitted(userData),
                                      );
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Visibility(
                                visible: isLoading,
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                              Text(
                                "ثبت نام",
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
                      LoginPage.route(),
                    ),
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(
                        theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.tertiaryFixed,
                        ),
                      ),
                    ),
                    child: const Text(
                      "حساب کاربری دارید؟ وارد شوید.",
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
