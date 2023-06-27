import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final loginProvider = StateNotifierProvider<LoginProvider, bool>((ref) => LoginProvider(true));

class LoginProvider extends StateNotifier<bool>{
  LoginProvider(super.state);
  void toggle(){
    state = !state;
  }
}



final imageProvider = StateNotifierProvider.autoDispose<ImageProvider, XFile?>((ref) => ImageProvider(null));

class ImageProvider extends StateNotifier<XFile?>{
  ImageProvider(super.state);

  final ImagePicker picker = ImagePicker();
  void pickUImage(bool isCamera) async{
     if(isCamera){
       state= await picker.pickImage(source: ImageSource.camera);
     }else{
       state= await picker.pickImage(source: ImageSource.gallery);
     }
  }

}

final aPro = StateNotifierProvider<A, int>((ref) => A(0));

class A extends StateNotifier<int>{
  A(super.state);
  void change(){
    state =  state + 1;
  }

}


class Movie{
  final String title;
  final bool isLoad;

  Movie({
    required this.isLoad,
    required this.title
});

  Movie copyWith({bool? isLoad, String? title}){
    return Movie(
        isLoad: isLoad ?? this.isLoad,
        title: title ?? this.title
    );
  }

}


final movieProvider = StateNotifierProvider<MoviePro, Movie>((ref) => MoviePro(
  Movie(isLoad: false, title: '')
));

class MoviePro extends StateNotifier<Movie>{
  MoviePro(super.state);

  void callData() async{
    state = state.copyWith(isLoad: true, title: '');
    await Future.delayed(Duration(seconds: 2));
    state = state.copyWith(isLoad: false, title: 'movie aayo');
  }


}