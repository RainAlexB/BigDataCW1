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
	PRIMARY KEY (employeeId, customerId)
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
	PRIMARY KEY (invoiceId, trackId)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Artist (
	artistId int,
	name varchar,

	-- CLUSTER COLUMN
	albumId int,
	albumTitle varchar,
	PRIMARY KEY (artistId, albumId)
) WITH CLUSTERING ORDER BY (albumId ASC);

CREATE COLUMNFAMILY MediaType (
	mediaTypeId int,
	name varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (mediaTypeId, trackId)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Genre (
	genreId int,
	name varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (genreId, trackId)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Album (
	albumId int,
	title varchar,
	artistName varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (albumId, trackId)
) WITH CLUSTERING ORDER BY (trackId ASC);

CREATE COLUMNFAMILY Track (
	trackId int,
	name varchar,
	composer varchar,
	milliseconds int,
	bytes int,
	unitPrice decimal,

	albumTitle varchar,
	genre varchar,
	artistName varchar,

	-- CLUSTER COLUMN
	playlistId int,
	playlistName varchar
	PRIMARY KEY (trackId, playlistId)
) WITH CLUSTERING ORDER BY (playlistId ASC);

CREATE COLUMNFAMILY Playlist (
	playlistId int,
	name varchar,

	-- CLUSTER COLUMN
	trackId int,
	trackName varchar,
	PRIMARY KEY (playlistId, trackId)
) WITH CLUSTERING ORDER BY (trackId ASC);



-- To facilitate searches on unindexed columns
CREATE INDEX ON Employee (firstName, lastName, reportsToLastName, customerLastName);

CREATE INDEX ON Customer (firstName, lastName, company, supportRepLastName, invoiceId);

CREATE INDEX ON Invoice (invoiceDate, customerLastName, trackName);

CREATE INDEX ON Artist (name);

CREATE INDEX ON MediaType (name);

CREATE INDEX ON Genre (name);

CREATE INDEX ON Album (title, artistName, trackName);

CREATE INDEX ON Track (name, composer, albumTitle, genre, artistName, playlistName);

CREATE INDEX ON Playlist (name, trackName);