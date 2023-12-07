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
    useEffect(() => {
        axios.get(`http://localhost:5000/recipes/information/${props.selectedRecipe}`)
            .then(response => {
                setRecipe(response.data);
                setInstructions(response.data.cooking_instructions);
            })
            .catch(error => console.error('Error fetching data: ', error));
    }
        , []);
    // Function to remove an instruction from the instructions array
    const removeInstruction = () => {
        axios.post(`http://localhost:5000/recipe/remove-instruction`, { recipe_id: recipe.recipe_id })
            .then((response) => {
                console.log(response);
                const updatedInstructions = [...instructions];
                updatedInstructions.splice(-1, 1);
                setInstructions(updatedInstructions);
            })
            .catch((error) => {
                console.log(error);
            })
    };

    // Function to edit an instruction in the instructions array
    const editInstruction = (index, newInstruction) => {
        axios.post(`http://localhost:5000/recipe/edit-instruction`, { step_number: index, instruction: newInstruction, recipe_id: recipe.recipe_id })
            .then((response) => {
                const updatedInstructions = [...instructions];
                updatedInstructions[index].step_description = newInstruction;
                setInstructions(updatedInstructions);
                console.log("NEW INSTRUCTION", newInstruction);
            })
            .catch((error) => {
                console.log(error);
            });
    };

    const addInstruction = (newInstruction) => {
        axios.post(`http://localhost:5000/recipe/add-instruction`, { instruction: newInstruction, recipe_id: recipe.recipe_id })
            .then((response) => {
                console.log(response);

                setInstructions([...instructions, {step_description:newInstruction}]);
            })
            .catch((error) => {
                console.log(error);
            })
    }

    if (recipe == null)
        return false;

    return (
        <Container maxWidth="md">
            <Card>
                <img src={imageUrl} alt="Recipe Image" style={{ width: '100%', height: 'auto' }} />
                <UpdateIngredientsRecipe recipe={recipe.recipe_id} data={recipe.ingredients}/>
                <UpdateFlavourRecipe recipe={recipe.recipe_id} data={recipe.flavours}/>
                {/* <CardContent>
                    <Typography variant="h5" component="div" gutterBottom>
                        Cooking Instructions
                    </Typography>
                    <List>
                        {instructions.map((instruction, index) => (
                            <ListItem key={index}>
                                <ListItemText primary={`Step ${index + 1}: ${instruction.step_description}`} />
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
                </CardContent> */}
                <UpdateInstruction recipe={recipe.recipe_id} data={instructions}/>
            </Card>
        </Container>
    );
};

export default EditRecipe;

