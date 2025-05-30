import 'package:e_commerce/profile/presentation/widgets/custom_form_field.dart';
import 'package:e_commerce_data/auth_data/models/user_model.dart';
import 'package:flutter/material.dart';

class EditDetailsPage extends StatefulWidget {
  const EditDetailsPage({super.key, required this.userData});

  final UserModel userData;

  static Route<EditDetailsPage> route(UserModel userData) {
    return MaterialPageRoute(
      builder: (_) => EditDetailsPage(
        userData: userData,
      ),
    );
  }

  @override
  State<EditDetailsPage> createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.userData.firstName);
    _lastNameController = TextEditingController(text: widget.userData.lastName);
    _emailController = TextEditingController(text: widget.userData.email);
    _phoneController = TextEditingController(text: widget.userData.phoneNumber);
    _addressController = TextEditingController(text: widget.userData.address);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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
        child: Align(
          alignment: AlignmentDirectional.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
              maxHeight: size.height,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
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
                    labelName: "آدرس پستی",
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    theme: theme,
                  ),
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
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
        ),
      ),
    );
  }
}
