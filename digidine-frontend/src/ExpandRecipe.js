import React, { useEffect, useState } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText, Grid, Stack, CardMedia } from '@mui/material';
import axios from 'axios';

const ExpandRecipe = (props) => {
    // Dummy image URL
    const imageUrl = 'https://dummyimage.com/200x100/000/fff';

    // State variable to store the instructions
    const [instructions, setInstructions] = useState([
        'Preheat the oven to 350°F',
        'Mix the dry ingredients in a bowl',
        'Add the wet ingredients and stir well',
        'Pour the batter into a greased baking pan',
        'Bake for 30 minutes or until golden brown',
        'Let it cool before serving'
    ]);
    const [recipe, setRecipe] = useState(null);
    useEffect(() => {
        axios.get(`http://localhost:5000/recipes/information/${props.selectedRecipe}`)
            .then(response => {
                setRecipe(response.data);
                console.log(response.data);
            })
            .catch(error => console.error('Error fetching data: ', error));
    }
        , []);
    if (recipe == null)
        return false;
    return (
        <Container maxWidth="md">
            <Card>
            <CardMedia
                    component="div"
                    sx={{
                      // 16:9
                      pt: '56.25%',
                    }}
                    image={recipe.image==null || recipe.image==""? "https://source.unsplash.com/random?wallpapers": recipe.image}
                  />
                {/* <img src={recipe.image} alt="Recipe Image" style={{ width: '100%', height: 'auto' }} /> */}
                <CardContent>
                    <Typography variant="h5" component="div" gutterBottom>
                        Cooking Instructions for {recipe.dish_name}
                    </Typography>
                    <List>
                        {recipe.cooking_instructions.map((instruction, index) => (
                            <ListItem key={index}>
                                <ListItemText primary={`Step ${index + 1}: ${instruction.step_description}`} />
                            </ListItem>
                        ))}
                    </List>

                    {recipe.dietary_restrictions.length > 0 && <>
                        <Stack sx={{ pt: 4 }} direction="row" spacing={2}>
                            <Typography><b>Adheres to:</b> </Typography>
                            {recipe.dietary_restrictions.map((restriction, index) => (
                                <Typography>{restriction} </Typography>
                            ))}
                        </Stack>
                    </>}
                    {recipe.flavours.length > 0 && <>
                        <Stack sx={{ pt: 4 }} direction="row" spacing={2}>
                            <Typography><b>Flavours:</b> </Typography>
                            {recipe.flavours.filter(flavour=> flavour.is_present).map((flavour, index) => (
                                <Typography>{flavour.flavour_name} </Typography>
                            ))}
                        </Stack>
                    </>}
                    {recipe.ingredients.length > 0 && <>
                        <Stack sx={{ pt: 4 }} direction="row" spacing={2}>
                            <Typography><b>Ingredients:</b> </Typography>
                            {recipe.ingredients.filter(ingredient=> ingredient.is_present).map((ingredient, index) => (
                                <Typography>{ingredient.ingredient_name} </Typography>
                            ))}
                        </Stack>
                    </>}
                </CardContent>
            </Card>
        </Container>
    );
};

export default ExpandRecipe;

