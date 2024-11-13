const express = require('express');
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

app.listen(5000, () => console.log('Server running on port 5000'));
