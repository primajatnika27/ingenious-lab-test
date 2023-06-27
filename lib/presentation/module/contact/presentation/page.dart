import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ingenious_test/data/repository_impl/contact_repository_impl.dart';
import 'package:ingenious_test/domain/repository/contact_repository.dart';
import 'package:ingenious_test/presentation/module/contact/presentation/bloc.dart';
import 'package:ingenious_test/widget/contact_card.dart';
import 'package:search_highlight_text/search_highlight_text.dart';

import '../../../../widget/block_loader.dart';
import '../../../../widget/loader_widget.dart';
import '../../../core/app.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ContactBloc _contactBloc;

  String searchText = '';

  @override
  void initState() {
    _contactBloc = ContactBloc(
      repository: ContactRepositoryImpl(
        client: App.main.clientAuth,
      ),
    )..getListContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: appBarSearch(),
        centerTitle: false,
        elevation: 1.0,
      ),
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
      body: BlocProvider(
        create: (context) => _contactBloc,
        child: BlocConsumer<ContactBloc, ContactState>(
          listener: (context, state) {},
          builder: (context, stateData) {
            if (stateData is ContactSuccessState) {
              if (stateData.entity!.isEmpty) {
                return const Center(
                  child: Text("No Data Record"),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(left: 13.w),
                        child: Text(
                          'Contacts',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SearchTextInheritedWidget(
                        highlightColor: const Color.fromRGBO(0, 153, 174, 1),
                        searchText: searchText,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stateData.entity!.length,
                          itemBuilder: (context, index) {
                            return ContactCard(contact: stateData.entity![index]);
                          },
                        ),
                      ),
                    ]),
                  )
                ],
              );
            }

            return Center(
              child: SizedBox(
                height: 150.h,
                child: const BlockLoader(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget appBarSearch() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 250, 255, 1),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextFormField(
        controller: _contactBloc.searchController,
        style: TextStyle(
          fontSize: 13.sp,
          color: const Color.fromRGBO(120, 125, 131, 1),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: const Color.fromRGBO(120, 125, 131, 1),
          ),
          prefixIconConstraints:
              BoxConstraints(minWidth: 14.w, minHeight: 16.h),
          suffixIconConstraints:
              BoxConstraints(minWidth: 14.w, minHeight: 16.h),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const Icon(
              Icons.search,
              color: Color.fromRGBO(120, 125, 131, 1),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _contactBloc.searchController.clear();

              _contactBloc.searchContact(_contactBloc.searchController.text);
              setState(() {
                searchText = '';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Icon(
                Icons.close_rounded,
                color: Color.fromRGBO(120, 125, 131, 1),
              ),
            ),
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            searchText = value;
            _contactBloc.searchContact(value);
          });
        },
      ),
    );
  }
}
