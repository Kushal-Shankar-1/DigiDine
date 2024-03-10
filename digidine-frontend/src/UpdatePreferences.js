import React, { useEffect, useState } from 'react';
import { Card, CardContent, Typography, Checkbox, Container, Grid } from '@mui/material';
import axios from 'axios';

const UpdatePreferences = (props) => {
    const [dietaryRestrictions, setDietaryRestrictions] = useState([]);
    const [selectedDietaryRestrictions, setSelectedDietaryRestrictions] = useState([]);
    const [selectedFlavorPreferences, setSelectedFlavorPreferences] = useState([]);
    const [flavorPreferences, setFlavorPreferences] = useState([]);
    const [user] = useState(props.user);

    useEffect(() => {
        axios.get(`http://localhost:5000/get-dietary-restrictions/${user}`)
            .then((response) => {
                setDietaryRestrictions(response.data);

                setSelectedDietaryRestrictions(response.data.filter((restriction) => restriction.has_restriction === true).map((restriction) => restriction.restrict_name));
                console.log("SELECTED DIETARY RESTRICTIONS", response.data.filter((restriction) => restriction.has_restriction === true).map((restriction) => restriction.restrict_name));

            })
        axios.get(`http://localhost:5000/get-user-flavour/${user}`)
            .then((response) => {
                setFlavorPreferences(response.data);
                setSelectedFlavorPreferences(response.data.filter((preference) => preference.has_flavour_pref === true).map((preference) => preference.flavour_name));
            })
    }, [user]);

    const handleDietaryRestrictionsChange = (restriction) => {
        if (selectedDietaryRestrictions.includes(restriction)) {
            axios.post(`http://localhost:5000/set_dietary_restrictions/${user}`, {
                restrictionName: restriction,
                hasRestriction: false
            })
                .then((response) => {
                    if (response.status === 200)
                        setSelectedDietaryRestrictions(selectedDietaryRestrictions.filter(r => r !== restriction));
                })

        } else {
            axios.post(`http://localhost:5000/set_dietary_restrictions/${user}`, {
                restrictionName: restriction,
                hasRestriction: true
            })
                .then((response) => {
                    if (response.status === 200)
                        setSelectedDietaryRestrictions([...selectedDietaryRestrictions, restriction]);
                })
        }
    };

    const handleFlavorPreferencesChange = (preference) => {
        if (selectedFlavorPreferences.includes(preference)) {
            axios.post(`http://localhost:5000/set-user-flavour/${user}`, {
                flavourName: preference,
                isPreferred: false
            })
                .then((response) => {
                    if (response.status === 200)
                        setSelectedFlavorPreferences(selectedFlavorPreferences.filter(p => p !== preference));
        })}
         else {
            axios.post(`http://localhost:5000/set-user-flavour/${user}`, {
                flavourName: preference,
                isPreferred: true
            })
                .then((response) => {
                    console.log(response.data);
                    if (response.status === 200)
                        setSelectedFlavorPreferences([...selectedFlavorPreferences, preference]);
        })
    }
    };

    return (
        <Container maxWidth="md">
            {console.log("USER IN UPDATE PREFERENCES", dietaryRestrictions, selectedDietaryRestrictions, flavorPreferences, selectedFlavorPreferences)}
            <Grid container spacing={3} justifyContent="center">
                <Grid item xs={6}>
                    <Typography variant="h5">Dietary Restrictions</Typography>
                    <div>
                        {dietaryRestrictions.map((restriction, index) => (

                            <Card key={index}
                                style={{
                                    backgroundColor: selectedDietaryRestrictions.includes(restriction.restrict_name) ? 'MistyRose' : 'white',
                                }}
                            // onClick={() => handleDietaryRestrictionsChange(restriction.restrictionName)}
                            >
                                <CardContent>
                                    <Typography>{restriction.restrict_name}</Typography>
                                    <Checkbox
                                        checked={selectedDietaryRestrictions.includes(restriction.restrict_name)}
                                        onChange={() => handleDietaryRestrictionsChange(restriction.restrict_name)}
                                    />
                                </CardContent>
                            </Card>
                        ))}

                    </div>
                </Grid>

                <Grid item xs={6}>
                    <Typography variant="h5">Flavor Preferences</Typography>
                    <div>
                        {flavorPreferences.map((preference, index) => (
                            <Card
                            style={{ backgroundColor: selectedFlavorPreferences.includes(preference.flavour_name) ? 'PapayaWhip' : 'white' }}
                        >
                            <CardContent>
                                <Typography>{preference.flavour_name}</Typography>
                                <Checkbox
                                    checked={selectedFlavorPreferences.includes(preference.flavour_name)}
                                    onChange={() => handleFlavorPreferencesChange(preference.flavour_name)}
                                />
                            </CardContent>
                        </Card>
                        ))
                            }
                        
                    </div>
                </Grid>

                {/* Add more steps/questions here */}
            </Grid>
        </Container>
    );
};

export default UpdatePreferences;