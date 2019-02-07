CREATE COLUMNFAMILY Album (
	albumId int,
	title varchar,
	artistName varchar,
	PRIMARY KEY (albumId)
);

CREATE COLUMNFAMILY Artist (
	artistId int,
	name varchar,
	PRIMARY KEY (artistId)
);

CREATE COLUMNFAMILY Customer (
	customerId int,
	customerName varchar,
	company varchar,
	address varchar,
	phone varchar,
	fax varchar,
	email varchar,
	supportRepName varchar,
	PRIMARY KEY (customerId)
);

CREATE COLUMNFAMILY Employee (
	employeeId int,
	employeeName varchar,
	title varchar,
	birthDate varchar,
	hireDate varchar,
	address varchar,
	phone varchar,
	fax varchar,
	email varchar,
	reportsToName varchar,
	PRIMARY KEY (employeeId)
);

CREATE COLUMNFAMILY Genre (
	genreId int,
	name varchar,
	PRIMARY KEY (genreId)
);

CREATE COLUMNFAMILY InvoiceLine (
	invoiceLineId int,
	unitPrice decimal,
	quantity int,
	invoiceId int,
	trackName varchar,
	PRIMARY KEY (invoiceLineId)
);

CREATE COLUMNFAMILY Invoice (
	invoiceId int,
	invoiceDate varchar,
	billingAddress varchar,
	total decimal,
	customerName varchar,
	PRIMARY KEY (invoiceId)
);

CREATE COLUMNFAMILY MediaType (
	mediaTypeId int,
	name varchar,
	PRIMARY KEY (mediaTypeId)
);

CREATE COLUMNFAMILY Playlist (
	playlistId int,
	name varchar,
	PRIMARY KEY (playlistId)
);

CREATE COLUMNFAMILY PlaylistTrack (
	playlistId int,
	trackId int,
	playlistName varchar,
	trackName varchar,
	PRIMARY KEY (playlistId, trackId)
);

CREATE COLUMNFAMILY Track (
	trackId int,
	name varchar,
	composer varchar,
	milliseconds int,
	bytes int,
	unitPrice decimal,
	albumTitle varchar,
	mediaTypeName varchar,
	genreName varchar,
	PRIMARY KEY (trackId)
);