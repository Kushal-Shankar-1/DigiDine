import React, {useEffect, useState} from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import SignIn from './SignIn';
import Header from './Header';
import Footer from './Footer';
import UserPage from './UserPage';
import ChefPage from './ChefPage';

const cards = [1, 2, 3, 4, 5, 6, 7, 8, 9];


export default function Home(props) {
    const [loggedIn, setLoggedIn] = useState(sessionStorage.getItem('loggedIn') === 'true');
    const [userType, setUserType] = useState('user');

    useEffect(() => {
        if (localStorage.getItem('token')) {
            setLoggedIn(true);
        }
        props.setLoggedIn(loggedIn);
    }
    , [loggedIn]);

  return (
    loggedIn? (
      userType === 'user' ?(
      <UserPage />) : <ChefPage />
  ): (<SignIn setLoggedIn={setLoggedIn}/> ));
}