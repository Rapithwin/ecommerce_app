import 'package:e_commerce/profile/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class EditDetailsPage extends StatefulWidget {
  const EditDetailsPage({super.key});

  static Route<EditDetailsPage> route() {
    return MaterialPageRoute(
      builder: (_) => EditDetailsPage(),
    );
  }

  @override
  State<EditDetailsPage> createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController,
      _lastNameController,
      _usernameController,
      _emailController,
      _phoneController,
      _postCodeController,
      _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _postCodeController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _postCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainerLow,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              CustomFormField(
                labelName: "نام",
                textDirection: TextDirection.rtl,
                inputAction: TextInputAction.next,
                controller: _firstNameController,
                theme: theme,
              ),
              CustomFormField(
                labelName: "نام خانوادگی",
                textDirection: TextDirection.rtl,
                inputAction: TextInputAction.next,
                controller: _lastNameController,
                theme: theme,
              ),
              CustomFormField(
                labelName: "نام کاربری",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                controller: _usernameController,
                theme: theme,
              ),
              CustomFormField(
                labelName: "آدرس ایمیل",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                theme: theme,
              ),
              CustomFormField(
                labelName: "شماره تماس",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                theme: theme,
              ),
              CustomFormField(
                labelName: "کد پستی",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _postCodeController,
                theme: theme,
              ),
              CustomFormField(
                labelName: "آدرس پستی",
                textDirection: TextDirection.rtl,
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                controller: _addressController,
                theme: theme,
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "ذخیره",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
