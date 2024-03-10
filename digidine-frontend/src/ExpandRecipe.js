import React, { useEffect, useState } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText, Stack, CardMedia } from '@mui/material';
import axios from 'axios';

const ExpandRecipe = (props) => {

    const [recipe, setRecipe] = useState(null);
    useEffect(() => {
        axios.get(`http://localhost:5000/recipes/information/${props.selectedRecipe}`)
            .then(response => {
                setRecipe(response.data);
                console.log(response.data);
            })
            .catch(error => console.error('Error fetching data: ', error));
    }
        , [props.selectedRecipe]);
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
                    image={recipe.image == null || recipe.image === "" ? "https://source.unsplash.com/random?wallpapers" : recipe.image}
                />
                {/* <img src={recipe.image} alt="Recipe Image" style={{ width: '100%', height: 'auto' }} /> */}
                
                <CardContent>
                {recipe.ingredients.length > 0 && <>
                        <Stack sx={{ pt: 4 }} direction="row" spacing={2}>
                            <Typography><b>Ingredients:</b> </Typography>
                            {recipe.ingredients.filter(ingredient => ingredient.is_present).map((ingredient, index) => (
                                <Typography><i>{ingredient.ingredient_name}</i> </Typography>
                            ))}
                        </Stack>
                    </>}
                    <Typography variant="h5" component="div" gutterBottom style={{marginTop:'5%'}}>
                        Cooking Instructions for {recipe.dish_name}
                    </Typography>
                    <List>
                        {recipe.cooking_instructions.map((instruction, index) => (
                            <ListItem key={index}>
                                <ListItemText primary={<><b>Step {index + 1}: </b> {instruction.step_description}</>} />
                            </ListItem>
                        ))}
                    </List>

                    {/* {recipe.dietary_restrictions.length > 0 && <>
                        <Stack sx={{ pt: 4 }} direction="row" spacing={2}>
                            <Typography><b>Adheres to:</b> </Typography>
                            {recipe.dietary_restrictions.map((restriction, index) => (
                                <div key={index} style={{ overflowWrap: 'break-word' }}>
                                <Typography>{restriction}</Typography>
                            </div>
                            ))}
                        </Stack>
                    </>}
                     */}

                    {recipe.flavours.length > 0 && <>
                        <Stack sx={{ pt: 4 }} direction="row" spacing={2}>
                            <Typography><b>Flavours:</b> </Typography>
                            {recipe.flavours.filter(flavour => flavour.is_present).map((flavour, index) => (
                                <Typography><i>{flavour.flavour_name}</i> </Typography>
                            ))}
                        </Stack>
                    </>}
                    {recipe.dietary_restrictions.length > 0 && (
                        <div style={{ paddingTop: '1rem', display: 'flex', flexDirection: 'row', gap: '1rem', flexWrap: 'wrap' }}>
                            <Typography><b>Adheres to:</b></Typography>
                            {recipe.dietary_restrictions.map((restriction, index) => (
                                <div key={index} style={{ overflowWrap: 'break-word' }}>
                                    <Typography><i>{restriction}</i></Typography>
                                </div>
                            ))}
                        </div>
                    )}
                </CardContent>
            </Card>
        </Container>
    );
};

export default ExpandRecipe;

