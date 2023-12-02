import React, { useState } from 'react';
import { Card, CardContent, Typography, TextField, Button, Checkbox } from '@mui/material';
import { useNavigate } from 'react-router-dom';

const SignUp = () => {
    const [step, setStep] = useState(1);
    const [name, setName] = useState('');
    const [contact, setContact] = useState('');
    const [dietaryRestrictions, setDietaryRestrictions] = useState([]);
    const [flavorPreferences, setFlavorPreferences] = useState([]);
    const navigate = useNavigate();

    const handleNameChange = (event) => {
        setName(event.target.value);
    };

    const handleContactChange = (event) => {
        setContact(event.target.value);
    };

    const handleNext = () => {
        setStep(step + 1);
    };

    const handleBack = () => {
        setStep(step - 1);
    };

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

    const handleSubmit = () => {
        navigate('/');
    }

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <Card style={{ width: '400px', padding: '20px' }}>
                {step === 1 && (
                    <div>
                        <Typography variant="h4">Sign Up</Typography>
                        <form>
                            <TextField
                                label="Name"
                                value={name}
                                onChange={handleNameChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <TextField
                                label="Contact"
                                value={contact}
                                onChange={handleContactChange}
                                style={{ marginBottom: '10px' }}
                            />
                            <Button variant="contained" color="primary" onClick={handleNext}>
                                Next
                            </Button>
                        </form>
                    </div>
                )}

                {step === 2 && (
                    <div>
                        <Typography variant="h5">Dietary Restrictions</Typography>
                        <div>
                            <Card
                                style={{
                                    backgroundColor: dietaryRestrictions.includes('Gluten-free') ? '#FFDAB9' : 'white',
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
                                    backgroundColor: dietaryRestrictions.includes('Vegetarian') ? '#FFDAB9' : 'white',
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
                                    backgroundColor: dietaryRestrictions.includes('Vegan') ? '#FFDAB9' : 'white',
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
                                    backgroundColor: dietaryRestrictions.includes('Lactose Intolerant') ? '#FFDAB9' : 'white',
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
                        <Button variant="contained" color="primary" onClick={handleNext}>
                            Next
                        </Button>
                        <Button variant="contained" color="secondary" onClick={handleBack}>
                            Back
                        </Button>
                    </div>
                )}

                {step === 3 && (
                    <div>
                        <Typography variant="h5">Flavor Preferences</Typography>
                        <div>
                            <Card
                                style={{ backgroundColor: flavorPreferences === 'Mild' ? '#FFDAB9' : 'white' }}
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
                                style={{ backgroundColor: flavorPreferences === 'Spicy' ? '#FFDAB9' : 'white' }}
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
                                style={{ backgroundColor: flavorPreferences === 'Medium' ? '#FFDAB9' : 'white' }}
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
                        <Button variant="contained" color="primary" onClick={handleSubmit}>
                            Submit
                        </Button>
                        <Button variant="contained" color="secondary" onClick={handleBack}>
                            Back
                        </Button>
                    </div>
                )}

                {/* Add more steps/questions here */}
            </Card>
        </div>
    );
};

export default SignUp;