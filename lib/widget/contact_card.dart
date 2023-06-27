import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ingenious_test/domain/entity/list_contact_entity.dart';
import 'package:search_highlight_text/search_highlight_text.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PhysicalModel(
                    elevation: 3,
                    color: Colors.teal,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    child: ProfilePicture(
                      name: contact.name,
                      radius: 20,
                      fontsize: 15.sp,
                      random: false,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchHighlightText(
                            contact.name,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SearchHighlightText(
                            contact.email,
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
