import pandas as pd
import csv

cust_csv_header = ['customerId', 'firstName', 'lastName', 'company', 'address', 'contact', 'email', 'supportRepId', 'supportRepLastName', 'invoiceId']

def write_new_cust_csv():
	file_data = []
	df = pd.read_csv('./extracts/before_conversion (do not import)/customer.txt', sep='\t')

	# modifying the lines to fit udts
	for i in range(len(df)):
		address = '{'
		contact = []
		company = ''

		# handling null values, tested with df.isnull().sum()
		if (not (pd.isnull(df.loc[i,'State']))):
			df.loc[i,'State'] = 'state: \'' + df.loc[i,'State'] + '\''
			address = address + df.loc[i,'State'] + ","

		if (not (pd.isnull(df.loc[i,'PostalCode']))):
			df.loc[i,'PostalCode'] = 'postalCode: \'' + df.loc[i,'PostalCode'] + '\''
			address = address + df.loc[i,'PostalCode'] + ","

		if (not (pd.isnull(df.loc[i, 'Phone']))):
			df.loc[i, 'Phone'] = '\'phone\': \'' + df.loc[i, 'Phone'] + '\''
			contact.append(df.loc[i,'Phone'])

		if (not (pd.isnull(df.loc[i,'Fax']))):
			df.loc[i,'Fax'] = '\'fax\' : \'' + df.loc[i,'Fax'] + '\''
			contact.append(df.loc[i,'Fax'])

		if (not (pd.isnull(df.loc[i,'Company']))):
			company = df.loc[i,'Company']

		df.loc[i,'Street'] = 'street: \'' + df.loc[i,'Street'] + '\''
		df.loc[i,'City'] = 'city: \'' + df.loc[i,'City'] + '\''
		df.loc[i,'Country'] = 'country: \'' + df.loc[i,'Country'] + '\''

		# address construction
		address = address + df.loc[i,'Street'] + "," + df.loc[i,'City'] + "," + df.loc[i,'Country'] + "}"

		# contact value construction
		contact = "{" + ",".join(contact) + "}"

		# file_data.append([df.loc[i,'CustomerId'], df.loc[i,'FirstName'], df.loc[i,'LastName'], df.loc[i,'Title'], df.loc[i,'BirthDate'], df.loc[i,'HireDate'], address, contact, email, df.loc[i,'Reports']])
		file_data.append([df.loc[i,'CustomerId'], df.loc[i,'FirstName'], df.loc[i,'LastName'], company, address, contact, df.loc[i,'Email'], df.loc[i,'SupportRepId'], df.loc[i,'SupportRepLastName'], df.loc[i,'InvoiceId']])
	
	# write into csv file
	with open ('./extracts/customer.csv', mode='w') as csv_file:
		writer = csv.writer(csv_file)
		writer.writerow(cust_csv_header)
		writer.writerows(file_data)

write_new_cust_csv()