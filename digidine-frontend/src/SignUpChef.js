import React, { useState } from 'react';
import { Card, CardContent, Typography, TextField, Button, Checkbox } from '@mui/material';
import { useNavigate } from 'react-router-dom';

const SignUpChef = () => {
    const [name, setName] = useState('');
    const [contact, setContact] = useState('');
    const [restaurantName, setRestaurantName] = useState('');
    const [restaurantStreetName, setRestaurantStreetName] = useState('');
    const [restaurantCity, setRestaurantCity] = useState('');
    const [restaurantState, setRestaurantState] = useState('');
    const [restaurantZip, setRestaurantZip] = useState('');
    const [isError, setIsError] = useState(true);

    const navigate = useNavigate();

    const handleNameChange = (event) => {
        setName(event.target.value);
    };

    const handleContactChange = (event) => {
        setContact(event.target.value);
    };

    const handleSubmit = () => {
        fetch('http://localhost:8080/api/chef', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                chefName: name,
                chefContact: contact,
                restaurantName: restaurantName,
                restaurantStreetName: restaurantStreetName,
                restaurantCity: restaurantCity,
                restaurantState: restaurantState,
                restaurantZip: restaurantZip,
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

    const handleRestaurantNameChange = (event) => {
        setRestaurantName(event.target.value);
    }
    const handleRestaurantStreetNameChange = (event) => {
        setRestaurantStreetName(event.target.value);
    }
    const handleRestaurantCityChange = (event) => {
        setRestaurantCity(event.target.value);
    }
    const handleRestaurantStateChange = (event) => {
        setRestaurantState(event.target.value);
    }
    const handleRestaurantZipChange = (event) => {
        setRestaurantZip(event.target.value);
    }


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
                            label="Name"
                            value={name}
                            onChange={handleNameChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField
                            label="Contact"
                            value={contact}
                            onChange={handleContactChange}
                            style={{ marginBottom: '10px' }}
                        />
                        <TextField
                            label="Restaurant Name"
                            value={restaurantName}
                            onChange={handleRestaurantNameChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField
                            label="Restaurant Street Name"
                            value={restaurantStreetName}
                            onChange={handleRestaurantStreetNameChange}
                            style={{ marginBottom: '10px' }}
                        />
                        <TextField
                            label="Restaurant City"
                            value={restaurantCity}
                            onChange={handleRestaurantCityChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
                        />
                        <TextField
                            label="Restaurant State"
                            value={restaurantState}
                            onChange={handleRestaurantStateChange}
                            style={{ marginBottom: '10px' }}
                        />
                        <TextField
                            label="Restaurant Zip"
                            value={restaurantZip}
                            onChange={handleRestaurantZipChange}
                            style={{ marginBottom: '10px', marginRight: '10px' }}
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