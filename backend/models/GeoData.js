const mongoose = require('mongoose');

const geoDataSchema = new mongoose.Schema({
  filePath: { type: String, required: true },
});

module.exports = mongoose.model('GeoData', geoDataSchema);
