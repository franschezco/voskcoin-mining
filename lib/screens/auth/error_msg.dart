import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';


final emailExitsnackBar = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Opps! Account Already Exist!',
    message:
    'Seem your have an account with us. Try Login or Forgot Password to retrieve your account!',
    contentType: ContentType.failure,
  ),
);
final weakPasswordsnackBar = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Weak Password!',
    message:
    'Password is too short , Must have more than 6(six) character!',
    contentType: ContentType.failure,
  ),
);
final invalidEmailsnackBar = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Invalid Email!',
    message:
    'Enter a valid mail , Like this - example@gmail.com!',
    contentType: ContentType.failure,
  ),
);

final CompletePasscode = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Incomplete Passcode!',
    message:
    'Passcode must be 4 digit!',
    contentType: ContentType.failure,
  ),
);

final PasscodeUnmatch = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: ' Passcode don\'t match!',
    message:
    'Your Passcode do not match!',
    contentType: ContentType.failure,
  ),
);
final PasscodeWrong = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Wrong Pin!',
    message:
    'You inserted a wrong pin!',
    contentType: ContentType.failure,
  ),
);
