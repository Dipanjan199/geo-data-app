<template>
  <div id="map" style="width: 100%; height: 100vh;"></div>
</template>

<script>
import mapboxgl from 'mapbox-gl';

export default {
  mounted() {
    mapboxgl.accessToken = 'your-mapbox-access-token';
    this.map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [0, 0],
      zoom: 2
    });
  }
};
</script>

<style scoped>
#map {
  width: 100%;
  height: 100vh;
}
</style>


