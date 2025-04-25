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
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomFormField(
                labelName: "نام",
                textDirection: TextDirection.rtl,
                inputAction: TextInputAction.next,
                controller: controller,
                theme: theme,
              ),
              CustomFormField(
                labelName: "نام خانوادگی",
                textDirection: TextDirection.rtl,
                inputAction: TextInputAction.next,
                controller: controller,
                theme: theme,
              ),
              CustomFormField(
                labelName: "نام کاربری",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                controller: controller,
                theme: theme,
              ),
              CustomFormField(
                labelName: "آدرس ایمیل",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: controller,
                theme: theme,
              ),
              CustomFormField(
                labelName: "شماره تماس",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                controller: controller,
                theme: theme,
              ),
              CustomFormField(
                labelName: "کد پستی",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: controller,
                theme: theme,
              ),
              CustomFormField(
                labelName: "آدرس پستی",
                textDirection: TextDirection.rtl,
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                controller: controller,
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
