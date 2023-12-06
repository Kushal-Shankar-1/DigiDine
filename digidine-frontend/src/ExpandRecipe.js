import React, { useState } from 'react';
import { Container, Card, CardContent, Typography, List, ListItem, ListItemText } from '@mui/material';

const ExpandRecipe = () => {
    // Dummy image URL
    const imageUrl = 'https://dummyimage.com/200x100/000/fff';

    // State variable to store the instructions
    const [instructions, setInstructions] = useState([
        'Preheat the oven to 350°F',
        'Mix the dry ingredients in a bowl',
        'Add the wet ingredients and stir well',
        'Pour the batter into a greased baking pan',
        'Bake for 30 minutes or until golden brown',
        'Let it cool before serving'
    ]);

    return (
        <Container maxWidth="md">
            <Card>
                <img src={imageUrl} alt="Recipe Image" style={{ width: '100%', height: 'auto' }} />
                <CardContent>
                    <Typography variant="h5" component="div" gutterBottom>
                        Cooking Instructions
                    </Typography>
                    <List>
                        {instructions.map((instruction, index) => (
                            <ListItem key={index}>
                                <ListItemText primary={`Step ${index + 1}: ${instruction}`} />
                            </ListItem>
                        ))}
                    </List>
                </CardContent>
            </Card>
        </Container>
    );
};

export default ExpandRecipe;

