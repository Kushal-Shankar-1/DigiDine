# DigiDine: AI Personal Chef and Nutritionist

DigiDine is an AI-driven culinary platform designed to revolutionize your meal planning experience. It offers
personalized recipe suggestions based on your dietary preferences and available ingredients.

## Run using Docker

If you have docker installed in your system, run the command  `docker compose up --build` and the application should boot up after performing the necessary installations.


## Setting Up the Project

### Requirements

- Python 3.8 or higher
- Flask 3.0.0
- MySQL 8.0
- ReactJS 17.0.2

### Installation Steps

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Kushal-Shankar-1/DigiDine.git
   ```
2. **Install Python dependencies**:
   Execute `pip install -r requirements.txt` in the project directory.
3. **Set up the MySQL database**:
   Import the `digidine.sql` file using MySQL Workbench to create and populate the database.

- **Note**: The current setup expects the database's username and password to be 'root' and 'root' respectively. Modify
  the `config.py` file in the backend directory if your database credentials are different.

4. **Run the Flask server**:
   Navigate to the backend directory and execute `python app.py`.
5. **Install and run the ReactJS frontend**:
   In the frontend directory, execute `npm install` followed by `npm start`.

After setting up the project, navigate to `http://localhost:3000` in your web browser to start exploring DigiDine's
features!
