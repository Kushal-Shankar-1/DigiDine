import React, { useEffect, useState } from 'react';
import { Card, Typography, TextField, Button, MenuItem, Select } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const SignUpChef = () => {
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [email, setEmail] = useState('');
    const [restaurants, setRestaurants] = useState([]);
    const [selectedRestaurant, setSelectedRestaurant] = useState('Select your restaurant');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [username, setUsername] = useState('');

    const navigate = useNavigate();
    useEffect(() => {
        axios.get('http://localhost:5000/restaurants')
            .then((response) => {
                setRestaurants(response.data);
            })
            .catch((error) => {
                console.log(error);

            })},[]);

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
        if (password !== confirmPassword) {
            alert("Passwords don't match");
            return;
        }
        if(username === '' || password === '' || firstName === '' || lastName === '' || email === ''){
            alert("Please fill all the fields");
            return;
        }
        console.log("Selected Restaurant",selectedRestaurant);
        axios.post('http://localhost:5000/register/chef', 
            {
                username: username,
                password: password,
                firstName: firstName,
                lastName: lastName,
                email: email,
                restaurantId: selectedRestaurant.restaurant_id
            }
        )
            .then((response) => {
                alert('Registration Successful');
                navigate('/');
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('Registration Failed: ' + error.response.data.error.split(':')[1]);
            })
    };



    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <Card style={{ width: '400px', padding: '20px' }}>
                <div>
                    <Typography variant="h4" style={{marginBottom: '10px'}}>Sign Up</Typography>
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
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField fullWidth
                            label="Last Name"
                            value={lastName}
                            onChange={handleLastNameChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField fullWidth
                            label="Email"
                            value={email}
                            onChange={handleContactChange}
                            style={{ marginBottom: '10px' }}
                        />
                        <Typography><i>Restaurant:</i> </Typography>
                        <Select style={{ marginBottom: '10px' }}
                            value={selectedRestaurant!==''? selectedRestaurant.name : "Select you restaurant"} fullWidth
                        >
                            <MenuItem value={'Select your restaurant'} disabled>Select your restaurant</MenuItem>
                            {restaurants.map((restaurant) => 
                                <MenuItem onClick={(e) => setSelectedRestaurant(restaurant)} value={restaurant.name}>{restaurant.name} {restaurant.cuisin_type !== undefined? ' - ' +restaurant.cuisin_type:''}</MenuItem>
                            )}
                        </Select>
                        <TextField
                                label="Password"
                                value={password} fullWidth
                                type='password'
                                onChange={handlePasswordChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField fullWidth
                                label="Confirm Password"
                                type='password'
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