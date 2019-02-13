import pandas as pd
import csv

"""
this script handles null values in the tsv files for importation
"""

# based on tsv files
type_indices = {
	'number' : 0,
	'string' : '---'
}

genre_file = './extracts/before_conversion (do not import)/genre.txt'
track_file = './extracts/before_conversion (do not import)/track.txt'

genre_header = ['genreId', 'name', 'trackId', 'trackName']
track_header = ['trackId', 'name', 'composer', 'milliseconds', 'bytes', 'albumtitle', 'genre', 'artistname', 'unitprice', 'playlistid', 'playlistname']

def replace_genre_nulls():
	file_data = []
	df = pd.read_csv(genre_file, sep='\t')

	for i in range(len(df)):

		# handling null values, tested with df.isnull().sum()
		if (pd.isnull(df.loc[i,'TrackId'])):
			df.loc[i,'TrackId'] = type_indices['number']

		if (pd.isnull(df.loc[i,'TrackName'])):
			df.loc[i,'TrackName'] = type_indices['string']
	
		file_data.append([df.loc[i,'GenreId'], df.loc[i,'Name'], int(df.loc[i,'TrackId']), df.loc[i,'TrackName']])
	
	# write into csv file
	with open ('./extracts/genre.tsv', mode='w') as tsv_file:
		writer = csv.writer(tsv_file, delimiter='\t')
		writer.writerow(genre_header)
		writer.writerows(file_data)

genre_header = ['genreId', 'name', 'trackId', 'trackName']

def replace_track_nulls():
	file_data = []
	df = pd.read_csv(track_file, sep='\t')

	for i in range(len(df)):

		# handling null values, tested with df.isnull().sum()
		if (pd.isnull(df.loc[i,'Composer'])):
			df.loc[i,'Composer'] = type_indices['string']

		if (pd.isnull(df.loc[i,'AlbumTitle'])):
			df.loc[i,'AlbumTitle'] = type_indices['string']

		if (pd.isnull(df.loc[i,'Genre'])):
			df.loc[i,'Genre'] = type_indices['string']

		if (pd.isnull(df.loc[i,'ArtistName'])):
			df.loc[i,'ArtistName'] = type_indices['string']

		if (pd.isnull(df.loc[i,'UnitPrice'])):
			df.loc[i,'UnitPrice'] = 0.0
	
		file_data.append([df.loc[i,'TrackId'],df.loc[i,'Name'],df.loc[i,'Composer'],df.loc[i,'Milliseconds'],df.loc[i,'Bytes'],df.loc[i,'AlbumTitle'],df.loc[i,'Genre'],df.loc[i,'ArtistName'],df.loc[i,'UnitPrice'],df.loc[i,'PlaylistId'],df.loc[i,'PlaylistName']])
	
	# write into csv file
	with open ('./extracts/track.tsv', mode='w') as tsv_file:
		writer = csv.writer(tsv_file, delimiter='\t')
		writer.writerow(track_header)
		writer.writerows(file_data)

replace_genre_nulls()
replace_track_nulls()