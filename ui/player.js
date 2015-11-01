import playAudio from 'play-audio';

let player;

const urls = [
  { url: 'http://stream-tx4.radioparadise.com/mp3-192', type: 'mp3' },
  { url: 'http://stream-tx4.radioparadise.com/ogg-192', type: 'ogg' },
  { url: 'http://stream-dc1.radioparadise.com/aac-128', type: 'aac' }
];

export function play () {
  player = playAudio(urls).autoplay().play();

  if (/iPhone/.test(navigator.userAgent)) {
    player.controls();
  }
}

export function stop () {
  player.element().parentNode.removeChild(player.element());
}
