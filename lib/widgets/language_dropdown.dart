import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/shared/translations/localization_service.dart';

class DropdownLanguage extends StatefulWidget {
  const DropdownLanguage({super.key});

  @override
  State<DropdownLanguage> createState() => _DropdownLanguageState();
}

class _DropdownLanguageState extends State<DropdownLanguage> {
  final getStore = GetStorage();
   
  String _selectedLang = "";

  @override
  void initState() {
    super.initState();
    // getStore.write('lang', LocalizationService.locale.languageCode);
    _selectedLang = getStore.read('lang') ?? LocalizationService.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.sp, left: 14.sp),
      margin: EdgeInsets.only(right: 0),
      child: DropdownButton<String>(
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
        underline: const SizedBox(),
        icon: Visibility(child: Icon(Icons.arrow_drop_down), visible: false),
        value: _selectedLang,
        items: _buildDropdownMenuItems(),
        onChanged: (value) {
          setState(() => _selectedLang = value!);
          LocalizationService.changeLocale(value!);
          getStore.write('lang', value);
          print(value);
          // LocalizationService.reversedLangs();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    var list = <DropdownMenuItem<String>>[];
    LocalizationService.langs.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(key),
      ));
    });
    return list;
  }
}
