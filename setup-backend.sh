#!/bin/bash

# Navigate to the backend folder
cd "G:/Skyserve Project/geo-data-app/backend"

# Initialize Node.js project (if not done yet)
npm init -y

# Install dependencies
npm install express mongoose bcryptjs jsonwebtoken multer cors

# Create the necessary folders and files
mkdir routes models

# Add the server.js file
echo "const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const UserRoutes = require('./routes/auth');
const GeoDataRoutes = require('./routes/geoData');

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/geo_data', { useNewUrlParser: true, useUnifiedTopology: true });

app.use('/api/auth', UserRoutes);
app.use('/api/geodata', GeoDataRoutes);

app.listen(5000, () => console.log('Server running on port 5000'));" > server.js

# Add auth route file
echo "const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const router = express.Router();

// User registration
router.post('/register', async (req, res) => {
  const { email, password } = req.body;

  const existingUser = await User.findOne({ email });
  if (existingUser) return res.status(400).json({ message: 'User already exists' });

  const hashedPassword = await bcrypt.hash(password, 10);

  const newUser = new User({ email, password: hashedPassword });
  await newUser.save();

  res.status(201).json({ message: 'User registered successfully' });
});

// User login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });
  if (!user) return res.status(400).json({ message: 'User not found' });

  const isValidPassword = await bcrypt.compare(password, user.password);
  if (!isValidPassword) return res.status(400).json({ message: 'Invalid password' });

  const token = jwt.sign({ userId: user._id }, 'your-jwt-secret');
  res.json({ token });
});

module.exports = router;" > routes/auth.js

# Add GeoData model
echo "const mongoose = require('mongoose');

const geoDataSchema = new mongoose.Schema({
  filePath: { type: String, required: true },
});

module.exports = mongoose.model('GeoData', geoDataSchema);" > models/GeoData.js

# Add User model
echo "const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true }
});

module.exports = mongoose.model('User', userSchema);" > models/User.js

echo "Backend setup complete."
