/***

  Hi welcome to our final map for GovHack 2013!

	This map divides Victoria into Mesh Blocks (small regions usually containing
	30-60 households - see ASGS link below).

	We have coloured each Mesh Block based on its access to public transport.

	Darker areas represent those that have more better access.

	For this map, we have counted the number of public transport connections 
	within 1km of the centre of each Mesh Block:
		-bus stops
		-tram stops
		-train stations

	Mesh Blocks then get a score based on the relative number of each, and
	the area of the Mesh Block.

	Details of the algorithm for scoring Mesh Blocks can be found on our
	GitHub page below.

	ABS:
	http://www.abs.gov.au/websitedbs/d3310114.nsf/4a256353001af3ed4b2562bb00121564/c453c497aadde71cca2576d300026a38!OpenDocument

	GitHub:
	https://github.com/roboticistmark/GovHack

	***/

Map {
  background-color: #b8dee6;
}

@red: #F00;
#mbheatmelb {
  polygon-opacity:1;
[score > 0.000000] {polygon-fill: #337f7f;}
[score > 0.500000] {polygon-fill: #336d7f;}
[score > 1.000000] {polygon-fill: #335c7f;}
[score > 1.500000] {polygon-fill: #334a7f;}
[score > 2.000000] {polygon-fill: #33387f;}
[score > 2.500000] {polygon-fill: #3e337f;}
[score > 3.000000] {polygon-fill: #50337f;}
[score > 3.500000] {polygon-fill: #62337f;}
[score > 4.000000] {polygon-fill: #73337f;}
[score > 4.500000] {polygon-fill: #7f3379;}
[score > 5.000000] {polygon-fill: #7f3367;}
[score > 5.500000] {polygon-fill: #7f3356;}
[score > 6.000000] {polygon-fill: #7f3344;}
[score > 6.500000] {polygon-fill: #7f3333;}
[score > 7.000000] {polygon-fill: #7f4433;}
[score > 7.500000] {polygon-fill: #7f5633;}
[score > 8.000000] {polygon-fill: #7f6733;}
[score > 8.500000] {polygon-fill: #7f7933;}
[score > 9.000000] {polygon-fill: #737f33;}
[score > 9.500000] {polygon-fill: #627f33;}
[score > 10.000000] {polygon-fill: #507f33;}
[score > 10.500000] {polygon-fill: #3e7f33;}
[score > 11.000000] {polygon-fill: #337f38;}
[score > 11.500000] {polygon-fill: #337f4a;}
[score > 12.000000] {polygon-fill: #337f5c;}
[score > 12.500000] {polygon-fill: #337f6d;}
}
