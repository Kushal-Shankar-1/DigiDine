import React, { useEffect, useState } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText, TextField, IconButton, Button } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import EditIcon from '@mui/icons-material/Edit';
import UpdateFlavourRecipe from './UpdateFlavourRecipe';
import UpdateIngredientsRecipe from './UpdateIngredientsRecipe';
import axios from 'axios';

const EditRecipe = (props) => {
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
                console.log("IN EDIT FETCH DONE",response.data);
            })
            .catch(error => console.error('Error fetching data: ', error));
    }
        , []);
    // Function to remove an instruction from the instructions array
    const removeInstruction = (index) => {
        const updatedInstructions = [...instructions];
        updatedInstructions.splice(index, 1);
        setInstructions(updatedInstructions);
    };

    // Function to edit an instruction in the instructions array
    const editInstruction = (index, newInstruction) => {
        const updatedInstructions = [...instructions];
        updatedInstructions[index] = newInstruction;
        setInstructions(updatedInstructions);
    };

    const addInstruction = (newInstruction) => {
        setInstructions([...instructions, newInstruction]);
    }

    if (recipe == null)
        return false;

    return (
        <Container maxWidth="md">
            <Card>
                <img src={imageUrl} alt="Recipe Image" style={{ width: '100%', height: 'auto' }} />
                <UpdateIngredientsRecipe recipe={recipe.recipe_id} data={recipe.ingredients}/>
                <UpdateFlavourRecipe recipe={recipe.recipe_id} data={recipe.flavours}/>
                <CardContent>
                    <Typography variant="h5" component="div" gutterBottom>
                        Cooking Instructions
                    </Typography>
                    <List>
                        {instructions.map((instruction, index) => (
                            <ListItem key={index}>
                                <ListItemText primary={`Step ${index + 1}: ${instruction}`} />
                                <IconButton onClick={() => removeInstruction(index)}>
                                    <CloseIcon />
                                </IconButton>
                                <IconButton onClick={() => {
                                    const newInstruction = prompt('Enter the new instruction:');
                                    if (newInstruction) {
                                        editInstruction(index, newInstruction);
                                    }
                                }}>
                                    <EditIcon />
                                </IconButton>
                            </ListItem>
                        ))}
                    </List>
                    <center><Button variant="contained" onClick={() => {
                        const newInstruction = prompt('Enter the new instruction:');
                        if (newInstruction) {
                            addInstruction(newInstruction);
                        }
                    }
                    }>
                        Add New Instruction
                    </Button></center>
                </CardContent>
            </Card>
        </Container>
    );
};

export default EditRecipe;

