import pandas as pd
import csv

inv_csv_header = ['invoiceId', 'invoiceDate', 'billingAdress', 'total', 'customerId', 'customerLastName', 'trackId', 'trackName', 'unitPrice', 'quantity']

def write_new_inv_csv():
	file_data = []
	df = pd.read_csv('./extracts/before_conversion (do not import)/invoice.txt', sep='\t')

	# modifying the lines to fit udts
	for i in range(len(df)):
		address = '{'

		# handling null values, tested with df.isnull().sum()
		if (not (pd.isnull(df.loc[i,'State']))):
			df.loc[i,'State'] = 'state: \'' + df.loc[i,'State'] + '\''
			address = address + df.loc[i,'State'] + ","

		if (not (pd.isnull(df.loc[i,'PostalCode']))):
			df.loc[i,'PostalCode'] = 'postalCode: \'' + df.loc[i,'PostalCode'] + '\''
			address = address + df.loc[i,'PostalCode'] + ","

		df.loc[i,'Street'] = 'street: \'' + df.loc[i,'Street'] + '\''
		df.loc[i,'City'] = 'city: \'' + df.loc[i,'City'] + '\''
		df.loc[i,'Country'] = 'country: \'' + df.loc[i,'Country'] + '\''

		address = address + df.loc[i,'Street'] + "," + df.loc[i,'City'] + "," + df.loc[i,'Country'] + "}"

		file_data.append([df.loc[i,'InvoiceId'], df.loc[i,'InvoiceDate'], address, df.loc[i,'Total'], df.loc[i,'CustomerId'], df.loc[i,'CustomerLastName'], df.loc[i,'TrackId'], df.loc[i,'TrackName'], df.loc[i,'UnitPrice'], df.loc[i,'Quantity']])
	
	# write into csv file
	with open ('./extracts/invoice.csv', mode='w') as csv_file:
		writer = csv.writer(csv_file)
		writer.writerow(inv_csv_header)
		writer.writerows(file_data)
	
write_new_inv_csv()