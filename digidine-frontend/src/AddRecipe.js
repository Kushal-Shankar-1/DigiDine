import React, { useState, useEffect } from 'react';
import { Container, Card, CardContent, Typography, ListItem, ListItemText, TextField, IconButton, Button } from '@mui/material';
import EditIcon from '@mui/icons-material/Edit';
import UpdateIngredientsRecipe from './UpdateIngredientsRecipe';
import UpdateFlavourRecipe from './UpdateFlavourRecipe';
import axios from 'axios';
import UpdateInstruction from './UpdateInstruction';

const AddRecipe = (props) => {
    
    const [image, setImage] = useState('');
    const [recipe, setRecipe] = useState(null);
    const [data, setData] = useState(null);
    const handleBack = () => {
        props.setSelectedOption("explore");;
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
                            const newInstruction = prompt('Enter the image link:');
                            if (newInstruction) {
                                setImage(newInstruction);
                            }
                        }}>
                            <EditIcon />
                        </IconButton>
                    </ListItem>
                </CardContent>
                <UpdateIngredientsRecipe recipe={recipe} data={data.ingredients} />
                <UpdateFlavourRecipe recipe={recipe} data={data.flavours} />
                <UpdateInstruction recipe={recipe} data={data.cooking_instructions} />
            </Card>
            </>}
            <center><Button  style={{marginTop:'5%'}} variant="contained" onClick={handleBack}>Back</Button></center>
        </Container>
    );
};

export default AddRecipe;

