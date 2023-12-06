import React, {useEffect, useState} from 'react';
import SignIn from './SignIn';
import UserPage from './UserPage';
import ChefPage from './ChefPage';

const cards = [1, 2, 3, 4, 5, 6, 7, 8, 9];


export default function Home(props) {
    const [loggedIn, setLoggedIn] = useState(sessionStorage.getItem('loggedIn') === 'true');
    const [userType, setUserType] = useState('chef');
    const [user, setUser] = useState(JSON.parse(sessionStorage.getItem('user')));

    useEffect(() => {
        if (sessionStorage.getItem('user') !== null) {
            setUserType(JSON.parse(sessionStorage.getItem('user')).restaurant_name === undefined ? 'user' : 'chef');
        }
        props.setLoggedIn(loggedIn);
    }
    , [loggedIn]);

  return (
    loggedIn? (
      userType === 'user' ?(
      <UserPage user={user} />) : <ChefPage user={user}/>
  ): (<SignIn setLoggedIn={setLoggedIn}/> ));
}