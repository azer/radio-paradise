import { createStore, applyMiddleware } from 'redux';
import reducer from './reducer';
import thunk from 'redux-thunk';

const createAsyncStore = applyMiddleware(thunk)(createStore);

export default function store () {
  return createAsyncStore(reducer);
}
