import { render } from 'react-dom';
import React from 'react';
import { Provider } from 'react-redux';
import RadioParadise from './app';
import store from './store';

render(
  <Provider store={store()}>
    {<RadioParadise />}
  </Provider>,
  document.getElementById('radio-paradise')
);
