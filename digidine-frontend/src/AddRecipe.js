import React, { useState, useEffect } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText, TextField, IconButton, Button } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import EditIcon from '@mui/icons-material/Edit';
import UpdateIngredientsRecipe from './UpdateIngredientsRecipe';
import UpdateFlavourRecipe from './UpdateFlavourRecipe';
import axios from 'axios';

const AddRecipe = (props) => {
    // Dummy image URL
    const imageUrl = 'https://dummyimage.com/200x100/000/fff';

    // State variable to store the instructions
    const [instructions, setInstructions] = useState([]);
    const [image, setImage] = useState('');
    const [recipe, setRecipe] = useState(null);
    const [data, setData] = useState(null);

    // Function to remove an instruction from the instructions array
    const removeInstruction = () => {
        const updatedInstructions = [...instructions];
        updatedInstructions.splice(-1, 1);
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

    const handleConfirmTitle = () => {
        if (title !== "") {
            axios.post(`http://localhost:5000/chef/add-recipe`, {chef_name: props.chefName, dish_name: title})
                .then((response) => {
                    setConfirmedTitle(title);
                    setDisableTitle(true);
                    setRecipe(response.data.recipe_id);
                    console.log("Added recipe succefully")
                }
                )
                .catch((error) => {
                    console.log(error);
                }
                )
                .finally(() => {
                    // Close the dialog box
                    // setConfirmDelete(false);
                }
                )}
        else {
            alert("Please enter a title");
        }
    }
    useEffect(() => {
        if(recipe!==null){
        axios.get(`http://localhost:5000/recipes/information/${recipe}`)
            .then(response => {
                setData(response.data);
            })
            .catch(error => console.error('Error fetching data: ', error));
    }
}
        , [recipe]);
    const [title, setTitle] = useState('');
    const [disableTitle, setDisableTitle] = useState(false);
    const [confirmedTitle, setConfirmedTitle] = useState('');

    return (
        <Container maxWidth="md">
            <Card align="center">
                <CardContent>
                    <Typography variant="h6" component="div" gutterBottom>
                        Recipe Title
                    </Typography>
                    <TextField disabled={disableTitle} style={{ marginRight: '5%' }} value={title} onChange={(e) => setTitle(e.target.value)} />
                    {!disableTitle ? <Button variant="contained" onClick={handleConfirmTitle}>
                        Confirm Title
                    </Button>
                        : <Button variant="outlined" onClick={() => setDisableTitle(false)}>
                            Edit Title
                        </Button>}
                </CardContent>
            </Card>
            {confirmedTitle !== "" && data!==null && <><Card>
                <CardContent>
                    <ListItem>
                        <ListItemText primary={`Image URL: ${image}`} />
                        <IconButton onClick={() => {
                            const newInstruction = prompt('Enter the new instruction:');
                            if (newInstruction) {
                                setImage(newInstruction);
                            }
                        }}>
                            <EditIcon />
                        </IconButton>
                    </ListItem>
                </CardContent>
                <UpdateIngredientsRecipe recipe={recipe} data={data.ingredients} />
                <UpdateFlavourRecipe recipe={recipe} data={data.ingredients} />
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
            </>}

        </Container>
    );
};

export default AddRecipe;

