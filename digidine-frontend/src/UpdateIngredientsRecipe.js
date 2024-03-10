import React, { useEffect, useState } from 'react';
import { Card, CardContent, Container, Grid, Paper, Typography } from '@mui/material';
import axios from 'axios';


const UpdateIngredientsRecipe = (props) => {
    const [recipe] = useState(props.recipe);
    const [currentIngredients, setCurrentIngredients] = useState([]);
    const [availableIngredients, setAvailableIngredients] = useState([]);

    const handleRemove = (event) => {
        axios.post(`http://localhost:5000/recipe/remove-ingredient`, {recipe_id: recipe, ingredient:event})
        setAvailableIngredients([...availableIngredients, event]);
        setCurrentIngredients(currentIngredients.filter((r) => r !== event));
        console.log(event);
    }

    const handleAdd = (event) => {
        axios.post(`http://localhost:5000/recipe/add-ingredient`, {recipe_id: recipe, ingredient:event})
        .then((response) => {
            setCurrentIngredients([...currentIngredients, event]);
            setAvailableIngredients(availableIngredients.filter((r) => r !== event));
        })
        .catch((error) => {
            console.log(error);
        })

    }
    useEffect(() => {
        setCurrentIngredients(props.data.filter((i) => i.is_present === true).map((i) => i.ingredient_name));
        setAvailableIngredients(props.data.filter((i) => i.is_present === false).map((i) => i.ingredient_name));
    }, [props.data]);

    return (
        <Container maxWidth="md">
            <Grid container spacing={2} justifyContent="center">
                <Grid item xs={6}>
                    <Paper style={{background:"lightblue"}}>
                        <Typography align="center" variant="h6">Current Ingredients</Typography>
                        {currentIngredients.map((ingredient, index) => (
                            <Card key={index} value={ingredient} style={{cursor:"pointer", background:"cornsilk"}} onClick={()=>handleRemove(ingredient)}>
                                <CardContent><Typography>{ingredient}</Typography></CardContent>
                                </Card>
                        ))}
                    </Paper>
                </Grid>
                <Grid item xs={6}>
                    <Paper style={{background:"lightblue"}}>
                        <Typography align="center" variant="h6">Available Ingredients</Typography>
                        {availableIngredients.map((ingredient, index) => (
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

export default UpdateIngredientsRecipe;
