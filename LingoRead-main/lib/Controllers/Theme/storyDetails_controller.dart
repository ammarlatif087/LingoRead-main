import 'package:get/get.dart';
import 'package:translator/translator.dart';

class StoryDetailsControllers extends GetxController {
  dynamic story = {}.obs;
  var storyDiscription = "".obs;
  var listStoryDisWords = [].obs;
  List listStoryDisWordsTemp = [];
  List listStoryDisWordsTemp2 = [];

  var wordToTranslate = "".obs;
  var translatedWord = "".obs;
  var selectedWordIndex = (-1).obs;

  setStory(dynamic value) {
    story.value = value;
    String disc = (value ?? {})["description"] ?? "";
    String withoutcomman = disc.replaceAll(",", "");
    String withoutDot = withoutcomman.replaceAll(".", "");
    storyDiscription.value = disc;
    listStoryDisWords.value = disc.split(" ");
    listStoryDisWordsTemp = withoutDot.split(" ");
    listStoryDisWordsTemp2 = withoutDot.split(" ");
  }

  setPlayingIndex(String word) {
    print("Call for Word $word");
    int wordindex = listStoryDisWordsTemp.indexOf(word);
    print("Word index $wordindex");
    listStoryDisWordsTemp[wordindex] = "^&*!";
    selectedWordIndex.value = wordindex;
  }

  getNewStringtoPlay() async {
    List newList = listStoryDisWordsTemp2.sublist(selectedWordIndex.value);
    String newText = newList.join(" ");
    return newText;
  }

  playAudioWherePaused() {}

  resetDataAfterRead() {
    listStoryDisWordsTemp = [...listStoryDisWordsTemp2];
    selectedWordIndex.value = -1;
  }

  setWordForTranslation(int index, String word) async {
    selectedWordIndex.value = index;
    wordToTranslate.value = word;
    translatedWord.value = "...";
    final translator = GoogleTranslator();

    try {
      Translation translated =
          await translator.translate(word, from: 'de', to: 'en');
      translatedWord.value = translated.text;
    } on Exception catch (e) {
      translatedWord.value = "";
    }
  }
}
