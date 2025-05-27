import 'package:e_commerce/authentication/presentation/view/login_page.dart';
import 'package:e_commerce/extensions.dart';
import 'package:e_commerce/profile/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static Route<SignupPage> route() {
    return MaterialPageRoute(
      builder: (_) => SignupPage(),
    );
  }

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
            style: theme.textTheme.headlineLarge,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                  controller: _passwordController,
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
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                    },
                    child: Text(
                      "ثبت نام",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontSize: 15,
                      ),
                    ),
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
    );
  }

  String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "این فیلد نباید خالی باشد";
    }
    return null;
  }
}
