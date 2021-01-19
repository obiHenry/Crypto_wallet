class Validators {
  static String email(String value) {
    if (value.isEmpty) {
      return 'Please enter a valid email address';
    }
    if (!value.contains('@')) {
      return 'Email is invalid, must contain @';
    }
    if (!value.contains('.')) {
      return 'Email is invalid, must contain .';
    }
    return null;
  }

  static String password(String value) {
    if (value.isEmpty) {
      return 'Please enter your Password';
    }
    if (value.length < 8) {
      return 'Password must be more than 8 characters';
    }
    return null;
  }

  static String confirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value.length < 8) {
      return 'Password must be more than 8 characters';
    }
    // if (value != password(value)) {
    //   return 'confirm password must match password';
    // }
    return null;
  }
  static String accountNumber(String value) {
    if (value.isEmpty) {
      return 'please enter account number';
    }
    if (value.length < 10) {
      return 'account number must be up to 10';
    }
    if (value.length> 10) {
      return 'account number must not  be more than 10';
    }else{
return null;
    }
    
  }

 static String bankName(String value) {
    if (value.isEmpty) {
      return 'please enter bank name';
    }
   
    return null;
  }
  static dynamic accountName(dynamic value) {
    if (value == null) {
      return 'account name can\'t be empty';
    }else if(value != null){
      return null;
    }
   
    
  }

  static String firstName(String value) {
    if (value == null) {
      return 'please enter first name';
    }
   
    return null;
  }

  static String lastName(String value) {
    if (value.isEmpty) {
      return 'please enter last name';
    }
   
    return null;
  }

  static String mobile(String value) {
    if (value.isEmpty) {
      return 'please enter mobile number';
    }
      if (value.length < 11) {
      return 'account number must be up to 11';
    }
    if (value.length > 11) {
      return 'account number must not  be more than 11';
    }  
   
    return null;
  }

   static String biller(String value) {
    if (value == null) {
      return 'please enter biller';
    }
   
    return 'valid';
  }
   static String product(String value) {
    if (value == null) {
      return 'please enter product';
    }
   
    return 'valid';
  }
   static String amount(String value) {
    if (value.isEmpty) {
      return 'please enter amount';
    }
   
    return 'valid';
  }
   static String equivalence(String value) {
    if (value.isEmpty) {
      return 'please enter amount';
    }
   
    return 'valid';
  }

   static String referenceNumber(String value) {
    if (value == null) {
      return 'please enter reference number';
    }
   
    return 'valid';
  }

   static String mobileNumber( String value) {
    if (value == null) {
      return 'please enter mobile number';
    }
    //   if (value.length < 11) {
    //   return 'account number must be up to 11';
    // }
    if (value.length > 11) {
      return 'account number must not  be more than 11';
    }
   
    return 'valid';
  }

   static String account( String value) {
    if (value == null ) {
      return 'please choose account  ';
    }
   
    return 'valid';
  }


 static String alnum(String value, String type) {
    if (value.isEmpty) {
      return '$type is required';
    }
    if (value.length < 3) {
      return 'Enter a valid ${type.toLowerCase()}';
    }
    return null;
  }

  static String valInt(String value, String type) {
    if (value.isEmpty) {
      return '$type is required';
    }
    if (num.tryParse(value) == null) {
      return '$type cannot contain alphabets or special characters';
    }
    return null;
  }

  static String phone(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    if (num.tryParse(value) == null) {
      return 'Phone number cannot contain alphabets or special characters';
    }
    return null;
  }




 
}
