import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const target = document.getElementById('root');

const component = Main.embed(target);

component.ports.sendStoryToRead.subscribe((story) => {
  var u = new SpeechSynthesisUtterance();
  u.text = story;
  u.lang = 'en-GB';
  speechSynthesis.speak(u);
  console.log(story);
});

registerServiceWorker();
