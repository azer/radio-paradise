import { combineReducers } from 'redux';
import { GOT_NEW_SONGS, PLAY, STOP, TOGGLE } from './actions';

export default combineReducers({
  songs,
  player
});

function songs (state = [], action) {
  switch (action.type) {
  case GOT_NEW_SONGS:
    return action.songs;
  default:
    return state;
  }
}

function player (state = 0, action) {
  switch (action.type) {
  case PLAY:
    return 1;
  case STOP:
    return 0;
  case TOGGLE:
    return state == 0 ? 1 : 0;
  default:
    return state;
  }
}
