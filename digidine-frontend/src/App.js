// App.js - Entry point
import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import SignIn from './SignIn';
import SignUp from './SignUp';
import SignUpChef from './SignUpChef';
import SignUpOption from './SignUpOption';
import Home from './Home';

// import LoggedInPortal from './LoggedInPortal';
// import Fridge from './Fridge';
// import CreateDish from './CreateDish';

const App = () => {
  const [loggedIn, setLoggedIn] = useState(false);

  // Functions to handle login, logout, and fridge modifications

  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home loggedIn={loggedIn} setLoggedIn={setLoggedIn} />} />
        <Route path="/signup"  element={<SignUp />} />
        <Route path="/signupOption"  element={<SignUpOption />} />
        <Route path="/signupchef"  element={<SignUpChef />} />
    
        {/*
        <Route path="/portal" exact>
          <LoggedInPortal loggedIn={loggedIn} fridgeItems={fridgeItems} />
        </Route>
        <Route path="/fridge" exact>
          <Fridge fridgeItems={fridgeItems} setFridgeItems={setFridgeItems} />
        </Route>
        <Route path="/create-dish" exact>
          <CreateDish fridgeItems={fridgeItems} />
        </Route> */}
      </Routes>
    </Router>
  );
};

export default App;
