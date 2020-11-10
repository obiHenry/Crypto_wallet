import 'package:Crypto_wallet/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  String userId = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser.uid
      : '';
  Map userData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _dbRef = FirebaseDatabase.instance.reference();

  void setUserId(String uid) {
    userId = uid;
    notifyListeners();
  }

  Future<void> setUserData({Map user}) async {
    userData = user == null ? await getUserDataById() : user;
    notifyListeners();
  }

  UserM _userFromFirebaseUser(User user) {
    return user != null ? UserM(uid: user.uid) : null;
  }

  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      setUserId(user.uid);
      await setUserData();
      dynamic data = _userFromFirebaseUser(user);
      return {'status': data != null ? true : false, 'message': data};
    } catch (e) {
      return {'status': false, 'message': e.message.toString()};
    }
  }

  Future registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      setUserId(user.uid);
      // await setUserData();
      _dbRef.child('Users').child(user.uid).update({
        'email': email,
        'createdAt': DateTime.now().toString(),
      });
      dynamic data = _userFromFirebaseUser(user);
      return {'status': data != null ? true : false, 'message': data};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      setUserId('');
      if (userData != null) {
        userData.clear();
      }
      return {'status': true, 'message': 'You are logged out'};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }

  Future getUserDataById() async {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser.uid;
      try {
        dynamic user = await _dbRef
            .child('Users')
            .child(userId)
            .once()
            .then((DataSnapshot snapshot) {
          dynamic user = snapshot.value;
          return user;
        });
        await setUserData(user: user);
        return user;
      } catch (e) {
        print(e.toString());
      }
    } else {
      return null;
    }
  }

  Future saveDetails(Map data) async {
    Map<String, dynamic> mappedData = data.cast<String, dynamic>();
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser.uid;
      mappedData['updatedAt'] = DateTime.now().toString();
      try {
        await _dbRef.child('Users').child(userId).update(mappedData);
        dynamic user = await getUserDataById();
        await setUserData(user: user);
        return {'status': true, 'message': user};
      } catch (e) {
        print(e.toString());
        return {'status': false, 'message': 'An error occurred; please retry'};
      }
    } else {
      return {'status': false, 'message': 'An error occurred; please retry'};
    }
  }

  Future saveMeasurement(Map<String, dynamic> data) async {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser.uid;
      data['updatedAt'] = DateTime.now().toString();
      try {
        await _dbRef.child('Users').child(userId).update(data);
        await setUserData();
        return {'status': true, 'message': 'Measurement details saved'};
      } catch (e) {
        print(e.toString());
        return {'status': false, 'message': 'An error occurred; please retry'};
      }
    } else {
      return {'status': false, 'message': 'An error occurred; please retry'};
    }
  }



  Future updateWalletData(
    String walletBalance,
    String nairaBalance,
    String walletCurrency,
   
  
  ) async {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser.uid;
      try {
        await _dbRef.child('Users').child(userId).update({
          '$walletCurrency': walletBalance,
          'naira': nairaBalance,
          
          'updatedAt': DateTime.now().toString(),
        });
        dynamic user = await getUserDataById();
        await setUserData(user: user);
        return {'status': true, 'message': user};
      } catch (e) {
        print(e.toString());
        return {'status': false, 'message': 'An error occurred; please retry'};
      }
    } else {
      return {'status': false, 'message': 'An error occurred; please retry'};
    }
  }
   Future updateUserData(
    String name,
    String phone,
    String gender,
    String address,
  ) async {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser.uid;
      try {
        await _dbRef.child('Users').child(userId).update({
          'full_name': name,
          'phone': phone,
          'address': address,
          'gender': gender,
          'updatedAt': DateTime.now().toString(),
        });
        dynamic user = await getUserDataById();
        await setUserData(user: user);
        return {'status': true, 'message': user};
      } catch (e) {
        print(e.toString());
        return {'status': false, 'message': 'An error occurred; please retry'};
      }
    } else {
      return {'status': false, 'message': 'An error occurred; please retry'};
    }
  }
  Future updateTransactionList(
    String sentOrRecieved,
    String from,
    String to,
    String coinEquivalence,
    String nairaEquivalence,
    String walletTransactionList,
    String currency,
  ) async {
    
      
      try {
          await _dbRef.child('TransactionList')
          .child('$walletTransactionList')
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .update({
          'TransactionType': sentOrRecieved,
          'from': from,
          'to': to,
          'coinEquivalance': coinEquivalence,
          'nairaEquivalence':nairaEquivalence,
          'currency': currency,
          'time': DateTime.now().toString(),
         
        });
        
        // return {'status': true, 'message': transactionList};
      } catch (e) {
        print(e.toString());
        // return {'status': false, 'message': 'An error occurred; please retry'};
      }
    }
     Future getTransactionList() async {
      try {
        dynamic transactionList = await _dbRef
            .child('TransactionList')
            
            .once()
            .then((DataSnapshot snapshot) {
          dynamic transactionList = snapshot.value;
          return transactionList;
        });
        // await setUserData(user: user);
        return transactionList;
      } catch (e) {
        print(e.toString());
      }
    
  }
  

  Future changePassword(String email, String currentPassword,
      String newPassword, String confirmPassword) async {
    Map checkCurrPass = await signInWithEmail(email, currentPassword);
    if (checkCurrPass['status']) {
      if (newPassword != confirmPassword) {
        return {'status': false, 'message': 'Passwords do not match'};
      }

      try {
        User user = FirebaseAuth.instance.currentUser;
        await user.updatePassword(newPassword);
        await saveDetails({});
        return {'status': true, 'message': 'Password changed successfully'};
      } catch (e) {
        print(e.toString());
        return {'status': false, 'message': e.message.toString()};
      }
    } else {
      return {'status': false, 'message': 'Current password is wrong'};
    }
  }

  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {'status': true, 'message': 'Password reset mail sent to $email'};
    } catch (e) {
      return {'status': false, 'message': e.message.toString()};
    }
  }
}
