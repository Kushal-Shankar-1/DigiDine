import React from 'react';
import { Card, CardContent, Typography } from '@mui/material';
import { useNavigate } from 'react-router-dom';

const SignUpOption = () => {
    const navigate = useNavigate();

    const handleUser = (event) => {
        navigate('/signup');
    };

    const handleChef = (event) => {
        navigate('/signupchef');
    };

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <Card style={{ width: '400px', padding: '20px' }}>

                    <div>
                        {/* <Typography variant="h4">Sign Up</Typography> */}
                        <Card
                                style={{ backgroundColor: 'pink', cursor: 'pointer', marginBottom: '10px' }}
                                onClick={() => handleUser()}
                            >
                                <CardContent>
                                    <Typography>SIGN UP AS A USER</Typography>
                                </CardContent>
                            </Card>
                            <Card
                                style={{ backgroundColor: 'lightBlue', cursor: 'pointer' }}
                                onClick={() => handleChef()}
                            >
                                <CardContent>
                                    <Typography>SIGN UP AS A CHEF</Typography>
                                </CardContent>
                            </Card>
                    </div>

            </Card>
        </div>
    );
};

export default SignUpOption;