import React, {useEffect, useState} from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import SignIn from './SignIn';
import Header from './Header';
import Footer from './Footer';
import Recipes from './Recipes';
import ChefPage from './ChefPage';

const cards = [1, 2, 3, 4, 5, 6, 7, 8, 9];

// TODO remove, this demo shouldn't need to reset the theme.
const defaultTheme = createTheme();

export default function Home(props) {
    const [loggedIn, setLoggedIn] = useState();
    const [userType, setUserType] = useState('user');

    useEffect(() => {
        if (localStorage.getItem('token')) {
            setLoggedIn(true);
        }
        console.log("PROPS UPDATED", props);
    }
    , [loggedIn]);

  return (
    loggedIn? (
      userType === 'user' ?(
      <Recipes />) : <ChefPage />
  ): (<SignIn setLoggedIn={setLoggedIn}/> ));
}