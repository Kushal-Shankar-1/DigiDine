import React, { useState } from 'react';
import { Card, CardContent, Container, Grid, Paper, Typography } from '@mui/material';


const UpdateInventory = () => {

    const [currentIngredients, setCurrentIngredients] = useState(['Ingredient 1', 'Ingredient 2', 'Ingredient 3']);
    const [availableIngredients, setAvailableIngredients] = useState(['Ingredient 4', 'Ingredient 5', 'Ingredient 6']);

    const handleRemove = (event) => {
        setAvailableIngredients([...availableIngredients, event]);
        setCurrentIngredients(currentIngredients.filter((r) => r !== event));
        console.log(event);
    }

    const handleAdd = (event) => {
        setCurrentIngredients([...currentIngredients, event]);
        setAvailableIngredients(availableIngredients.filter((r) => r !== event));
        console.log(event);
    }

    return (
        <Container maxWidth="md">
            <Grid container spacing={2} justifyContent="center">
                <Grid item xs={6}>
                    <Paper style={{background:"lightblue"}}>
                        <Typography align="center" variant="h6">Current Ingredients</Typography>
                        {currentIngredients.length == 0 ? 
                        <Card style={{background:"lightcyan"}}>
                        <CardContent><Typography style={{paddingTop:'5%'}} align='center' ><i>Psst psst! Time to go grocery shopping, maybe?</i></Typography></CardContent>
                        </Card>
                        : currentIngredients.map((ingredient, index) => (
                            <Card key={index} value={ingredient} style={{cursor:"pointer", background:"cornsilk"}} onClick={()=>handleRemove(ingredient)}>
                                <CardContent><Typography>{ingredient}</Typography></CardContent>
                                </Card>
                        ))}
                    </Paper>
                </Grid>
                <Grid item xs={6}>
                    <Paper style={{background:"lightblue"}}>
                        <Typography align="center" variant="h6">Available Ingredients</Typography>
                        {availableIngredients.length == 0 ?
                        <Card style={{background:"lightcyan"}}>
                        <CardContent><Typography style={{paddingTop:'5%'}} align='center' ><i>Looks like someone has done a good job with their grocery shopping! Now let's get cooking. Chop chop!</i></Typography></CardContent>
                        </Card>
                        :
                        availableIngredients.map((ingredient, index) => (
                            <Card key={index} value={ingredient} onClick={()=>handleAdd(ingredient)} style={{cursor:"pointer", background:"LavenderBlush"}} >
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
