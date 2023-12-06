import React, { useEffect, useState } from 'react';
import { Card, CardContent, Container, Grid, Paper, Typography } from '@mui/material';
import axios from 'axios';

const UpdateInventory = (props) => {
    const [currentIngredients, setCurrentIngredients] = useState([]);
    const [availableIngredients, setAvailableIngredients] = useState([]);
    const [fridgeId, setFridgeId] = useState(props.fridgeId);

    useEffect(() => {
        axios.get(`http://localhost:5000/fridge/${fridgeId}/ingredients`)
            .then((response) => {
                console.log(response.data.filter((ingredient) => ingredient.is_present == true));
                setCurrentIngredients(response.data.filter((ingredient) => ingredient.is_present == true).map((ingredient) => ingredient.fridge_ingredients));
                setAvailableIngredients(response.data.filter((ingredient) => ingredient.is_present == false).map((ingredient) => ingredient.fridge_ingredients));
            }
            )
    }, []);
    
    const handleRemove = (ingredient) => {
        axios.post(`http://localhost:5000/fridge/${fridgeId}/ingredient`, { ingredient: ingredient, is_present: false })
            .then((response) => {
                console.log("FRIDGE INGREDIENT",response);
                if (response.status == 200) {
                    setAvailableIngredients([...availableIngredients, ingredient]);
                    setCurrentIngredients(currentIngredients.filter((r) => r !== ingredient));
                }
            })
            .catch((error) => {
                console.log(error);
            });
    }

    const handleAdd = (ingredient) => {
        axios.post(`http://localhost:5000/fridge/${fridgeId}/ingredient`, { ingredient: ingredient, is_present: true })
            .then((response) => {
                console.log("FRIDGE INGREDIENT",response);
                if (response.status == 200) {
                    setCurrentIngredients([...currentIngredients, ingredient]);
                    setAvailableIngredients(availableIngredients.filter((r) => r !== ingredient));
                }
            })
            .catch((error) => {
                console.log(error);
            });
    }

    return (
        <Container maxWidth="md">
            <Grid container spacing={2} justifyContent="center">
                <Grid item xs={6}>
                    <Paper style={{ background: "lightblue" }}>
                        <Typography align="center" variant="h6">Current Ingredients</Typography>
                        {currentIngredients.length == 0 ?
                            <Card style={{ background: "lightcyan" }}>
                                <CardContent><Typography style={{ paddingTop: '5%' }} align='center' ><i>Psst psst! Time to go grocery shopping, maybe?</i></Typography></CardContent>
                            </Card>
                            : currentIngredients.map((ingredient, index) => (
                                <Card key={index} value={ingredient} style={{ cursor: "pointer", background: "cornsilk" }} onClick={() => handleRemove(ingredient)}>
                                    <CardContent><Typography>{ingredient}</Typography></CardContent>
                                </Card>
                            ))}
                    </Paper>
                </Grid>
                <Grid item xs={6}>
                    <Paper style={{ background: "lightblue" }}>
                        <Typography align="center" variant="h6">Available Ingredients</Typography>
                        {availableIngredients.length == 0 ?
                            <Card style={{ background: "lightcyan" }}>
                                <CardContent><Typography style={{ paddingTop: '5%' }} align='center' ><i>Looks like someone has done a good job with their grocery shopping! Now let's get cooking. Chop chop!</i></Typography></CardContent>
                            </Card>
                            :
                            availableIngredients.map((ingredient, index) => (
                                <Card key={index} value={ingredient} onClick={() => handleAdd(ingredient)} style={{ cursor: "pointer", background: "LavenderBlush" }} >
                                    <CardContent><Typography>{ingredient}</Typography></CardContent>
                                </Card>
                            ))}
                    </Paper>
                </Grid>
            </Grid>
        </Container>
    );
};

export default UpdateInventory;
