import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/authentication/presentation/bloc/register_bloc.dart';
import 'package:e_commerce/extensions.dart';
import 'package:e_commerce/profile/presentation/bloc/profile_cubit.dart';
import 'package:e_commerce/profile/presentation/widgets/custom_form_field.dart';
import 'package:e_commerce_data/auth_data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDetailsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return EditDetailsView(
      userData: userData,
    );
  }
}

class EditDetailsView extends StatefulWidget {
  const EditDetailsView({super.key, required this.userData});

  final UserModel userData;

  @override
  State<EditDetailsView> createState() => _EditDetailsViewState();
}

class _EditDetailsViewState extends State<EditDetailsView> {
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

  String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "این فیلد نباید خالی باشد";
    }
    return null;
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
                    labelName: "آدرس ایمیل",
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
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
                    labelName: "شماره تماس",
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  CustomFormField(
                    labelName: "آدرس پستی",
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    theme: theme,
                    validator: emptyValidator,
                  ),
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final authState = context.watch<AuthBloc>().state;
                        final bool isLoading =
                            state.status == ProfileStatus.loading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  final UserModel userData = UserModel(
                                    email: _emailController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    address: _addressController.text,
                                    phoneNumber: _phoneController.text,
                                  );
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  if (authState is Authenticated) {
                                    context
                                        .read<ProfileCubit>()
                                        .updateUserDetails(
                                            authState.token, userData);
                                  }
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
                                "ذخیره",
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
