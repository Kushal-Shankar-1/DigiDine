import React, { useEffect, useState } from 'react';
import { Card, CardContent, Typography, Checkbox, Container, Grid } from '@mui/material';
import axios from 'axios';

const UpdateFlavourRecipe = (props) => {
    const [flavorPreferences, setFlavorPreferences] = useState([]);
    const [selectedFlavour, setSelectedFlavorPreferences] = useState([]);
    const handleFlavorPreferencesChange = (preference) => {
        if (selectedFlavour.includes(preference)) {
            axios.post(`http://localhost:5000/recipe/remove-flavour`, {flavour:preference, recipe_id: props.recipe})
                .then((response) => {
                    setSelectedFlavorPreferences(selectedFlavour.filter((r) => r !== preference));
                })
            
        } else {
            axios.post(`http://localhost:5000/recipe/add-flavour`, {flavour:preference, recipe_id: props.recipe})
            .then((response) => {
                console.log(response);
                setSelectedFlavorPreferences([...selectedFlavour, preference]);
            })
        }
    };

    useEffect(() => {
        setFlavorPreferences(props.data);
        setSelectedFlavorPreferences(props.data.filter((preference) => preference.is_present === true).map((preference) => preference.flavour_name));
    }, [props.data]);

    return (
        <Container style={{marginTop:'5%'}} maxWidth="md">
            <Grid container spacing={3} justifyContent="center">
                {/* <Grid item xs={3}>
                </Grid> */}

                <Grid item xs={6}>
                    <Typography style={{background:'lightblue'}} variant="h5">Flavor</Typography>
                    <div>
                        {flavorPreferences.map((preference, index) => (
                            <Card 
                                style={{ backgroundColor: selectedFlavour.includes(preference.flavour_name) ? 'PapayaWhip' : 'LavenderBlush' }}
                                onClick={() => handleFlavorPreferencesChange(preference.flavour_name)}
                            >
                                <CardContent>
                                    <Typography>{preference.flavour_name}</Typography>
                                    <Checkbox
                                        checked={selectedFlavour.includes(preference.flavour_name)}
                                        // onChange={() => handleFlavorPreferencesChange(preference.flavour_name)}
                                    />
                                </CardContent>
                            </Card>
                        ))}
                    </div>
                </Grid>

                {/* Add more steps/questions here */}
            </Grid>
        </Container>
    );
};

export default UpdateFlavourRecipe;