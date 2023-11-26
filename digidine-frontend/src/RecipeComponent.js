import React, { useState, useEffect } from 'react';
import axios from 'axios';

function RecipeComponent() {
    const [recipes, setRecipes] = useState([]);
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');

    // Fetch recipes from the backend
    useEffect(() => {
        axios.get('http://localhost:5000/recipes')
             .then(response => {
                 setRecipes(response.data);
             })
             .catch(error => console.error('Error fetching data: ', error));
    }, []);

    // Handlers for adding, updating, and deleting recipes
    const addRecipe = () => {
        axios.post('http://localhost:5000/add_recipe', { title, description })
             .then(() => {
                 // Refresh the list or handle success
             })
             .catch(error => console.error('Error adding recipe: ', error));
    };

    // Include handlers for updating and deleting recipes

    return (
        <div>
            <h2>Recipes</h2>
            <div>
                {recipes.map(recipe => (
                    <div key={recipe.id}>
                        <h3>{recipe.title}</h3>
                        <p>{recipe.description}</p>
                        {/* Buttons for update and delete */}
                    </div>
                ))}
            </div>
            <div>
                <input type="text" value={title} onChange={e => setTitle(e.target.value)} />
                <input type="text" value={description} onChange={e => setDescription(e.target.value)} />
                <button onClick={addRecipe}>Add Recipe</button>
            </div>
        </div>
    );
}

export default RecipeComponent;
