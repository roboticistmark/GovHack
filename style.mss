/***

  Hi welcome to our prototype map for GovHack 2013!

	This map divides Victoria into regions of 3,000-25,000 households known
	as SA2s.  (see ASGS link below)

	We have coloured each area based on its access to public transport.

	For this map, we have counted the number of public transport connections in each area:
		-bus stops
		-tram stops
		-train stations

	Darker areas represent those that have more connections.

	The final version will use mesh blocks (a much smaller area) and count 
	the number of connections within a 1km walking distance of the mesh block.

	http://www.abs.gov.au/websitedbs/d3310114.nsf/4a256353001af3ed4b2562bb00121564/c453c497aadde71cca2576d300026a38!OpenDocument

	***/

Map {
  background-color: #fff;
}



#sa2heat2 {
  polygon-fill: #fff;
  line-color: black;
  text-name: [sa2_name11] + '_' + [heat];
  text-face-name: "DejaVu Sans Bold";
  text-placement-type: simple;
  text-size: 8;
  text-wrap-width: 1;
  text-wrap-character: '_';
  [heat >= 50 ] { polygon-fill: fadeout(red, 95%);}
  [heat >= 100 ] { polygon-fill: fadeout(red, 80%);}
  [heat >= 150 ] { polygon-fill: fadeout(red, 60%);}
  [heat >= 200 ] { polygon-fill: fadeout(red, 40%);}
  [heat >= 250 ] { polygon-fill: fadeout(red, 20%);}
  [heat >= 300 ] { polygon-fill: fadeout(red, 0%);}
  /*[heat > 0.3317 ] { polygon-fill: #ff9100;}
  [heat > 0.4886 ] { polygon-fill: #ff0000;}*/
}
