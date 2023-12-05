import React from 'react';
import { Container, Grid, Paper, Typography } from '@mui/material';


const UpdateInventory = () => {

    const currentIngredients = ['Ingredient 1', 'Ingredient 2', 'Ingredient 3'];
    const availableIngredients = ['Ingredient 4', 'Ingredient 5', 'Ingredient 6'];

    return (
        <Container maxWidth="md">
            <Grid container spacing={2} justifyContent="center">
                <Grid item xs={6}>
                    <Paper>
                        <Typography variant="h6">Current Ingredients</Typography>
                        {currentIngredients.map((ingredient, index) => (
                            <Typography key={index}>{ingredient}</Typography>
                        ))}
                    </Paper>
                </Grid>
                <Grid item xs={6}>
                    <Paper>
                        <Typography variant="h6">Available Ingredients</Typography>
                        {availableIngredients.map((ingredient, index) => (
                            <Typography key={index}>{ingredient}</Typography>
                        ))}
                    </Paper>
                </Grid>
            </Grid>
        </Container>
    );
};

export default UpdateInventory;
