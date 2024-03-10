import React, { useEffect, useState } from 'react';
import Button from '@mui/material/Button';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import ExpandRecipe from './ExpandRecipe';
import EditRecipe from './EditRecipe';
import { Dialog, DialogTitle, DialogContent, DialogActions } from '@mui/material';
import axios from 'axios';

  


export default function Recipes(props) {
  const [expandedView, setExpandedView] = useState(false);
  const [editView, setEditView] = useState(false);
  const [data, setData] = useState([]);
  const [isChef, setIsChef] = useState(props.isChef);
  const [selectedRecipe, setSelectedRecipe] = useState(null);
  
  const handleRemove = (recipe) => {
    // Open the dialog box to confirm deletion
    setSelectedRecipe(recipe);
    setConfirmDelete(true);
  }
  useEffect(() => {
    setIsChef(props.isChef);
    props.data!==undefined && setData(props.data);
    console.log("PROPS DATA IN RECIPES",props.data);
  }, [props.data, props.isChef]);

  const handleConfirmDelete = () => {
    // Perform the deletion logic here
    axios.post(`http://localhost:5000/chef/remove-recipe` , {recipe_id: selectedRecipe})
    .then((response) => {
      setSelectedRecipe(null);  
      console.log(response);
        window.location.reload();
    })
    .catch((error) => {
        console.log(error);
    })
    .finally(() => {
      // Close the dialog box
      setConfirmDelete(false);
    })
    
    console.log('Recipe deleted', selectedRecipe);
    

  }

  const handleCancelDelete = () => {
    // Close the dialog box
    setConfirmDelete(false);
  }

  const [confirmDelete, setConfirmDelete] = useState(false);

  const handleBack = () => {
    setExpandedView(false);
    setEditView(false);
    props.disableButtons(false);
  }

  const handleExpand = (id) => {
    setSelectedRecipe(id);
    setExpandedView(true);
    props.disableButtons(true);
  }

  const handleEdit = (id) => {
    setSelectedRecipe(id);
    setEditView(true);
    props.disableButtons(true);
  }  

  return (

    
      <Container sx={{ py: 8 }} maxWidth="md">
        {expandedView ?
          <>
            <ExpandRecipe selectedRecipe={selectedRecipe}/>
            <center><Button  style={{marginTop:'5%'}} variant="contained" onClick={handleBack}>Back</Button></center>
          </>
          : editView? 
           <><EditRecipe selectedRecipe={selectedRecipe}/> 
           <center><Button  style={{marginTop:'5%'}} variant="contained" onClick={handleBack}>Back</Button></center>
           </>: 
          <Grid container spacing={4}>
            {data.map((card) => (
              <Grid item key={card} xs={12} sm={6} md={4}>
                <Card
                  sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}
                >
                  <CardMedia
                    component="div"
                    sx={{
                      // 16:9
                      pt: '56.25%',
                    }}
                    image={card.image==null || card.image === ""? "https://source.unsplash.com/random?wallpapers": card.image}
                  />
                  <CardContent sx={{ flexGrow: 1 }}>
                    <Typography gutterBottom variant="h5" component="h2">
                      {card.dish_name}
                    </Typography>
                    <Typography>
                      {card.description}
                    </Typography>
                    <Typography>
                      <i>Curated By :</i> {card.chef}
                    </Typography>
                  </CardContent>
                  <CardActions>
                    <Button size="small" onClick={()=>handleExpand(card.recipe_id)}>View</Button>
                    {isChef === true && card.chef === props.chefName && <Button size="small" onClick={()=>handleEdit(card.recipe_id)}>Edit</Button>}
                    {isChef === true && card.chef === props.chefName && <Button size="small" onClick={()=>handleRemove(card.recipe_id)}>Remove</Button>}
                  </CardActions>
                </Card>
              </Grid>
            ))}
          </Grid>}
          {confirmDelete && (
        <Dialog open={confirmDelete} onClose={handleCancelDelete}>
          <DialogTitle>Confirm Deletion</DialogTitle>
          <DialogContent>
            Are you sure you want to delete this recipe?
          </DialogContent>
          <DialogActions>
            <Button onClick={handleCancelDelete}>Cancel</Button>
            <Button onClick={handleConfirmDelete}>Delete</Button>
          </DialogActions>
        </Dialog>
      )}
      </Container>
    
  )
} 