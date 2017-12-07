import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const target = document.getElementById('root');

const component = Main.embed(target);

component.ports.sendStoryToRead.subscribe((text) => {
  var u = new SpeechSynthesisUtterance();
  u.text = text;
  u.lang = 'en-GB';
  speechSynthesis.speak(u);
  console.log(text);
});

registerServiceWorker();
