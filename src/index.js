import './main.css';
import { StoryTime } from './StoryTime.elm';
import registerServiceWorker from './registerServiceWorker';

const target = document.getElementById('root');

const component = StoryTime.embed(target);

component.ports.sendStoryToRead.subscribe((text) => {
  var u = new SpeechSynthesisUtterance();
  u.text = text;
  u.lang = 'en-GB';
  speechSynthesis.speak(u);
  console.log(text);
});

registerServiceWorker();
