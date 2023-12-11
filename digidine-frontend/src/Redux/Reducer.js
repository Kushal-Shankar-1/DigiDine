import { LOG_IN, LOG_OUT } from './Actions';

const initialState = {
  loggedIn: false,
  user: null,
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case LOG_IN:
      return { ...state, loggedIn: true, user: action.payload.user };
    case LOG_OUT:
      return { ...state, loggedIn: false, user: null };
    default:
      return state;
  }
};

export default reducer;