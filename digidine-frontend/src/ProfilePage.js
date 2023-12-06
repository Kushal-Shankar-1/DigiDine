import React, { useEffect, useState } from 'react';
import { Container, TextField, Button, Typography, Card, CardContent, MenuItem, Select } from '@mui/material';
import axios from 'axios';

export default function ProfilePage() {
    const [firstName, setFirstName] = useState('John');
    const [lastName, setLastName] = useState('Doe');
    const [email, setEmail] = useState('johndoe@example.com');
    const [isEditing, setIsEditing] = useState(false);
    const [isEditingRestaurant, setIsEditingRestaurant] = useState(false);
    const [restaurant, setRestaurant] = useState([]);
    const [isChef, setIsChef] = useState(false);
    const [user, setUser] = setUser(sessionStorage.getItem('user'));

    const handleEdit = () => {
        setIsEditing(true);
    };

    const handleSubmit = () => {
        // Perform submit logic here
        axios.post('http://localhost:5000//update/email-address', { user_name:user, new_email:email })
             .then((response) => {
                 if(response.status == 200)
                    setIsEditing(false);
             })
             .catch(error =>{ console.error('Error updating email: ', error);
              alert("Invalid email!");
            });
    };

    const handleEditRestaurant = () => {
        setIsEditingRestaurant(true);
    }

    const handleSubmitRestaurant = () => {
        // Perform submit logic here
        setIsEditingRestaurant(false);
    }

    useEffect(() => {
        axios.get('http://localhost:5000/recipes')
             .then(response => {
                setRestaurant(response.data);
             })
             .catch(error => console.error('Error fetching data: ', error));
    }, []);


    return (
        <>
            <Container style={{ margin: "10%" }} maxWidth="md">
                <Card style={{ marginTop: '5%' }}>
                    <CardContent>
                        <Typography><i>First Name:</i> </Typography>
                        <TextField value={firstName} disabled />
                    </CardContent>
                    <CardContent>
                        <Typography><i>Last Name:</i> </Typography><TextField value={lastName} disabled />
                    </CardContent>

                    <CardContent>
                        <Typography ><i>Email:</i> </Typography>
                        <TextField style={{ marginRight: '5%' }} value={email} disabled={!isEditing} onChange={(e) => setEmail(e.target.value)}
                        />
                        {!isEditing && (
                            <Button variant="contained" onClick={handleEdit}>
                                Edit Email
                            </Button>
                        )}
                        {isEditing && (
                            <Button variant="contained" onClick={handleSubmit}>
                                Update
                            </Button>
                        )}
                    </CardContent>
                    {isChef && <CardContent>
                        <Typography><i>Restaurant:</i> </Typography>
                        <Select style={{ marginRight: '11%' }}
                            value={restaurant}
                            disabled={!isEditing}
                            onChange={(e) => setRestaurant(e.target.value)}
                        >
                            <MenuItem value="">Select Restaurant</MenuItem>
                            <MenuItem value="Restaurant 1">Restaurant 1</MenuItem>
                            <MenuItem value="Restaurant 2">Restaurant 2</MenuItem>
                            <MenuItem value="Restaurant 3">Restaurant 3</MenuItem>
                        </Select>
                        {!isEditingRestaurant && (
                            <Button variant="contained" onClick={handleEditRestaurant}>
                                Edit Restaurant
                            </Button>
                        )}
                        {isEditingRestaurant && (
                            <Button variant="contained" onClick={handleSubmitRestaurant}>
                                Update
                            </Button>
                        )}
                    </CardContent>}
                </Card>
            </Container>
        </>
    );
};

