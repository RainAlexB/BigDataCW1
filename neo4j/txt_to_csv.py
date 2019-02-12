import csv
import re

# nodes and their headers
nodes = {
	'Album' : ['albumId:ID','title',':LABEL'],
	'Artist' : ['artistId:ID','name',':LABEL'],
	'Customer' : ['customerId:ID','name','company','address','phone','fax','email',':LABEL'], # FKs: SUPPORTREP
	'Employee' : ['employeeId:ID','name','title','birthdate','hiredate','address','phone','fax','email',':LABEL'], # FKs: REPORTID
	'Genre' : ['genreId:ID','name',':LABEL'],
	'Invoice' : ['invoiceId:ID','invoiceDate','billingAddress','total:float',':LABEL'], # FKs: CUSTOMERID
	'MediaType' : ['mediaTypeId:ID','name',':LABEL'],
	'Playlist' : ['playlistId:ID','name',':LABEL'],
	'Track' : ['trackId:ID','name','composer','milliseconds:int','bytes:int','unitPrice:float',':LABEL'] # FKs: ALBUMID, MEDIATYPEID, GENREID
}

# relationships and their headers, 
relationships = ['REPORTS_TO', 'SUPPORTED', 'BILLED', 'PERFORMED_ON', 'HAS_TRACK', 'IS_MEDIATYPE_OF', 'IS_GENRE_OF', 'ADDED', 'DOCUMENTS']
rel_headers = {
	'others' : [':START_ID',':END_ID',':TYPE'],
	'properties' : [':START_ID','unitPrice:float','quantity:int',':END_ID',':TYPE']
}

# rel_files = 
def quote_string(text):
	"""
	puts quotes around text that is a string
	"""
	test = re.compile(r'^\d*[\.]?\d*$')
	if ((not test.match(text)) and (not(text == 'NULL'))):
		new_text = text.replace('"','') # get rid of any quotes within the text
		return ((f'"{new_text}"').replace(',',';')) # quote the text and also replace the commas with semicolons
	return (text)

def set_node_id(old_id, node):
	new_id = node.lower() + str(old_id)
	return new_id

def get_rel_type(id_from, id_to):
	type_from = id_from.replace('Id', '')
	type_to = id_to.replace('Id', '')
	if (type_to == 'ReportsTo'):
		type_to = 'Employee'
	if (type_from == 'SupportRep'):
	 	type_from ='Employee'
	return [type_from, type_to]

def set_rel_type(old_id_from, old_id_to, type_from, type_to):
	new_id_from = type_from.lower() + str(old_id_from)
	new_id_to = type_to.lower() + str(old_id_to)
	return new_id_from, new_id_to



def write_node_csv():
	"""
	writes all the node csv files based on the extracted tsv data
	"""
	for n in nodes.keys():
		file_data = []
		with open("./extracts/nodes/" + n.lower() + ".txt") as tsv_file:
			next(tsv_file) # skip column titles
			for line in csv.reader(tsv_file, delimiter='\t'):
				line = list(map(quote_string, line))
				line.append(n) # add the type of node to the end of the line
				line[0] = set_node_id(line[0], n) #redefine id to avoid neo4j id repetition errors
				file_data.append(line)
		tsv_file.close()
		with open("./CSVs/nodes/" + n.lower() + ".csv", mode='w') as csv_file:
			writer = csv.writer(csv_file, quotechar='', quoting=csv.QUOTE_NONE)
			writer.writerow(nodes[n])
			for data in file_data:
				writer.writerow(data)
		csv_file.close()

def write_rel_csv():
	"""
	writes all the relationship csv files based on the extracted tsv data
	"""
	for r in relationships:
		file_data = []
		with open("./extracts/rels/" + r.lower() + ".txt") as tsv_file:
			# get relationship types
			line = next(tsv_file).rstrip().split('\t')
			rel_types = get_rel_type(line[0], line[-1])
			for line in csv.reader(tsv_file, delimiter='\t'):
				line[0], line[-1] = set_rel_type(line[0], line[-1], rel_types[0], rel_types[-1])
				line.append(r) # add the type of relationship to the end of the line
				file_data.append(line)
		tsv_file.close()
		with open("./CSVs/rels/" + r.lower() + ".csv", mode='w') as csv_file:
			writer = csv.writer(csv_file)
			if (r == 'DOCUMENTS'): # documents has extra properties so needs a different header
				writer.writerow(rel_headers['properties'])
			else :
				writer.writerow(rel_headers['others'])
			for data in file_data:
				writer.writerow(data)
		csv_file.close()

write_node_csv()
write_rel_csv()