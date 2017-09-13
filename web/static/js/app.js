import "deps/phoenix_html/web/static/js/phoenix_html"
import Elm from './main';

const aboutPage = document.querySelector('#about-page');

if (aboutPage) {
  const elm = Elm.Main.embed(aboutPage);

  const initMap = () => {
    const container = document.getElementById('map-goes-here');
    if (!container) {
      console.log('map container not found');
      return;
    }
    const blue = '#007bc8';
    const cream = '#fdf6e2';
    const forest = '#004819';
    const mapStyles = [
      {elementType: 'geometry', stylers: [{color: cream}]},
      {
        featureType: 'administrative.province',
        stylers: [{color: forest}]
      },
      {
        featureType: 'administrative.country',
        stylers: [{color: forest}]
      },
      {
        featureType: 'administrative',
        elementType: 'labels.text.fill',
        stylers: [{color: forest}]
      },
      {
        featureType: 'administrative',
        elementType: 'labels.text.stroke',
        stylers: [{color: '#ffffff'}, {weight: 6}]
      },
      {
        featureType: 'road',
        elementType: 'geometry',
        stylers: [{color: forest}]
      },
      {
        featureType: 'road',
        elementType: 'geometry.stroke',
        stylers: [{color: forest}]
      },
      {
        featureType: 'water',
        elementType: 'geometry',
        stylers: [{color: blue}]
      },
    ];
    const cities = [
      {
        city: 'boston',
        coords: {lat: 42.314, lng: -71.111},
        info: 'I lived in Boston while working on my undergrad in Jazz Composition at Berklee College of Music.'
      },
      {
        city: 'brooklyn',
        coords: {lat: 40.645, lng: -74.085},
        info: 'I spent three months living in Brooklyn while I studied Ruby at the Flatiron School.'
      },
      {
        city: 'framingham',
        coords: {lat: 42.305, lng: -71.507},
        info: 'I currently live in Framingham, MA, conviently located halfway between Boston and Worcester.'
      },
      {
        city: 'highland park',
        coords: {lat: 40.501, lng: -74.446},
        info: 'My wife and I lived in Highland Park, NJ while we were finishing up school.'
      },
      {
        city: 'los angeles',
        coords: {lat: 34.019, lng: -118.974},
        info: 'I spent a summer in LA studying with some of Hollywood\'s top studio trumpet players at the sadly-defunct Henri Mancini Institute.'
      },
      {
        city: 'madison',
        coords: {lat: 43.085, lng: -89.547},
        info: 'I grew up in Madison, WI. It\'s a beautiful city with amazing food and live music.'
      },
      {
        city: 'manhattan',
        coords: {lat: 40.844, lng: -73.954},
        info: 'I got my MM and DMA at the Manhattan School of Music. It was a great honor to participate in the NYC jazz scene as a student, performer, composer, and teacher.'
      }
    ];
    const opts = {
      backgroundColor: forest,
      disableDefaultUI: true,
      styles: mapStyles,
      tilt: 45,
      zoom: 4,
    };
    const googleMap = new google.maps.Map(container, opts);
    const bounds = new google.maps.LatLngBounds();
    const infowindow = new google.maps.InfoWindow({
      content: 'default content',
      maxWidth: 150 
    });
    cities.map(city => {
      const marker = new google.maps.Marker({position: city.coords, map: googleMap})
      marker.addListener('click', () => {
        infowindow.setContent(city.info);
        infowindow.open(googleMap, marker)
      });
      bounds.extend(city.coords);
      });
    googleMap.fitBounds(bounds);
    googleMap.panToBounds(bounds);
    elm.ports.acceptMap.send(googleMap);
  };

  elm.ports.initMap.subscribe((model) => {
    window.requestAnimationFrame(initMap)
  });
}