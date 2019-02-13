USE rb105;

CREATE TYPE address (
	street varchar,
	city varchar,
	state varchar,
	country varchar,
	postalCode varchar
);

CREATE COLUMNFAMILY Employee (
	employeeId int,
	firstName varchar,
	lastName varchar,
	title varchar,
	birthDate varchar,
	hireDate varchar,
	address frozen<address>,
	contact map<text, varchar>,
	email varchar,

	reportsToId int,
	reportsToLastName varchar,

	-- CLUSTER COLUMN
	customerId int,
	customerLastName varchar,
	PRIMARY KEY (employeeId, customerId, customerLastName)
) WITH CLUSTERING ORDER BY (customerId ASC);

CREATE COLUMNFAMILY Customer (
	customerId int,
	firstName varchar,
	lastName varchar,
	company varchar,
	address frozen<address>,
	contact map<text, varchar>,
	email varchar,

	supportRepId int,
	supportRepLastName varchar,

	-- CLUSTER COLUMN
	invoiceId int,
	PRIMARY KEY (customerId, invoiceId)
) WITH CLUSTERING ORDER BY (invoiceId ASC);

CREATE COLUMNFAMILY Invoice (
	invoiceId int,
	invoiceDate varchar,
	billingAddress frozen<address>,
	total decimal,

	customerId int,
	customerLastName varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	unitPrice decimal,
	quantity int,
	PRIMARY KEY (invoiceId, trackId, trackName)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Artist (
	artistId int,
	name varchar,

	-- CLUSTER COLUMN
	albumId int,
	albumTitle varchar,
	PRIMARY KEY (artistId, albumId, albumTitle)
) WITH CLUSTERING ORDER BY (albumId ASC);

CREATE COLUMNFAMILY MediaType (
	mediaTypeId int,
	name varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (mediaTypeId, trackId, trackName)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Genre (
	genreId int,
	name varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (genreId, trackId, trackName)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Album (
	albumId int,
	title varchar,
	artistName varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (albumId, trackId, trackName)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Track (
	trackId int,
	name varchar,
	composer varchar,
	milliseconds int,
	bytes int,

	albumTitle varchar,
	genre varchar,
	artistName varchar,
	unitPrice decimal,

	-- CLUSTER COLUMN
	playlistId int,
	playlistName varchar,
	PRIMARY KEY (trackId, playlistId, playlistName)
) WITH CLUSTERING ORDER BY (playlistId ASC);

CREATE COLUMNFAMILY Playlist (
	playlistId int,
	name varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (playlistId, trackId, trackName)
) WITH CLUSTERING ORDER BY (trackId ASC);



-- To facilitate searches on unindexed columns
CREATE INDEX fname_emp_idx ON Employee (firstName);
CREATE INDEX lname_emp_idx ON Employee (lastName);
CREATE INDEX reptoname_emp_idx ON Employee (reportsToLastName);

CREATE INDEX fname_cus_idx ON Customer (firstName);
CREATE INDEX lname_cus_idx ON Customer (lastName);
CREATE INDEX comp_cus_idx ON Customer (company);
CREATE INDEX suppname_cus_idx ON Customer (supportRepLastName);

CREATE INDEX date_inv_idx ON Invoice (invoiceDate);
CREATE INDEX cusname_inv_idx ON Invoice (customerLastName);

CREATE INDEX name_art_idx ON Artist (name);

CREATE INDEX name_med_idx ON MediaType (name);

CREATE INDEX name_gen_idx ON Genre (name);

CREATE INDEX title_alb_idx ON Album (title);
CREATE INDEX artname_alb_idx ON Album (artistName);

CREATE INDEX name_trk_idx ON Track (name);
CREATE INDEX comp_trk_idx ON Track (composer);
CREATE INDEX alb_trk_idx ON Track (albumTitle);
CREATE INDEX gen_trk_idx ON Track (genre);
CREATE INDEX artname_trk_idx ON Track (artistName);

CREATE INDEX name_plst_idx ON Playlist (name);