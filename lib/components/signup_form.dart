import 'dart:math';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:sample_app/components/button.dart';
import 'package:sample_app/screens/otp_verification_page.dart';
import 'package:sample_app/screens/profile_page.dart';
import 'package:sample_app/utilities/config.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}
EmailOTP myauth = EmailOTP();

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _dOBController = TextEditingController();
  // EmailAuth emailAuth =  EmailAuth(sessionName: "Sample session");



  DateTime dateTimeNow = DateTime. now();
  final MaskTextInputFormatter _maskTextInputFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );


  String regCaps = '(?=.*?[A-Z])';
  String regSmall = '(?=.*?[a-z])';
  String regSpecialChar = '(?=.*?[!@#\$%&*~])';

  String regNumeric = '(?=.*?[0-9])';
  String regNotAllowSpeChar = '[`|<>=;]';

  String regDOB = '';

  bool visiblePassword = true;
  bool visibleConfirmPassword = true;



  bool isCapitalRequired  = true;
  bool isSmallAlphabetsRequired = false;
  bool isSpecialCharacterRequired  = false;
  bool isNumericRequired  = false;

  bool isSpacesNotAllowed = true;

  bool isMaximumPasswordLengthRequired  = true;
  bool isUserNameDifferentAsEmail = true;
  bool isDateOfBirthRequired = true;
  bool isPhoneNumberRequired = true;
  bool isPhoneNumberUsedAsUserName = false;
  final int minPasswordLength = 7;
  final int maxPasswordLength = 15;
 String? password;
  DateTime? selectedDate;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


 void _clearClipboard() {
   Clipboard.setData(ClipboardData(text: ''));
 }

 Future<void> _selectedDate(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: selectedDate ?? DateTime.now(),
       firstDate: DateTime(1940),
       lastDate: DateTime.now());

   if(picked != null && picked != selectedDate){
     setState(() {
       selectedDate = picked;
       // _dOBController.text = '${selectedDate?.month}/${selectedDate?.day}/${selectedDate?.year}';
      _dOBController.text = DateFormat('MM/dd/yyyy').format(selectedDate!);
     });
   }
 }
   // void sendOTP(BuildContext context) async {
   //   emailAuth.sessionName = "Sample session";
   //   var res = await emailAuth.sendOtp(recipientMail: _emailController.text, otpLength: 4);
   //   if(res){
   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP has been sent')));
   //     Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(email: _emailController.text)));
   //   } else {
   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ops, OTP not sent')));
   //   }
   // }




  void sendOTP() async{
    myauth.setConfig(
      appEmail: 'contact@hdvscoder.com',
      appName: 'doctor_app',
      userEmail: _emailController.text,
      otpLength: 4,
      otpType: OTPType.digitsOnly
    );
    if(await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP has been sent')));
      // Navigator.of(context).pushNamed('otp_page');
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(email : _emailController.text, onPressed: sendOTP,)));

    }else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oops, OTP sent failed')));

    }

  }
 @override
  Widget build(BuildContext context) {
    Config().init(context);
    return  SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: isPhoneNumberRequired ,
                    child: IntlPhoneField(
                    controller: _phoneNumberController,
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                     inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(r'\s')),
                     ],
                     keyboardType: TextInputType.number,
                     cursorColor: Config.primaryColor,
                     // validator: (value) {
                     //   if (value != null) {
                     //     return "* Required";
                     //   }
                     //   // else if(value.length<10 || value.length>10) {
                     //   //   return 'Please Enter Valid Phone Number';
                     //   // }
                     //   else {
                     //     return null;
                     //   }
                     // },
                      validator: (phoneNumber){
                      if(phoneNumber!.number.isEmpty){
                        return '*required';
                      }else {
                        return null;
                      }
                      },

                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        print(phone.completeNumber);

                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                     decoration: const InputDecoration(
                       hintText: 'Phone Number',
                       labelText: 'Phone Number',
                       alignLabelWithHint: true,
                       counterText: '',
                       // prefixIcon: IntlPhoneField(
                       //   decoration: InputDecoration(
                       //
                       //
                       //   ),
                       //   initialCountryCode: 'IN',
                       //   // onChanged: (phone) {
                       //   //   print(phone.completeNumber);
                       //   // },
                       // )
                       // prefixIcon:  CountryCodePicker(
                       //   initialSelection: '+91',
                       //   showDropDownButton: true,
                       //   padding: EdgeInsets.zero,
                       //   showFlagDialog: true,
                       //   showFlag: true,
                       //
                       //   showCountryOnly: false,
                       //
                       //   showOnlyCountryWhenClosed: false,
                       //   alignLeft: false,
                       //   hideMainText: true,
                       // ),
                       // prefixIcon: Icon(Icons.mobile_friendly_outlined),
                       // prefixIconColor: Config.primaryColor,
                     ),
                   ) ),

                    Visibility(
                        visible: isPhoneNumberRequired,
                        child: Config.spaceSmall),
                Visibility(
                    visible: !isPhoneNumberUsedAsUserName || isUserNameDifferentAsEmail ,
                    child:
                TextFormField(
                  controller: _nameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  keyboardType: TextInputType.name,
                  cursorColor: Config.primaryColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }  {
                      return null;
                    }
                    },
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    labelText: 'Username',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),),
                Visibility(
                    visible: !isPhoneNumberUsedAsUserName || isUserNameDifferentAsEmail,
                    child: Config.spaceSmall),
                // isPhoneNumberRequired ? TextFormField(
                //   controller: _phoneNumberController,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.deny(RegExp(r'\s')),
                //   ],
                //   keyboardType: TextInputType.number,
                //   cursorColor: Config.primaryColor,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "* Required";
                //     } else if(value.length<10 && value.length>10) {
                //       return 'Please Enter Valid Phone Number';
                //     }else {
                //       return null;
                //     }
                //   },
                //   decoration: const InputDecoration(
                //     hintText: 'Phone Number',
                //     labelText: 'Phone Number',
                //     alignLabelWithHint: true,
                //     prefixIcon: Icon(Icons.mobile_friendly_outlined),
                //     prefixIconColor: Config.primaryColor,
                //   ),
                // ) : Container(height: 0.0, width: 0.0, padding: const EdgeInsets.all(0.0),margin: const EdgeInsets.all(0.0),),
                // Config.spaceSmall,
                TextFormField(
                  controller: _emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Config.primaryColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }  else if(!(value!.isValidEmail())){
                      return 'Please Enter a valid Email';
                    }
                    else {
                      return null;
                    }
                  },

                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    labelText: 'Email',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  inputFormatters: [
                    // FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    FilteringTextInputFormatter(RegExp(r"\'"), allow: false),
                    // FilteringTextInputFormatter(RegExp(r'\"'), allow: false),
                    FilteringTextInputFormatter(RegExp(r'[\\\"`,()|/<>=;]'), allow: false),
                  ],
                  cursorColor: Config.primaryColor,
                  obscureText: visiblePassword ,
                  onTap: _clearClipboard,
                  validator: (value) {

                    // String value1 = '(?=.*?[A-Z])';
                    // if (value!.isEmpty) {
                    //   return '*required';
                    // }
                    // else if (isCapitalRequired &&
                    //     !RegExp(value1).hasMatch(value)) {
                    //   return 'password must contains at least one Capital letter';
                    // }
                    // else if (isSpecialCharacterRequired && !RegExp('(?=.*?[a-z])').hasMatch(value)) {
                    //   return 'password must contains at least one small letter';
                    // }
                    // else if (isSpecialCharacterRequired &&
                    //     !RegExp('(?=.*?[!@#\$&*~])').hasMatch(value)) {
                    //   return 'password must contains at least one special character ';
                    // } else if (isNumericRequired &&
                    //     !RegExp('(?=.*?[0-9])').hasMatch(value)) {
                    //   return 'password must contains at least one number';
                    // } else if (value!.length < minPasswordLength) {
                    //   return 'your password is too short';
                    // } else if (isMaximumPasswordLengthRequired &&
                    //     value.length > maxPasswordLength) {
                    //   return 'your password is too long';
                    // } else {
                    //   return null;
                    // }
                   // String full = '(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#\$%^&+=])';
                   //
                   // if(RegExp(full).hasMatch(value!)){
                   //   return null;
                   // } else {
                   //   return 'something wrong';
                   // }


                    if (value!.isEmpty) {
                      return '*required';
                    }
                      if (isSpacesNotAllowed && value.contains(' ')) {
                        return  'Spaces not allowed \n';
                      }
                      if (isCapitalRequired &&
                          !RegExp(regCaps).hasMatch(value)) {
                        return 'password must contains at least one Capital letter \n';
                      }
                      if (isSmallAlphabetsRequired &&
                          !RegExp(regSmall).hasMatch(value)) {
                          return 'password must contains at least one small letter \n';
                      }
                      if (isSpecialCharacterRequired &&
                          !RegExp(regSpecialChar).hasMatch(value)) {
                          return 'password must contains at least one special character \n';
                      }
                      if (isNumericRequired &&
                          !RegExp(regNumeric).hasMatch(value)) {
                        return'password must contains at least one number \n';
                      }
                      if (value!.length < minPasswordLength) {
                        return 'your password is too short \n';
                      }
                      if (isMaximumPasswordLengthRequired &&
                          value.length > maxPasswordLength) {
                        return 'your password is too long \n';
                      }
                      if(RegExp(regNotAllowSpeChar).hasMatch(value)){
                        return 'please';
                      }
                        else {
                        return null;
                      }


                    },
                 decoration:  InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            visiblePassword  = !visiblePassword ;
                          });
                        },
                        icon: visiblePassword
                            ? const Icon(Icons.visibility_off_outlined,
                            color: Colors.black38,)
                    : const Icon(Icons.visibility_outlined,
                        color: Config.primaryColor,),
                    ),
                  ),
                ),

                Config.spaceSmall,
                TextFormField(
                  controller: _confirmPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  cursorColor: Config.primaryColor,
                  obscureText: visibleConfirmPassword ,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }else if(value != _passwordController.text){
                      return 'Password not match ';
                    } else {
                      return null;
                    }
                  },
                  decoration:  InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',

                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visibleConfirmPassword  = !visibleConfirmPassword ;
                        });
                      },
                      icon: visibleConfirmPassword
                          ? const Icon(Icons.visibility_off_outlined,
                        color: Colors.black38,)
                          : const Icon(Icons.visibility_outlined,
                        color: Config.primaryColor,),
                    ),
                  ),
                ),
                Config.spaceSmall,

                isDateOfBirthRequired ? TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _dateOfBirthController,

                  inputFormatters: [
                    // _maskTextInputFormatter,
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    FilteringTextInputFormatter.allow(RegExp('[0-9/]')),

                    LengthLimitingTextInputFormatter(10),
                    // _DateFormatter(),
                    _DobFormatter(),
                    // DateTextFormatter(),
                    // CustomDateTextFormatter(),
                    // DATETextInputFormatter(),
                    // DateTextFormatter1(),
                  ],
                  // onChanged: (value){
                  //    String fotmattedDate = formateDOB(value);
                  //    if(fotmattedDate != value){
                  //      _dateOfBirthController.value = TextEditingValue(
                  //        text: fotmattedDate,
                  //        selection: TextSelection.collapsed(offset: fotmattedDate.length)
                  //      );
                  //    }
                  //     // _dateOfBirthController.text = formatDate(value);
                  //     // _dateOfBirthController.selection = TextSelection.fromPosition(TextPosition(offset: _dateOfBirthController.text.length));
                  //2
                  // },
                  keyboardType: TextInputType.datetime,
                  cursorColor: Config.primaryColor,
                    // onTap: () {
                    //   if (_dateOfBirthController.text[_dateOfBirthController.text.length - 1] != ' ') {
                    //     _dateOfBirthController.text = ('${_dateOfBirthController.text} ');
                    //   }
                    //   if (_dateOfBirthController.selection ==TextSelection.fromPosition(
                    //       TextPosition(offset:
                    //       _dateOfBirthController.text.length - 1))) {
                    //     setState(() {});
                    //   }
                    // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }
                    if(!(value!.isValidDOB())  || value.length<10){
                      return 'Invalid DOB';
                    }
                    if((value.isValidDate(value))){
                      return ' Invalid DOB';
                    }

                    // else if(value.length<10 || value.length>10) {
                    //   return 'Please Enter Correct DOB';
                    // }
                    else {
                      return null;
                    }
                  },

                  // onChanged: (value) {
                  //   if(value.length == 2 &&  value.length == 5){
                  //     _dateOfBirthController.text = value +'/'  ;
                  //     if(value.length < _dateOfBirthController.text.length){
                  //       value += '-';
                  //     }else {
                  //       value = value.substring(0, value.length);
                  //     }
                  //
                  //     _dateOfBirthController.selection = TextSelection.fromPosition(TextPosition(offset: _dateOfBirthController.text.length));
                  //   }
                  // },
                  // onChanged: (value){
                  //   if(value.length == 2 && !isDeleting(value)){
                  //     _dateOfBirthController.text = value + '/';
                  //     _dateOfBirthController.selection = TextSelection.fromPosition(TextPosition(offset: _dateOfBirthController.text.length));
                  //   } else if( value.length == 5 && !isDeleting(value)){
                  //     _dateOfBirthController.text = value.substring(0,3) + '/' + value.substring(3,5) + '/' + value.substring(6);
                  //     _dateOfBirthController.selection = TextSelection.fromPosition(TextPosition(offset: _dateOfBirthController.text.length));
                  //   }
                  // },

                  decoration: const InputDecoration(

                    hintText: 'MM/DD/YYYY',
                    labelText: 'Date of Birth',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ) : Container(),
                Config.spaceSmall,
               // DOBInputField(
               //   firstDate: DateTime(1900),
               //   lastDate: DateTime.now(),
               //   showLabel: true,
               //
               //   dateFormatType: DateFormatType.MMDDYYYY,
               //   autovalidateMode: AutovalidateMode.onUserInteraction,
               // ),

                // Visibility(
                //   visible: isDateOfBirthRequired,
                //   child: TextFormField(
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     controller: _dOBController,
                //     readOnly: true,
                //     onTap: () => _selectedDate(context),
                //     // inputFormatters: [
                //     //   _maskTextInputFormatter,
                //     //   FilteringTextInputFormatter.deny(RegExp(r'\s')),
                //     //   FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                //     //   LengthLimitingTextInputFormatter(10),
                //     //   // _DateFormatter(),
                //     // ],
                //
                //     // keyboardType: TextInputType.none,
                //     // cursorColor: Config.primaryColor,
                //
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "* Required";
                //       }
                //       // if(!(value!.isValidDOB())  || value.length<10){
                //       //   return 'Please Enter Correct DOB';
                //       // }
                //       // if((value.isValidDate(value))){
                //       //   return ' not in future';
                //       // }
                //       //
                //       // // else if(value.length<10 || value.length>10) {
                //       // //   return 'Please Enter Correct DOB';
                //       // // }
                //       else {
                //         return null;
                //       }
                //     },
                //                       decoration: const InputDecoration(
                //       hintText: 'MM/DD/YYYY',
                //       labelText: 'Date of Birth',
                //       alignLabelWithHint: true,
                //       prefixIcon: Icon(Icons.calendar_month_outlined),
                //       prefixIconColor: Config.primaryColor,
                //
                //
                //     ),
                //   ),
                // ),
                // Config.spaceSmall,
                Button(width: double.infinity, title: 'Sign Up',
                    onPressed:(){
                      if (_formKey.currentState!.validate()) {
                        // Navigator.push(MaterialPageRoute(builder: (context)), )
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(name: _nameController.text, phoneNumber: _phoneNumberController.text, email: _emailController.text,)));

                        // sendOTP();

                      }else{
                        return null;
                      }
                      // sendOTP(context);

                      // sendOTP();
                      // Navigator.of(context).pushNamed('otp_page');
                    },
                    disable: false)
              ],
            ),
          ),
    );
  }
  // bool isDeleting(String value){
  //  if(_dateOfBirthController.text.length > value.length){
  //    return true;
  //  }
  //  return false;
  // }
}


extension Validator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidDOB(){
    return RegExp(
    // '/^((0[13578]|1[02])\/(0[1-9]|[12][0-9]|3[01])|(0[469]|11)\/(0[1-9]|[12][0-9]|30)|02\/(0[1-9]|[12][0-9]))\/(19|20)\d{2}\$/x').hasMatch(this);
    //     '^(((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))[-/]?[0-9]{4}|02[-/]?29[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))').hasMatch(this);
     '^((((0[13578]|1[02])[/](0[1-9]|1[0-9]|2[0-9]|3[01]))|((0[469]|11)[/](0[1-9]|1[0-9]|2[0-9]|3[0]))|((02)([/](0[1-9]|1[0-9]|2[0-8]))))[/](19([6-9][0-9])|20([0-9][0-9])))|((02)[/](29)[/](19(6[048]|7[26]|8[048]|9[26])|20(0[048]|1[26]|2[048])))').hasMatch(this);
  }

  bool isValidDate(String input) {

    List<String> parts = input.split('/');
    if (parts.length != 3) {
      return false;
    }
    int? month = int.tryParse(parts[0]);
    int? day = int.tryParse(parts[1]);
    int? year = int.tryParse(parts[2]);

    if (month == null || day == null || year == null) {
      return false;
    }

    if(month>12){
      return false;
    }

    DateTime currentDate = DateTime.now();
    DateTime provideDate = DateTime(year, month, day,);

    return provideDate.isAfter(currentDate);
  }



}

class _DobFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;
    TextSelection newSelection = currText.selection;
    String cText = currText.text;
    String pText = prevText.text;
    int cLen = cText.length;
    int pLen = pText.length;

    if(cLen == 1){
      if(int.parse(cText) > 1) {

       cText = '';
       return prevText;
      }
    } else if (cLen == 2 && pLen == 1 && cText.contains('/',1)){
      // cText = cText.padLeft(3, '0');
      // return TextEditingValue(
      //     selection: TextSelection.collapsed(offset: newSelection.end + 1,)
      // );
      return TextEditingValue(
        text: cText.padLeft(3, '0'),
        selection: TextSelection.collapsed(
          offset: currText.selection.end + 1,
        ),
      );
    }else if(cLen == 2 && pLen ==1) {
      int mm = int.parse(cText.substring(0, 2));
      if (mm == 0 || mm > 12) {
        cText = cText.substring(0, 1);
       return prevText;
      } else if (!(cText.contains('/'))) {
        // cText += '/';
        return TextEditingValue(
          text: '$cText/',
          selection: TextSelection.collapsed(
            offset: currText.selection.end + 1,
          ),
        );


      }
    }
      else if (cLen == 4){
        if(int.parse(cText.substring(3,4))>3){
          cText = cText.substring(0,3);
          return prevText;
        }
      }if(cLen == 5 && pLen ==4 && cText.contains('/', 4)){
        // cText = cText.substring(0,3) + '0' + cText.substring(3);
        return TextEditingValue(
          text: cText = '${cText.substring(0,3)}0${cText.substring(3)}',
          selection: TextSelection.collapsed(
            offset: currText.selection.end + 1,
          ),
        );
      }else if(cLen == 5 && pLen ==4 ){
        int dd = int.parse(cText.substring(3,5));
        if(dd == 0 || dd > 31) {
          cText = cText.substring(0,4);
          return prevText;
        }else if(!(cText.contains('/',4))){
          // cText += '/';
          return TextEditingValue(
            text: '$cText/',
            selection: TextSelection.collapsed(
              offset: currText.selection.end + 1,
            ),
          );
        }
      }

    //   selectionIndex = cText.length;
    // TextSelection updateCursorPosition(String text) {
    //   return TextSelection.fromPosition(TextPosition(offset: text.length));
    // }

      // return
      //
      //   TextEditingValue(
      //   text: cText,
      //   // // selection: TextSelection.collapsed(offset: newSelection.end ),
      //   // // selection: TextSelection(baseOffset: selectionIndex, extentOffset: selectionIndex)
      //     selection:  TextSelection.collapsed(offset: selectionIndex ),
      //
      //   // // selection: TextSelection(baseOffset: selectionIndex + 1, extentOffset: selectionIndex),
      //   //    composing: TextRange.empty,
      //   // selection: newSelection,
      // );

    else if (cText.length == 1 &&
    pText.isEmpty &&
    RegExp('[^0-9]').hasMatch(currText.text)) {
    return prevText;
    }
    return currText;

    }

  }








class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }

    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),

    );


  }


}

String formateDOB(String input){

  if(input.length <= 2) {
    input = input.padLeft(2, '0');
  } else if(input.length > 2 && input.length <= 5){
    String monthPart = input.substring(0,2);
    String daypart = input.substring(3).padLeft(2, '0');
    input = '$monthPart/$daypart';
  }
  return input;
}

String formatDate(String input) {
  String formattedDate = input;

  if(input.length >= 2 ){
    String month = input.substring(0,2);
    if(month == '11'){
        formattedDate = '01' + input.substring(2);
    }
  }

  if(input.length>=5){
    String day = input.substring(3, 4);
    if(day.length == 1){
      formattedDate = formattedDate.replaceRange(3, 4, 'O$day');

    }
  }
  return formattedDate;
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String separator = '/';
    var text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  String _format(
      String value,
      String oldValue,
      String separator,
      ) {
    var isErasing = value.length < oldValue.length;
    var isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
      TextEditingValue oldValue,
      String text,
      ) {
    var endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    var selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }
}

class CustomDateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/', oldValue);
    return newValue.copyWith(
        text: text, selection: _updateCursorPosition(text, oldValue));
  }
}

String _format(String value, String separator, TextEditingValue old) {
  var finalString = '';
  var dd = '';
  var mm = '';
  var yyy = '';
  var oldVal = old.text;

  var temp_oldVal = oldVal;
  var temp_value = value;


  if (!oldVal.contains(separator) ||
      oldVal.isEmpty ||
      separator.allMatches(oldVal).length < 2) {
    oldVal += '///';
  }
  if (!value.contains(separator) || _backSlashCount(value) < 2) {
    value += '///';
  }
  var splitArrOLD = oldVal.split(separator);
  var splitArrNEW = value.split(separator);
  print('----> splitArrOLD: $splitArrOLD');
  print('----> splitArrNEW: $splitArrNEW');
  for (var i = 0; i < 3; i++) {
    splitArrOLD[i] = splitArrOLD[i].toString().trim();
    splitArrNEW[i] = splitArrNEW[i].toString().trim();
  }
  // block erasing
  if ((splitArrOLD[0].isNotEmpty &&
      splitArrOLD[2].isNotEmpty &&
      splitArrOLD[1].isEmpty &&
      temp_value.length < temp_oldVal.length &&
      splitArrOLD[0] == splitArrNEW[0] &&
      splitArrOLD[2].toString().trim() ==
          splitArrNEW[1].toString().trim()) ||
      (_backSlashCount(temp_oldVal) > _backSlashCount(temp_value) &&
          splitArrNEW[1].length > 2) ||
      (splitArrNEW[0].length > 2 && _backSlashCount(temp_oldVal) == 1) ||
      (_backSlashCount(temp_oldVal) == 2 &&
          _backSlashCount(temp_value) == 1 &&
          splitArrNEW[0].length > splitArrOLD[0].length)) {
    finalString = temp_oldVal; // making the old date as it is
    print('blocked finalString : $finalString ');
  } else {
    if (splitArrNEW[0].length > splitArrOLD[0].length) {
      if (splitArrNEW[0].length < 3) {
        dd = splitArrNEW[0];
      } else {
        for (var i = 0; i < 2; i++) {
          dd += splitArrNEW[0][i];
        }
      }
      if (dd.length == 2 && !dd.contains(separator)) {
        dd += separator;
      }
    } else if (splitArrNEW[0].length == splitArrOLD[0].length) {
      print('splitArrNEW[0].length == 2');
      if (oldVal.length > value.length && splitArrNEW[1].isEmpty) {
        dd = splitArrNEW[0];
      } else {
        dd = splitArrNEW[0] + separator;
      }
    } else if (splitArrNEW[0].length < splitArrOLD[0].length) {
      print('splitArrNEW[0].length < splitArrOLD[0].length');
      if (oldVal.length > value.length &&
          splitArrNEW[1].isEmpty &&
          splitArrNEW[0].isNotEmpty) {
        dd = splitArrNEW[0];
      } else if (temp_oldVal.length > temp_value.length &&
          splitArrNEW[0].isEmpty &&
          _backSlashCount(temp_value) == 2) {
        dd += separator;
      } else {
        if (splitArrNEW[0].isNotEmpty) {
          dd = splitArrNEW[0] + separator;
        }
      }
    }
    print('dd value --> $dd');

    if (dd.isNotEmpty) {
      finalString = dd;
      if (dd.length == 2 &&
          !dd.contains(separator) &&
          oldVal.length < value.length &&
          splitArrNEW[1].isNotEmpty) {
        if (separator.allMatches(dd).isEmpty) {
          finalString += separator;
        }
      } else if (splitArrNEW[2].isNotEmpty &&
          splitArrNEW[1].isEmpty &&
          temp_oldVal.length > temp_value.length) {
        if (separator.allMatches(dd).isEmpty) {
          finalString += separator;
        }
      } else if (oldVal.length < value.length &&
          (splitArrNEW[1].isNotEmpty || splitArrNEW[2].isNotEmpty)) {
        if (separator.allMatches(dd).isEmpty) {
          finalString += separator;
        }
      }
    } else if (_backSlashCount(temp_oldVal) == 2 && splitArrNEW[1].isNotEmpty) {
      dd += separator;
    }
    print('finalString after dd=> $finalString');
    if (splitArrNEW[0].length == 3 && splitArrOLD[1].isEmpty) {
      mm = splitArrNEW[0][2];
    }

    if (splitArrNEW[1].length > splitArrOLD[1].length) {
      print('splitArrNEW[1].length > splitArrOLD[1].length');
      if (splitArrNEW[1].length < 3) {
        mm = splitArrNEW[1];
      } else {
        for (var i = 0; i < 2; i++) {
          mm += splitArrNEW[1][i];
        }
      }
      if (mm.length == 2 && !mm.contains(separator)) {
        mm += separator;
      }
    } else if (splitArrNEW[1].length == splitArrOLD[1].length) {
      print('splitArrNEW[1].length = splitArrOLD[1].length');
      if (splitArrNEW[1].isNotEmpty) {
        mm = splitArrNEW[1];
      }
    } else if (splitArrNEW[1].length < splitArrOLD[1].length) {
      print('splitArrNEW[1].length < splitArrOLD[1].length');
      if (splitArrNEW[1].isNotEmpty) {
        mm = splitArrNEW[1] + separator;
      }
    }
    print('mm value --> $mm');

    if (mm.isNotEmpty) {
      finalString += mm;
      if (mm.length == 2 && !mm.contains(separator)) {
        if (temp_oldVal.length < temp_value.length) {
          finalString += separator;
        }
      }
    }
    print('finalString after mm=> $finalString');
    if (splitArrNEW[1].length == 3 && splitArrOLD[2].isEmpty) {
      yyy = splitArrNEW[1][2];
    }

    if (splitArrNEW[2].length > splitArrOLD[2].length) {
      print('splitArrNEW[2].length > splitArrOLD[2].length');
      if (splitArrNEW[2].length < 5) {
        yyy = splitArrNEW[2];
      } else {
        for (var i = 0; i < 4; i++) {
          yyy += splitArrNEW[2][i];
        }
      }
    } else if (splitArrNEW[2].length == splitArrOLD[2].length) {
      print('splitArrNEW[2].length == splitArrOLD[2].length');
      if (splitArrNEW[2].isNotEmpty) {
        yyy = splitArrNEW[2];
      }
    } else if (splitArrNEW[2].length < splitArrOLD[2].length) {
      print('splitArrNEW[2].length < splitArrOLD[2].length');
      yyy = splitArrNEW[2];
    }
    print('yyy value --> $yyy');

    if (yyy.isNotEmpty) {
      if (_backSlashCount(finalString) < 2) {
        if (splitArrNEW[0].isEmpty && splitArrNEW[1].isEmpty) {
          finalString = separator + separator + yyy;
        } else {
          finalString = finalString + separator + yyy;
        }
      } else {
        finalString += yyy;
      }
    } else {
      if (_backSlashCount(finalString) > 1 && oldVal.length > value.length) {
        var valueUpdate = finalString.split(separator);
        finalString = valueUpdate[0] + separator + valueUpdate[1];
      }
    }

    print('finalString after yyyy=> $finalString');
  }

  print('<------------------------- finish---------------------------->');

  return finalString;
}

TextSelection _updateCursorPosition(String text, TextEditingValue oldValue) {
  var endOffset = max(
    oldValue.text.length - oldValue.selection.end,
    0,
  );
  var selectionEnd = text.length - endOffset;
  print('My log ---> $selectionEnd');
  return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
}

int _backSlashCount(String value) {
  return '/'.allMatches(value).length;
}



class DATETextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    StringBuffer newText = new StringBuffer();
    if (newTextLength == 3) {
      if (!newValue.text.contains('/')) {
        if (newValue.text[2] != '/') {
          newText
              .write(newValue.text.substring(0, usedSubstringIndex = 2) + '/');
        }
        if (newValue.selection.end >= 2) selectionIndex++;
      }
    }
    if (newTextLength == 6) {
      if (newValue.text[5] != '/') {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 5) +
            '/');
      }
      if (newValue.selection.end >= 5) selectionIndex++;
    }
// Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}


class DateTextFormatter1 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length &&
        newValue.text.isNotEmpty &&
        oldValue.text.isNotEmpty) {
      if (RegExp('[^0-9/]').hasMatch(newValue.text)) return oldValue;
      if(newValue.text.length == 2 && oldValue.text.length==1 && newValue.text.contains('/',1)){
        return TextEditingValue(
          text: newValue.text.padLeft(3, '0'),
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      }
      else if (newValue.text.length > 10) return oldValue;
      else if (newValue.text.length == 2 || newValue.text.length == 5) {
        return TextEditingValue(
          text: '${newValue.text}/',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      } else if (newValue.text.length == 3 && newValue.text[2] != '/') {
        return TextEditingValue(
          text:
          '${newValue.text.substring(0, 2)}/${newValue.text.substring(2)}',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      } else if (newValue.text.length == 6 && newValue.text[5] != '/') {
        return TextEditingValue(
          text:
          '${newValue.text.substring(0, 5)}/${newValue.text.substring(5)}',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      }
    } else if (newValue.text.length == 1 &&
        oldValue.text.isEmpty &&
        RegExp('[^0-9]').hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}







