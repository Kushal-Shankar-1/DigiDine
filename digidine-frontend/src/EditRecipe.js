import React, { useEffect, useState } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText, TextField, IconButton, Button } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import EditIcon from '@mui/icons-material/Edit';
import UpdateFlavourRecipe from './UpdateFlavourRecipe';
import UpdateIngredientsRecipe from './UpdateIngredientsRecipe';
import axios from 'axios';
import UpdateInstruction from './UpdateInstruction';

const EditRecipe = (props) => {
    // Dummy image URL
    const imageUrl = 'https://dummyimage.com/200x100/000/fff';

    // State variable to store the instructions
    const [instructions, setInstructions] = useState([]);

    const [recipe, setRecipe] = useState(null);

    const [image, setImage] = useState('');
    
    useEffect(() => {
        axios.get(`http://localhost:5000/recipes/information/${props.selectedRecipe}`)
            .then(response => {
                setRecipe(response.data);
                setInstructions(response.data.cooking_instructions);
                setImage(response.data.image);
            })
            .catch(error => console.error('Error fetching data: ', error));
    }
        , []);

    if (recipe == null)
        return false;

    return (
        <Container maxWidth="md">
            <Card>
                {/* <img src={imageUrl} alt="Recipe Image" style={{ width: '100%', height: 'auto' }} /> */}
                <CardContent>
                    <Typography variant="h5" component="div" gutterBottom>
                        {recipe.dish_name}
                    </Typography>
                    <Typography variant="subtitle1" gutterBottom>
                        {recipe.description}
                    </Typography>
                </CardContent>
                <CardContent>
                    <ListItem>
                        <ListItemText primary={`Image URL: ${image!==null? image:''}`} />
                        <IconButton onClick={() => {
                            const newImage = prompt('Enter the new image link:');
                            if (newImage) {
                                setImage(newImage);
                            }
                        }}>
                            <EditIcon />
                        </IconButton>
                    </ListItem>
                </CardContent>
                <UpdateIngredientsRecipe recipe={recipe.recipe_id} data={recipe.ingredients}/>
                <UpdateFlavourRecipe recipe={recipe.recipe_id} data={recipe.flavours}/>
                <UpdateInstruction recipe={recipe.recipe_id} data={instructions}/>
            </Card>
        </Container>
    );
};

export default EditRecipe;

