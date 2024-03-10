import React, { useState } from 'react';
import { Card, Typography, TextField, Button } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const SignUp = () => {
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [contact, setContact] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [username, setUsername] = useState('');
    const [fridgeColor] = useState('blue');

    const navigate = useNavigate();

    const handleFirstNameChange = (event) => {
        setFirstName(event.target.value);
    };

    const handleLastNameChange = (event) => {
        setLastName(event.target.value);
    };

    const handleContactChange = (event) => {
        setContact(event.target.value);
    };

    const handlePasswordChange = (event) => {
        setPassword(event.target.value);
    };

    const handleConfirmPasswordChange = (event) => {
        setConfirmPassword(event.target.value);
    };

    const handleSubmit = () => {
        if(username === '' || password === '' || firstName === '' || lastName === '' || contact === ''){
            alert("Please fill all the fields");
            return;
        }
        axios.post('http://localhost:5000/register/user', {
            firstName: firstName,
            lastName: lastName,
            email: contact,
            password: password,
            username: username,
            fridgeColor: fridgeColor
        })
            .then((response) => {
                alert('Registration Successful');
                // sessionStorage.setItem('user', JSON.stringify(response.data));
                // sessionStorage.setItem('loggedIn', true);
                navigate('/');
            })
            .catch((error) => {
                alert('Registration Failed: ' + error.response.data.error.split(':')[1]);
            });
    }

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <Card style={{ width: '400px', padding: '20px' }}>
                    <div>
                        <Typography variant="h4">Sign Up</Typography>
                        <form>
                        <TextField fullWidth
                                label="Username"
                                value={username}
                                onChange={e=>setUsername(e.target.value)}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField fullWidth
                                label="First Name"
                                value={firstName}
                                onChange={handleFirstNameChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField fullWidth
                                label="Last Name"
                                value={lastName}
                                onChange={handleLastNameChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField fullWidth
                                label="Email Id"
                                value={contact}
                                onChange={handleContactChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField fullWidth
                                label="Password"
                                value={password}
                                type="password"
                                onChange={handlePasswordChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField fullWidth
                                label="Confirm Password"
                                value={confirmPassword}
                                type="password"
                                onChange={handleConfirmPasswordChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <Button disabled={password ==='' || password!==confirmPassword} variant="contained" color="primary" onClick={handleSubmit}>
                                Submit
                            </Button>
                        </form>
                    </div>
            </Card>
        </div>
    );
};

export default SignUp;