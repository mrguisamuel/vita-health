import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class MyTextField {
  void Function(String value)? changedValue;

  MyTextField({
    this.changedValue
  });

  InputDecoration defaultDecoration({required int colorMode, required String hint}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      contentPadding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      filled: true,
      fillColor: changeColor(colorMode),
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400
      ),
      helperText: ' ',
      helperStyle: GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400
      )
    );
  }

  Color changeColor([int mode = 0]) {
    switch(mode) {
      case 0:
        return ProjectColors().textField;
      case 1:
        return ProjectColors().textFieldBlock;
      case 2:
        return ProjectColors().textFieldWrong;
      default:
        return ProjectColors().textField;
    }
  }

  Widget createTextField({required String hint, String exp = r'^[A-Za-z\s]+$', 
  int colorMode = 0, bool hide = false, bool active = true, 
  required String validatorText,
  TextInputType keyboard = TextInputType.text,
  String? formatter}) {
    return TextFormField(
      decoration: defaultDecoration(colorMode: colorMode, hint: hint),
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: hide,
      enableSuggestions: !hide,
      autocorrect: !hide,
      enabled: active,
      validator: (text) {
        final regex = RegExp(exp);
        if(!regex.hasMatch(text ?? '')) return validatorText;
        return null;
      },
      keyboardType: keyboard,
      inputFormatters: [MaskTextInputFormatter(mask: formatter)]
    );
  }

  Widget createdateInput({required TextEditingController dateInput, required BuildContext myContext, required String hint, int colorMode = 0}) {
    return TextField(
      controller: dateInput,
      decoration: defaultDecoration(colorMode: colorMode, hint: hint),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: myContext,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101)
        );
        if (pickedDate != null) {
          //print(pickedDate);
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          //print(formattedDate);
          dateInput.text = formattedDate;
        } else dateInput.text = "";
      }      
    );
  }

  Widget createNumberField({required String hint, int colorMode = 0, TextEditingController? inputValue}) {
    return TextFormField(
      decoration: defaultDecoration(colorMode: colorMode, hint: hint),
      keyboardType: TextInputType.number,
      onChanged: (String value) => changedValue!(value),
      controller: inputValue
    );
  }
}