import React, { useState } from 'react';
import { Card, CardContent, Typography, Checkbox, Container, Grid } from '@mui/material';

const UpdatePreferences = () => {
    const [dietaryRestrictions, setDietaryRestrictions] = useState([]);
    const [flavorPreferences, setFlavorPreferences] = useState([]);


    const handleDietaryRestrictionsChange = (restriction) => {
        if (dietaryRestrictions.includes(restriction)) {
            setDietaryRestrictions(dietaryRestrictions.filter((r) => r !== restriction));
        } else {
            setDietaryRestrictions([...dietaryRestrictions, restriction]);
        }
    };

    const handleFlavorPreferencesChange = (preference) => {
        if (flavorPreferences.includes(preference)) {
            setFlavorPreferences(flavorPreferences.filter((r) => r !== preference));
        } else {
            setFlavorPreferences([...flavorPreferences, preference]);
        }
    };

    return (
        <Container maxWidth="md">
            <Grid container spacing={3} justifyContent="center">
                <Grid item xs={6}>
                    <Typography variant="h5">Dietary Restrictions</Typography>
                    <div>
                        <Card
                            style={{
                                backgroundColor: dietaryRestrictions.includes('Gluten-free') ? 'MistyRose' : 'white',
                            }}
                            onClick={() => handleDietaryRestrictionsChange('Gluten-free')}
                        >
                            <CardContent>
                                <Typography>Gluten-free</Typography>
                                <Checkbox
                                    checked={dietaryRestrictions.includes('Gluten-free')}
                                    onChange={() => handleDietaryRestrictionsChange('Gluten-free')}
                                />
                            </CardContent>
                        </Card>
                        <Card
                            style={{
                                backgroundColor: dietaryRestrictions.includes('Vegetarian') ? 'MistyRose' : 'white',
                            }}
                            onClick={() => handleDietaryRestrictionsChange('Vegetarian')}
                        >
                            <CardContent>
                                <Typography>Vegetarian</Typography>
                                <Checkbox
                                    checked={dietaryRestrictions.includes('Vegetarian')}
                                    onChange={() => handleDietaryRestrictionsChange('Vegetarian')}
                                />
                            </CardContent>
                        </Card>
                        <Card
                            style={{
                                backgroundColor: dietaryRestrictions.includes('Vegan') ? 'MistyRose' : 'white',
                            }}
                            onClick={() => handleDietaryRestrictionsChange('Vegan')}
                        >
                            <CardContent>
                                <Typography>Vegan</Typography>
                                <Checkbox
                                    checked={dietaryRestrictions.includes('Vegan')}
                                    onChange={() => handleDietaryRestrictionsChange('Vegan')}
                                />
                            </CardContent>
                        </Card>
                        <Card
                            style={{
                                backgroundColor: dietaryRestrictions.includes('Lactose Intolerant') ? 'MistyRose' : 'white',
                            }}
                            onClick={() => handleDietaryRestrictionsChange('Lactose Intolerant')}
                        >
                            <CardContent>
                                <Typography>Lactose Intolerant</Typography>
                                <Checkbox
                                    checked={dietaryRestrictions.includes('Lactose Intolerant')}
                                    onChange={() => handleDietaryRestrictionsChange('Lactose Intolerant')}
                                />
                            </CardContent>
                        </Card>
                    </div>
                </Grid>

                <Grid item xs={6}>
                    <Typography variant="h5">Flavor Preferences</Typography>
                    <div>
                        <Card
                            style={{ backgroundColor: flavorPreferences.includes('Mild') ? 'PapayaWhip' : 'white' }}
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
                            style={{ backgroundColor: flavorPreferences.includes('Spicy') ? 'PapayaWhip' : 'white' }}
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
                            style={{ backgroundColor: flavorPreferences.includes('Medium') ? 'PapayaWhip' : 'white' }}
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

export default UpdatePreferences;