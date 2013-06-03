/****
  Dependencies:
		mesh_blocks_vic - mesh block tables imported from abs
		"sii:dps_932_rail_stations_vmt" - rail stations imported from ptv
		"sii:dps_918_tram_stops_vicmap" - tram stops imported from ptv
		"sii:dps_895_bus_stops_vicmap" - bus stops imported from ptv

	Outputs:
		mb_heat - mesh block data + tram, train, bus counts
	*/
	

/* mesh blocks */
	select count(*) from mesh_blocks_vic
	select ST_Centroid(the_geom) from mesh_blocks_vic limit 10
	select * from mesh_blocks_vic limit 10

/* get rail distance */
	drop table mb_rail_distance
	create table mb_rail_distance as
	select
		mb_code11, 
		sum(case when b.ogc_fid is null then 0 else 1 end) as k_stations
	from
		mesh_blocks_vic a
	left join
		"sii:dps_932_rail_stations_vmt" b
	on
		ST_Distance_Sphere(ST_Centroid(the_geom), b.wkb_geometry) < 1000
	group by 
		mb_code11
	select max(k_stations) from mb_rail_distance

/* get tram distance */
	drop table mb_tram_distance
	create table mb_tram_distance as
	select
		mb_code11, 
		sum(case when c.ogc_fid is null then 0 else 1 end) as k_tramstops
	from
		mesh_blocks_vic a
	left join
		"sii:dps_918_tram_stops_vicmap" c
	on
		ST_Distance_Sphere(ST_Centroid(a.the_geom), c.wkb_geometry) < 1000
	group by mb_code11
	select max(k_tramstops) from mb_tram_distance

/* get bus distance */
	drop table mb_bus_distance
	create table mb_bus_distance as
	select
		mb_code11, 
		sum(case when c.ogc_fid is null then 0 else 1 end) as k_busstops
	from
	mesh_blocks_vic a
	left join
		"sii:dps_895_bus_stops_vicmap" c
	on
		ST_Distance_Sphere(ST_Centroid(a.the_geom), c.wkb_geometry) < 1000
	group by mb_code11

	select max(k_busstops) from mb_bus_distance



/* mb distance */
	drop table mb_details
	create table mb_details as
	select a.*,
		b.k_stations,
		c.k_tramstops,
		d.k_busstops,
		e.population	
	from
		mesh_blocks_vic a,
		mb_rail_distance b,
		mb_tram_distance c,
		mb_bus_distance d,
		mb_pop e
	where
			a.mb_code11 = b.mb_code11
			and a.mb_code11 = c.mb_code11
			and a.mb_code11 = d.mb_code11
			and a.mb_code11 = e.mb_code11

/* calculate heat - scaled and normalised*/

	/* 1.  scale scores between 0 and 1 to give relativity between transport modes */
	drop table mb_scores
	create table mb_scores as
	select m.*
		, (k_stations*1.0)/(select max(k_stations) from mb_details) as train_score
		, (k_busstops*1.0)/(select max(k_busstops) from mb_details) as bus_score
		, (k_tramstops*1.0)/(select max(k_tramstops) from mb_details) as tram_score
	from mb_details m

	/* 2.  combine scores (trains doubled because stations only counted once)
		make relative to area
		take logarithm to smooth
	*/
	drop table mb_heat
	create table mb_heat as
	select m.*, log(2.0, ((2*train_score + bus_score + tram_score)/(albers_sqm/1000000.0))+1) as score
	from mb_scores m

	drop table mb_heat_melb
	create table mb_heat_melb as
	select * from mb_heat
	where 
	ST_Distance_Sphere(ST_Centroid(the_geom), ST_PointFromText('POINT(145.033 -37.885)', 4326)) < 39000
