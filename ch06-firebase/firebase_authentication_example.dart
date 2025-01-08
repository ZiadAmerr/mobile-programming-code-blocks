_example() async {
  // Get a multi-factor session for the current user
  final session = await user.multiFactor.getSession();
  
  // Get an instance of FirebaseAuth
  final auth = FirebaseAuth.instance();
  
  // Start the phone number verification process
  await auth.verifyPhoneNumber(
    multiFactorSession: session, // Pass the multi-factor session
    phoneNumber: phoneController.text, // Phone number to verify
    verficationCompleted: (PhoneAuthCredential credential) async {
      // This callback is triggered when verification is completed automatically
      await auth.signInWithCredential(credential); // Sign in with the credential
    },
    verificationFailed: (FirebaseAuthException e) {
      // This callback is triggered when verification fails
      print(e.message); // Print the error message
    },
    codeSent: (String verificationId, int resendToken) async {
      // This callback is triggered when the verification code is sent
      final smsCode = await getSmsCodeFromUser(context); // Get the SMS code from the user
      if (smsCode != null) {
        // If the user provided the SMS code
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, // Verification ID from the callback
          smsCode: smsCode, // SMS code provided by the user
        );
        try {
          // Enroll the user in multi-factor authentication
          await user.multiFactor.enroll(
            PhoneMultiFactorGenerator.getAssertion(credential),
          );
        } on FirebaseAuthException catch (e) {
          // Catch and print any errors during enrollment
          print(e.message);
        }
      }
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // This callback is triggered when the code auto-retrieval times out
      print('Timeout'); // Print a timeout message
    },
  );
}