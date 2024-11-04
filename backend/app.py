from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from models.part import Part
from models.brand import Brand
from models.user import User
import os

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://autoparts_user:admin123@localhost/autoparts_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = os.environ.get('JWT_SECRET_KEY', 'default_secret_key')

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

@app.route('/')
def home():
    return "Welcome to the Autoparts Wiki API!"

# User Registration
@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    new_user = User(username=data['username'], password_hash=data['password'], email=data['email'])
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "User  registered successfully!"}), 201

# User Login
@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    user = User.query.filter_by(username=data['username']).first()
    if user and user.verify_password(data['password']):
        access_token = create_access_token(identity=user.id)
        return jsonify(access_token=access_token), 200
    return jsonify({"message": "Invalid credentials"}), 401

# Get All Parts
@app.route('/api/parts', methods=['GET'])
def get_parts():
    parts = Part.query.all()
    return jsonify([{'id': part.id, 'name': part.name, 'year': part.year, 'type': part.type} for part in parts])

# Add a New Part
@app.route('/api/parts', methods=['POST'])
@jwt_required()
def add_part():
    data = request.json
    new_part = Part(name=data['name'], year=data['year'], type=data['type'], description=data.get('description'), price=data.get('price'))
    db.session.add(new_part)
    db.session.commit()
    return jsonify({"message": "Part added successfully!"}), 201

# Get All Brands
@app.route('/api/brands', methods=['GET'])
def get_brands():
    brands = Brand.query.all()
    return jsonify([{'id': brand.id, 'name': brand.name} for brand in brands])

# Add a New Brand
@app.route('/api/brands', methods=['POST'])
@jwt_required()
def add_brand():
    data = request.json
    new_brand = Brand(name=data['name'])
    db.session.add(new_brand)
    db.session.commit()
    return jsonify({"message": "Brand added successfully!"}), 201

if __name__ == '__main__':
    app.run(debug=True)