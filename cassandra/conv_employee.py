import pandas as pd
import csv

emp_csv_header = ['employeeId', 'firstName', 'lastName', 'title', 'birthDate', 'hireDate', 'address', 'contact', 'email', 'reportsToId', 'reportsToLastName', 'customerId', 'customerLastName']

def write_new_emp_csv():
	file_data = []
	df = pd.read_csv('./extracts/before_conversion (do not import)/employee.txt', sep='\t')

	# modifying the lines to fit udts
	for i in range(len(df)):
		address = '{'
		contact = []
		reportsName = ''
		customerId = 0
		customerName = '---'

		# handling null values, tested with df.isnull().sum()
		if (not (pd.isnull(df.loc[i,'ReportsToLastName']))):
			reportsName = df.loc[i,'ReportsToLastName']

		if (not (pd.isnull(df.loc[i,'CustomerId']))):
			customerId = int(df.loc[i,'CustomerId'])

		if (not (pd.isnull(df.loc[i,'CustomerLastName']))):
			customerName = df.loc[i,'CustomerLastName']

		# address construction
		df.loc[i,'Street'] = 'street: \'' + df.loc[i,'Street'] + '\''
		df.loc[i,'City'] = 'city: \'' + df.loc[i,'City'] + '\''
		df.loc[i,'State'] = 'state: \'' + df.loc[i,'State'] + '\''
		df.loc[i,'Country'] = 'country: \'' + df.loc[i,'Country'] + '\''
		df.loc[i,'PostalCode'] = 'postalCode: \'' + df.loc[i,'PostalCode'] + '\''

		address = address + df.loc[i,'Street'] + "," + df.loc[i,'City'] + "," + df.loc[i,'State'] + "," + df.loc[i,'Country'] + "," + df.loc[i,'PostalCode'] + "}"
		
		# contact value construction
		df.loc[i, 'Phone'] = '\'phone\': \'' + df.loc[i, 'Phone'] + '\''
		df.loc[i,'Fax'] = '\'fax\' : \'' + df.loc[i,'Fax'] + '\''
		contact.append(df.loc[i,'Phone'])
		contact.append(df.loc[i,'Fax'])
		
		contact = "{" + ",".join(contact) + "}"

		file_data.append([df.loc[i,'EmployeeId'], df.loc[i,'FirstName'], df.loc[i,'LastName'], df.loc[i,'Title'], df.loc[i,'BirthDate'], df.loc[i,'HireDate'], address, contact, df.loc[i,'Email'], df.loc[i,'ReportsToId'], reportsName, customerId, customerName])
	
	# write into csv file
	with open ('./extracts/employee.csv', mode='w') as csv_file:
		writer = csv.writer(csv_file)
		writer.writerow(emp_csv_header)
		writer.writerows(file_data)
	
write_new_emp_csv()