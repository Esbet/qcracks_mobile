import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/routes/resource_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/fonts.dart';
import '../../auth/pages/login_page.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = "/";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  String profileImage = '';
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    // Aquí podrías inicializar algún proceso, si es necesario.
  }

  @override
  void dispose() {
    // Limpia cualquier recurso aquí
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: firstColor,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                              ? Image.network(
                                  user.photoURL!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  userProfile,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName.isNotEmpty ? userName : "Nombre de Usuario",
                          style: textBigBold22(secondColor),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          "User",
                          style: textBlackStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.call,
                    color: secondColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "+57 3214658656",
                    style: textStyleInput(secondColor),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.email,
                    color: secondColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    user?.email ?? "correo@dominio.com",
                    style: textStyleInput(secondColor),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: secondColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "Calle 34 A #32 -27 Caucasia Ant.",
                    style: textStyleInput(secondColor),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(Icons.favorite_border),
                title: Text(
                  'Contacto seguro',
                  style: textBlackStyleSubTitle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(Icons.loyalty_outlined),
                title: Text(
                  'Código de promoción',
                  style: textBlackStyleSubTitle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(Icons.support_agent),
                title: Text(
                  'Soporte técnico',
                  style: textBlackStyleSubTitle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(Icons.policy_outlined),
                title: Text(
                  'Términos y políticas de privacidad',
                  style: textBlackStyleSubTitle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(Icons.exit_to_app),
                title: Text(
                  'Salir',
                  style: textBlackStyleSubTitle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  await authProvider.signOut();
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
