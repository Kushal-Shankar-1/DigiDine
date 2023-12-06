import React, { useState } from 'react';
import { Card, CardContent, Typography, TextField, Button, Menu, MenuItem, Select } from '@mui/material';
import { useNavigate } from 'react-router-dom';

const SignUpChef = () => {
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [email, setEmail] = useState('');
    const [restaurants, setRestaurants] = useState([]);
    const [selectedRestaurant, setSelectedRestaurant] = useState('');
    const [isError, setIsError] = useState(true);
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [username, setUsername] = useState('');

    const navigate = useNavigate();

    const handleFirstNameChange = (event) => {
        setFirstName(event.target.value);
    };

    const handleLastNameChange = (event) => {
        setLastName(event.target.value);
    };

    const handleContactChange = (event) => {
        setEmail(event.target.value);
    };
    const handlePasswordChange = (event) => {
        setPassword(event.target.value);
    };

    const handleConfirmPasswordChange = (event) => {
        setConfirmPassword(event.target.value);
    };

    const handleSubmit = () => {
        fetch('http://localhost:5000/api/chef', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                firstName: firstName,
                lastName: lastName,
                email: email,
                restaurantId: selectedRestaurant
            }),
        })
            .then((response) => {
                if (response.ok) {
                    setIsError(false);
                    return response.json();
                } else {
                    setIsError(true);
                    throw new Error('Something went wrong...');
                }
            })
            .then((data) => {
                console.log(data);
            })
            .catch((error) => {
                console.error('Error:', error);
            })
            navigate('/');
    };



    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            {isError && (
                <div style={{ position: 'fixed', top: '0', left: '0', width: '100%', backgroundColor: 'red', color: 'white', padding: '10px', textAlign: 'center' }}>
                    Error occurred during account creation
                </div>
            )}
            <Card style={{ width: '400px', padding: '20px' }}>
                <div>
                    <Typography variant="h4" style={{marginBottom: '10px'}}>Sign Up</Typography>
                    <form>
                    <TextField
                                label="Username"
                                value={username}
                                onChange={e=>setUsername(e.target.value)}
                                style={{ marginBottom: '10px' }}
                            />
                        <TextField
                            label="First Name"
                            value={firstName}
                            onChange={handleFirstNameChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField
                            label="Last Name"
                            value={lastName}
                            onChange={handleLastNameChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField
                            label="Email"
                            value={email}
                            onChange={handleContactChange}
                            style={{ marginBottom: '10px' }}
                        />
                        <Typography><i>Restaurant:</i> </Typography>
                        <Select style={{ marginRight: '11%' }}
                            value={selectedRestaurant}
                            onChange={(e) => setSelectedRestaurant(e.target.value)}
                        >
                             {restaurants.map((restaurant) => 
                                <MenuItem value={restaurant.restaurantId}>{restaurant.name}</MenuItem>)
                             }
                        </Select>
                        <TextField
                                label="Password"
                                value={password}
                                onChange={handlePasswordChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField
                                label="Confirm Password"
                                value={confirmPassword}
                                onChange={handleConfirmPasswordChange}
                                style={{ marginBottom: '10px' }}
                            />
                        <div>
                        <Button variant="contained" color="primary" onClick={handleSubmit} >
                            Submit
                        </Button>
                        </div> ̰
                    </form>
                </div>


                {/* Add more steps/questions here */}
            </Card>

        </div>
    );
};

export default SignUpChef;