import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/repository_impl/auth_repository_impl.dart';
import '../../../../../widget/block_loader.dart';
import '../../../../core/app.dart';
import 'bloc.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({Key? key}) : super(key: key);

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  late AuthLoginBloc _authLoginBloc;

  late bool isObscurePassword;

  @override
  void initState() {
    _authLoginBloc = AuthLoginBloc(
      repository: AuthRepositoryImpl(
        client: App.main.clientAuth,
      ),
    );

    isObscurePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authLoginBloc,
      child: BlocListener(
        bloc: _authLoginBloc,
        listener: (context, state) async {
          if (state is AuthLoginLoadingState) {
            FocusScope.of(context).requestFocus(FocusNode());
            showDialog(
              context: context,
              builder: (_) => const BlockLoader(),
            );
          } else if (state is AuthLoginGoState) {
            try {
              Modular.to.pushReplacementNamed('/contact/');
            } catch (e) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(232, 250, 255, 1),
            elevation: 0,
          ),
          backgroundColor: const Color.fromRGBO(232, 250, 255, 1),
          body: Form(
            key: _authLoginBloc.formKey,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 50.h),
                    Image(
                      image: const AssetImage("assets/images/logo.png"),
                      height: 80.h,
                      width: 80.w,
                    ),
                    SizedBox(height: 120.h),
                    Padding(
                      padding: EdgeInsets.only(left: 34.w),
                      child: Text(
                        'Welcome to IngLab',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 34.w),
                      child: Text(
                        'Please enter your details to continue',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          // color: const Color(0xFF50555C),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.w),
                      child: Column(
                        children: [
                          // Username Field
                          TextFormField(
                            controller: _authLoginBloc.usernameController,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h,
                                horizontal: 10.h,
                              ),
                              hintText: 'User Name',
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'username is required.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 10.h),

                          // Password Field
                          TextFormField(
                            controller: _authLoginBloc.passwordController,
                            obscureText: isObscurePassword,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h,
                                horizontal: 10.h,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 14.w, minHeight: 16.h),
                              suffixIcon: isObscurePassword
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 10.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isObscurePassword = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: Color.fromRGBO(120, 125, 131, 1),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(right: 10.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isObscurePassword = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.remove_red_eye,
                                          color: Color.fromRGBO(120, 125, 131, 1),
                                        ),
                                      ),
                                    ),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 14.w, minHeight: 16.h),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'password is required.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 27.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(0, 153, 174, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 27.w),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 10.w,
                            ),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => const Color.fromRGBO(0, 153, 174, 1),
                          ),
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _authLoginBloc.signIn();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
