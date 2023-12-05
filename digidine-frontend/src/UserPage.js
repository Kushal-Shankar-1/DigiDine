import React, { useEffect, useState } from 'react';
import Recipes from './Recipes';
import Button from '@mui/material/Button';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import Stack from '@mui/material/Stack';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import Radio from '@mui/material/Radio';
import UpdatePreferences from './UpdatePreferences';
import UpdateInventory from './UpdateInventory';


export default function UserPage() {

    const [selectedOption, setSelectedOption] = useState('explore');
    const [exploreType, setExploreType] = useState('all');

    const handleOption = (event) => {
        setExploreType(event.target.value);
    }

    return (
        <>
            <Box
                sx={{
                    bgcolor: 'background.paper',
                    pt: 8,
                    pb: 6,
                }}
            >
                <Container maxWidth="md">
                    <Typography
                        component="h1"
                        variant="h2"
                        align="center"
                        color="text.primary"
                        gutterBottom
                        style={{ marginTop: '10%' }}
                    >
                        Hungry? Of course, you are!
                    </Typography>
                    <Typography variant="h5" align="center" color="text.secondary" paragraph>
                        Let's explore some food options! Check out what the chefs in your area are cooking up! Select
                        the ingredients you have stocked up in your fridge to see what all you can make right now!
                    </Typography>
                    <Stack
                        sx={{ pt: 4 }}
                        direction="row"
                        spacing={2}
                        justifyContent="center"
                    >
                        <Button variant={selectedOption === "explore" ? "contained" : "outlined"} onClick={() => setSelectedOption("explore")}>Explore Dishes</Button>
                        <Button variant={selectedOption === "updateInventory" ? "contained" : "outlined"} onClick={() => setSelectedOption("updateInventory")}>Update Inventory</Button>
                        <Button variant={selectedOption === "updatePreferences" ? "contained" : "outlined"} onClick={() => setSelectedOption("updatePreferences")}>Update Preferences</Button>
                    </Stack>

                    {selectedOption === "explore" &&
                        <Stack
                            sx={{ pt: 4 }}
                            direction="row"
                            spacing={2}
                            justifyContent="center"
                        >
                            <FormControl>
                                <FormLabel>Filter Recipes</FormLabel>
                                <RadioGroup
                                    row
                                    aria-labelledby="row-radio-buttons-group-label"
                                    name="row-radio-buttons-group"
                                >
                                    <FormControlLabel value="all" control={<Radio />} label="All" checked={exploreType === "all"} onClick={handleOption} />
                                    <FormControlLabel value="inventory" control={<Radio />} label="For Current Inventory" checked={exploreType === "inventory"} onClick={handleOption} />
                                    <FormControlLabel value="preferences" control={<Radio />} label="For Preferences" checked={exploreType === "preferences"} onClick={handleOption} />
                                    <FormControlLabel value="custom" control={<Radio />} label="For Preferences & Inventory" checked={exploreType === "custom"} onClick={handleOption} />
                                </RadioGroup>
                            </FormControl>
                        </Stack>
                    }
                </Container>
            </Box>
            {selectedOption === "explore" && <Recipes />}
            {selectedOption === "updateInventory" && <UpdateInventory />}
            {selectedOption === "updatePreferences" && <UpdatePreferences />}
        </>
    )
}