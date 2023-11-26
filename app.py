from flask import Flask
from routes import initialize_routes
from flask_cors import CORS

# other imports
app = Flask(__name__)
CORS(app)

# Initialize routes from the routes module
initialize_routes(app)

if __name__ == '__main__':
    app.run(debug=True)
