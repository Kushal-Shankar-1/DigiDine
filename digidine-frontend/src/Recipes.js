import React, { useState } from 'react';
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


const cards = [1, 2, 3, 4, 5, 6, 7, 8, 9];


export default function Recipes(props) {
  const [expandedView, setExpandedView] = useState(false);
  const [editView, setEditView] = useState(false);
  const [data, setData] = useState([]);
  const [isChef, setIsChef] = useState(props.isChef);
  const user = JSON.parse(sessionStorage.getItem('user'));

  const handleBack = () => {
    setExpandedView(false);
    setEditView(false);
    props.disableButtons(false);
  }

  const handleExpand = () => {
    setExpandedView(true);
    props.disableButtons(true);
  }

  const handleEdit = () => {
    setEditView(true);
    props.disableButtons(true);
  }

  return (

    
      <Container sx={{ py: 8 }} maxWidth="md">
        {expandedView ?
          <>
            <ExpandRecipe />
            <center><Button  style={{marginTop:'5%'}} variant="contained" onClick={handleBack}>Back</Button></center>
          </>
          : editView? 
           <><EditRecipe /> 
           <center><Button  style={{marginTop:'5%'}} variant="contained" onClick={handleBack}>Back</Button></center>
           </>: 
          <Grid container spacing={4}>
            {cards.map((card) => (
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
                    image="https://source.unsplash.com/random?wallpapers"
                  />
                  <CardContent sx={{ flexGrow: 1 }}>
                    <Typography gutterBottom variant="h5" component="h2">
                      Heading
                    </Typography>
                    <Typography>
                      This is a media card. You can use this section to describe the
                      content.
                    </Typography>
                  </CardContent>
                  <CardActions>
                    <Button size="small" onClick={handleExpand}>View</Button>
                    {isChef == true && <Button size="small" onClick={handleEdit}>Edit</Button>}
                  </CardActions>
                </Card>
              </Grid>
            ))}
          </Grid>}
      </Container>
    
  )
} 