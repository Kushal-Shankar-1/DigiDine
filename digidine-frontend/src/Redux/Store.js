import reducer from './Reducer';
import {configureStore} from '@reduxjs/toolkit';

const store = configureStore({
  reducer
});

export default store;