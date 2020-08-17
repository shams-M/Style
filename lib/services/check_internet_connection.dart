
import 'package:connectivity/connectivity.dart';

class CheckInternetConnection{

  Future<bool> checkInternet()async{
    ConnectivityResult connectivityResult=await Connectivity().checkConnectivity();
    if(connectivityResult==ConnectivityResult.mobile|| connectivityResult==ConnectivityResult.wifi){
    return true;
    }
  }
}