import React, { useState } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText, TextField, IconButton, Button } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import EditIcon from '@mui/icons-material/Edit';
import UpdateIngredientsRecipe from './UpdateIngredientsRecipe';
import UpdateFlavourRecipe from './UpdateFlavourRecipe';

const AddRecipe = () => {
    // Dummy image URL
    const imageUrl = 'https://dummyimage.com/200x100/000/fff';

    // State variable to store the instructions
    const [instructions, setInstructions] = useState([]);
    const [image, setImage] = useState('');

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

    const handleConfirmTitle = () => {
        if(title !== "") {
        setConfirmedTitle(title);
        setDisableTitle(true);
        }
        else{
            alert("Please enter a title");
        }
    }

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
                    <TextField disabled={disableTitle} style={{marginRight:'5%'}} value={title} onChange={(e) => setTitle(e.target.value)} />
                    {!disableTitle? <Button variant="contained" onClick={handleConfirmTitle}>
                        Confirm Title
                    </Button>
                    : <Button variant="outlined" onClick={() => setDisableTitle(false)}>
                        Edit Title
                    </Button>}
                </CardContent>
            </Card>
            {confirmedTitle !== "" && <><Card>
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
                <UpdateIngredientsRecipe />
                <UpdateFlavourRecipe />
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

