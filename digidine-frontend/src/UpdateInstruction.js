import React, { useState } from 'react';
import { CardContent, Typography, List, ListItem, ListItemText, IconButton, Button } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import EditIcon from '@mui/icons-material/Edit';
import axios from 'axios';

export default function UpdateInstruction(props) {
    const [instructions, setInstructions] = useState(props.data);
    const [recipe] = useState(props.recipe);
     // Function to remove an instruction from the instructions array
     const removeInstruction = () => {
        axios.post(`http://localhost:5000/recipe/remove-instruction`, { recipe_id: recipe })
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
        axios.post(`http://localhost:5000/recipe/edit-instruction`, { step_number: index+1, instruction: newInstruction, recipe_id: recipe })
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
        axios.post(`http://localhost:5000/recipe/add-instruction`, { instruction: newInstruction, recipe_id: recipe })
            .then((response) => {
                console.log(response);

                setInstructions([...instructions, {step_description:newInstruction}]);
            })
            .catch((error) => {
                console.log(error);
            })
    }

    return (
        <CardContent>
            <Typography variant="h5" component="div" gutterBottom>
                Cooking Instructions
            </Typography>
            <List>
                {instructions.map((instruction, index) => (
                    <ListItem key={index}>
                        <ListItemText primary={`Step ${index + 1}: ${instruction.step_description}`} />
                        {index === instructions.length -1 && <IconButton onClick={() => removeInstruction(index)}>
                            <CloseIcon />
                        </IconButton>}
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
        </CardContent>);
}