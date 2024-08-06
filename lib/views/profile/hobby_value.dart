import 'package:amommy/views/profile/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'hobby_value.g.dart';

@riverpod
class HobbyValue extends _$HobbyValue {
  @override
  List<String> build() => ref.watch(userProvider)?.hobbies ?? [];

  void onHobbyChanged(int index, String hobby) {
    final hobbies = state;
    hobbies[index] = hobby;
    state = [...hobbies];
  }

  void addHobby() {
    final hobbies = state;
    hobbies.add("");
    state = [...hobbies];
  }

  void removeHobby(int index) {
    final hobbies = state;
    hobbies.removeAt(index);
    state = [...hobbies];
  }
}
