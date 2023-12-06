from flask import Flask, jsonify
from routes import initialize_routes
from flask_cors import CORS

# other imports
app = Flask(__name__)
app.secret_key = 'digidine'  # Set a strong secret key
CORS(app)


# Error handling for common HTTP errors
@app.errorhandler(404)
def not_found_error(error):
    return jsonify({"error": "Resource not found"}), 404


@app.errorhandler(400)
def bad_request_error(error):
    return jsonify({"error": "Bad request"}), 400


@app.errorhandler(500)
def internal_error(error):
    return jsonify({"error": "Internal server error"}), 500


# Initialize routes from the routes module
initialize_routes(app)

if __name__ == '__main__':
    app.run(debug=True)
