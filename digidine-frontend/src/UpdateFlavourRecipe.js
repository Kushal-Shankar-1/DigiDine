import React, { useState } from 'react';
import { Card, CardContent, Typography, Checkbox, Container, Grid } from '@mui/material';

const UpdateFlavourRecipe = () => {
    const [flavorPreferences, setFlavorPreferences] = useState([]);

    const handleFlavorPreferencesChange = (preference) => {
        if (flavorPreferences.includes(preference)) {
            setFlavorPreferences(flavorPreferences.filter((r) => r !== preference));
        } else {
            setFlavorPreferences([...flavorPreferences, preference]);
        }
    };

    return (
        <Container style={{marginTop:'5%'}} maxWidth="md">
            <Grid container spacing={3} justifyContent="center">
                {/* <Grid item xs={3}>
                </Grid> */}

                <Grid item xs={6}>
                    <Typography style={{background:'lightblue'}} variant="h5">Flavor</Typography>
                    <div>
                        <Card 
                            style={{ backgroundColor: flavorPreferences.includes('Mild') ? 'PapayaWhip' : 'LavenderBlush' }}
                            onClick={() => handleFlavorPreferencesChange('Mild')}
                        >
                            <CardContent>
                                <Typography>Mild</Typography>
                                <Checkbox
                                    checked={flavorPreferences.includes('Mild')}
                                    onChange={() => handleFlavorPreferencesChange('Mild')}
                                />
                            </CardContent>
                        </Card>
                        <Card
                            style={{ backgroundColor: flavorPreferences.includes('Spicy') ? 'PapayaWhip' : 'LavenderBlush' }}
                            onClick={() => handleFlavorPreferencesChange('Spicy')}
                        >
                            <CardContent>
                                <Typography>Spicy</Typography>
                                <Checkbox
                                    checked={flavorPreferences.includes('Spicy')}
                                    onChange={() => handleFlavorPreferencesChange('Spicy')}
                                />
                            </CardContent>
                        </Card>
                        <Card
                            style={{ backgroundColor: flavorPreferences.includes('Medium') ? 'PapayaWhip' : 'LavenderBlush' }}
                            onClick={() => handleFlavorPreferencesChange('Medium')}
                        >
                            <CardContent>
                                <Typography>Medium</Typography>
                                <Checkbox
                                    checked={flavorPreferences.includes('Medium')}
                                    onChange={() => handleFlavorPreferencesChange('Medium')}
                                />
                            </CardContent>
                        </Card>
                    </div>
                </Grid>

                {/* Add more steps/questions here */}
            </Grid>
        </Container>
    );
};

export default UpdateFlavourRecipe;