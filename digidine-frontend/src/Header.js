import * as React from 'react';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Avatar from '@mui/material/Avatar';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import Divider from '@mui/material/Divider';
import Typography from '@mui/material/Typography';
import UserIcon from '@mui/icons-material/Person';
import Logout from '@mui/icons-material/Logout';
import DownloadIcon from '@mui/icons-material/Download';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';


export default function Header(props) {
  const navigate = useNavigate();
  const [anchorEl, setAnchorEl] = React.useState(null);
  const [user, setUser] = React.useState(JSON.parse(sessionStorage.getItem('user')));
  const open = Boolean(anchorEl);
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const [loggedIn, setLoggedIn] = React.useState(props.loggedIn);
  React.useEffect(() => {
    setLoggedIn(props.loggedIn);
    console.log("PROPS UPDATED IN HEADER", props);
  }, []);
  const handleClose = () => {
    setAnchorEl(null);
  };

  const handleProfile = () => {
    navigate('/profile');
    handleClose();
  }

  const handleLogOut = () => {
    console.log("logging out", props)
    sessionStorage.setItem('loggedIn', false);
    props.setLoggedIn(false);
    navigate('/');
    window.location.reload();
    handleClose();
  };

  const handleDownload = () => {
    axios.get('http://localhost:5000/visualize')
    .then((response) => {
      console.log("Downloaded successfully", response);
    })
    .catch((error) => {
      console.log("Error downloading", error);
    })
  }

React.useEffect (() => {
  if(props.loggedIn !== loggedIn){
    setLoggedIn(props.loggedIn);
    window.location.reload();
  }
}, [props.loggedIn]);
  return (
    <AppBar position="absolute">
      <Toolbar >
        <Typography style={{ justifySelf: 'start', marginRight: '10%', cursor: 'pointer' }} variant="h6" color="inherit" noWrap onClick={() => navigate('/')}>
          DigiDine: AI PERSONAL CHEF AND NUTRITIONIST
        </Typography>
        <DownloadIcon style={{cursor: 'pointer'}} sx={{ mr: 2 }} onClick={handleDownload} />
        <Typography onClick={handleDownload}  style={{ justifySelf: 'center', marginRight: '10%', cursor: 'pointer' }} variant="h6">Data Visualization</Typography>
        {props.loggedIn == true && <>
        <UserIcon sx={{ mr: 2 }} />
        <Typography variant="h6" color="inherit" style={{cursor: 'default'}} noWrap>
        {user.user_name}
        </Typography>
        <IconButton
          onClick={handleClick}
          size="small"
          sx={{ ml: 2 }}
          aria-controls={open ? 'account-menu' : undefined}
          aria-haspopup="true"
          aria-expanded={open ? 'true' : undefined}
        >
          <Avatar sx={{ width: 32, height: 32 }}>{user.user_name[0]}</Avatar>
        </IconButton></>}
      </Toolbar>
      <Menu
        anchorEl={anchorEl}
        id="account-menu"
        open={open}
        onClose={handleClose}
        onClick={handleClose}
        PaperProps={{
          elevation: 0,
          sx: {
            overflow: 'visible',
            filter: 'drop-shadow(0px 2px 8px rgba(0,0,0,0.32))',
            mt: 1.5,
            '& .MuiAvatar-root': {
              width: 32,
              height: 32,
              ml: -0.5,
              mr: 1,
            },
            '&:before': {
              content: '""',
              display: 'block',
              position: 'absolute',
              top: 0,
              right: 14,
              width: 10,
              height: 10,
              bgcolor: 'background.paper',
              transform: 'translateY(-50%) rotate(45deg)',
              zIndex: 0,
            },
          },
        }}
        transformOrigin={{ horizontal: 'right', vertical: 'top' }}
        anchorOrigin={{ horizontal: 'right', vertical: 'bottom' }}
      >
        <MenuItem onClick={handleProfile}>
          <Avatar /> Profile
        </MenuItem>
        <Divider />
        <MenuItem onClick={handleLogOut}>
          <ListItemIcon>
            <Logout fontSize="small" />
          </ListItemIcon>
          Logout
        </MenuItem>
      </Menu>
    </AppBar>
  );
}