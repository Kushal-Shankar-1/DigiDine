import React, { useEffect, useState} from 'react';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { FormControlLabel, Radio, FormLabel, FormControl, RadioGroup } from '@mui/material';
import Recipes from './Recipes';
import AddRecipe from './AddRecipe';
import axios from 'axios';


const cards = [1, 2, 3, 4, 5, 6, 7, 8, 9];


export default function ChefPage() {
  const [selectedOption, setSelectedOption] = useState('explore');
    const [exploreType, setExploreType] = useState('all');
    const [disableButtons, setDisableButtons] = useState(false);
    const [data, setData] = useState([]);
    const [allData, setAllData] = useState([]);
    const [chefData, setChefData] = useState([]);
    const [user, setUser] = useState(JSON.parse(sessionStorage.getItem('user')));

    const handleOption = (event) => {
      setExploreType(event.target.value);
      if(event.target.value === "all"){
        setData(allData);
      }else{
        setData(chefData);
      }
  }
  useEffect(() => {
    if(selectedOption === "explore"){
        setExploreType("all");

    axios.get('http://localhost:5000/recipes/all')
        .then((response) => {
            setAllData(response.data);
            setData(response.data);
            // sessionStorage.setItem('user', JSON.stringify(response.data));
            // sessionStorage.setItem('loggedIn', true);
        })
        .catch((error) => {
            console.log(error);
            // alert('Invalid Credentials');
        });

        axios.get(`http://localhost:5000/recipes/chef/${user.user_name}`)
        .then((response) => {
            setChefData(response.data);
        })
        .catch((error) => {
            console.log(error);
        });

        
    }
},[selectedOption])

  return (
    
      <main>
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
              style={{marginTop: '10%'}}
            >
              Let's feed some hungry tummies now, Shall we?
            </Typography>
            <Typography variant="h5" align="center" color="text.secondary" paragraph>
              View or edit all your current recipes that you have posted. Feeling crafty? Let's add a new dish for all of them to marvel at!
            </Typography>
            <Stack
              sx={{ pt: 4 }}
              direction="row"
              spacing={2}
              justifyContent="center"
            >
              <Button disabled={disableButtons} variant={selectedOption === "explore" ? "contained" : "outlined"} onClick={() => setSelectedOption("explore")}>Explore Dishes</Button>
                        <Button disabled={disableButtons} variant={selectedOption === "addNewRecipe" ? "contained" : "outlined"} onClick={() => setSelectedOption("addNewRecipe")}>Add New Recipe</Button>
            </Stack>
            {selectedOption === "explore" &&
                        <Stack
                            sx={{ pt: 4 }}
                            direction="row"
                            spacing={2}
                            justifyContent="center"
                        >
                            <FormControl disabled={disableButtons}>
                                <FormLabel>Filter Recipes</FormLabel>
                                <RadioGroup
                                    row
                                    aria-labelledby="row-radio-buttons-group-label"
                                    name="row-radio-buttons-group"
                                >
                                    <FormControlLabel value="all" control={<Radio />} label="All" checked={exploreType === "all"} onClick={handleOption} />
                                    <FormControlLabel value="yours" control={<Radio />} label="Yours" checked={exploreType === "yours"} onClick={handleOption} />
                                </RadioGroup>
                            </FormControl>
                        </Stack>
                    }
          </Container>
        </Box>
        {selectedOption=="explore" && <Recipes isChef={true} chefName={user.user_name} data={data} disableButtons={setDisableButtons} />}
        {selectedOption=="addNewRecipe" && <AddRecipe />}
      </main>
  )
} 