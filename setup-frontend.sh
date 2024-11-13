#!/bin/bash

# Navigate to the frontend folder
cd "G:/Skyserve Project/geo-data-app/frontend"

# Initialize Vue project (if not done yet)
npm init vue@latest

# Install dependencies for Vue.js and Mapbox
npm install vue mapbox-gl axios

# Create basic Vue files (MapComponent.vue, App.vue, main.js)
mkdir -p src/components

# MapComponent.vue
echo "<template>
  <div>
    <div id='map' ref='mapContainer' class='map-container'></div>
    <button @click='toggleDataset'>Toggle Dataset</button>
  </div>
</template>

<script>
import mapboxgl from 'mapbox-gl';
import axios from 'axios';

export default {
  name: 'MapComponent',
  data() {
    return {
      map: null,
      geoJsonData: null,
    };
  },
  mounted() {
    mapboxgl.accessToken = 'YOUR_MAPBOX_ACCESS_TOKEN';
    this.map = new mapboxgl.Map({
      container: this.$refs.mapContainer,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [0, 0],
      zoom: 2,
    });

    axios.get('http://localhost:5000/api/geodata')
      .then(response => {
        this.geoJsonData = response.data;
        this.addGeoJsonLayer();
      })
      .catch(error => {
        console.error(error);
      });
  },
  methods: {
    addGeoJsonLayer() {
      if (this.geoJsonData) {
        this.map.on('load', () => {
          this.map.addSource('geojson', {
            type: 'geojson',
            data: this.geoJsonData
          });

          this.map.addLayer({
            id: 'geojson-layer',
            type: 'fill',
            source: 'geojson',
            paint: {
              'fill-color': '#888888',
              'fill-opacity': 0.4
            }
          });
        });
      }
    },
    toggleDataset() {
      const layer = this.map.getLayer('geojson-layer');
      if (layer) {
        const visibility = this.map.getLayoutProperty(layer.id, 'visibility');
        this.map.setLayoutProperty(layer.id, 'visibility', visibility === 'visible' ? 'none' : 'visible');
      }
    }
  }
};
</script>

<style>
.map-container {
  width: 100%;
  height: 100vh;
}
</style>" > src/components/MapComponent.vue

# main.js
echo "import { createApp } from 'vue';
import App from './App.vue';

createApp(App).mount('#app');" > src/main.js

# App.vue
echo "<template>
  <MapComponent />
</template>

<script>
import MapComponent from './components/MapComponent.vue';

export default {
  components: {
    MapComponent,
  },
};
</script>" > src/App.vue

echo "Frontend setup complete."
