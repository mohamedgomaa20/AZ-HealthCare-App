// import 'package:dartz/dartz.dart';
//
//
// import '../../domain/models/user_model.dart';
// import '../../domain/respotries/auth_repo.dart';
//
// class AuthRepoImpl extends AuthRepo {
//   Future<Either<Exception, UserModel>> completeInformation(
//       {String? name,
//       String? phoneNumber,
//       String? address,
//       UserModel? user}) async {
//     try {
//       // CollectionReference users =
//       //     FirebaseFirestore.instance.collection('users');
//       //
//       // UserModel userModel = UserModel(
//       //     email: user!.email,
//       //     name: name,
//       //     phonNumber: phoneNumber,
//       //     address: address);
//       // await users.add(userModel.toJson());
//       // return Right(userModel);
//     } on Exception catch (e) {
//       return Left(e);
//     }
//   }
//
//   @override
//   Future<Either<Exception, UserModel>> loginWithFacebook() async {
//     try {
//       // Trigger the sign-in flow
//       final LoginResult loginResult = await FacebookAuth.instance.login();
//
//       // Create a credential from the access token
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(loginResult.accessToken!.token);
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithCredential(facebookAuthCredential);
//       // Once signed in, return the UserCredential
//       return Right(UserModel(
//         email: userCredential.user!.email!,
//       ));
//     } catch (e) {
//       return Left(Exception('someting went wrong'));
//     }
//   }
//
//   @override
//   Future<Either<Exception, UserModel>> loginWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser!.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//
//       return Right(UserModel(
//         email: userCredential.user!.email!,
//       ));
//     } catch (e) {
//       return Left(Exception('something went wrong'));
//     }
//   }
// }
