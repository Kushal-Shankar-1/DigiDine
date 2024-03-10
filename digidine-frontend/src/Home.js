import React, {useEffect, useState} from 'react';
import SignIn from './SignIn';
import UserPage from './UserPage';
import ChefPage from './ChefPage';
import { useSelector } from 'react-redux';

export default function Home() {
    const loggedIn = useSelector(state => state.loggedIn);
    const [userType, setUserType] = useState('chef');
    const user = useSelector(state => state.user);
    useEffect(() => {
        if (user !== null ) {
            setUserType(user.restaurant_name === undefined ? 'user' : 'chef');
        }
    }
    , [loggedIn, user]);

  return (
    loggedIn? (
      userType === 'user' ?(
      <UserPage />) : <ChefPage />
  ): (<SignIn /> ));
}