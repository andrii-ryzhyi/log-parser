#!/usr/bin/python

import psycopg2
import yaml

ERR_INDEX = 2
error_records = []

server_log = "/home/geny/git/notsobad-testcase/server.log"
report = "/home/geny/git/notsobad-testcase/report.log"

"""Read server.log file line by line to search for failed records.
   If error record found, handling execution to make_report()

    :param log: file handler object pointing to server.log
"""
def read_log(log):
	search_template = openFile(server_log)
	for line in log:
		line = line.strip()
		words = line.split()
		if error_found(words):
			trace_id = get_id(words)
			print "ERROR! Trace id: " + trace_id
			if trace_id not in error_records:
				make_report(trace_id, search_template)
	search_template.close()

"""Checks if current record has ERROR status

    :param words: list, containing parts of current record seperated by space

    Return boolean value if record is failed
"""
def error_found(words):
	return True if words[ERR_INDEX] == "ERROR" else False

def get_id(line):
	token = line[ERR_INDEX+1].split(",")
	trace_id = token[1]
	return trace_id

def make_report(failed_id, file):
	error_records.append(failed_id)	
	customer = ''
	user = ''
	for line in file:
	 	line = line.strip()
	 	words = line.split()
		curr_id = get_id(words)
		if curr_id == failed_id:
			if words[ERR_INDEX] == "INFO":
				user = words[-1]
				customer = get_customer(user)
			target.write('{0:20} {1:38} {2:25} {3:10} {4:12} {5:5} {6:40} {7}\n'.format(curr_id, user, customer, words[0], words[1], words[2], words[7], ' '.join(words[9:])))
	target.write('-------------------\n')
	file.seek(0)

def get_customer(user):
	query = " ".join((
				"select c.name from customers c",
				"join users u",
				"on c.id = u.customer_id",
				"where u.name = '{}';".format(user)
					))
	cursor.execute(query)
	row = cursor.fetchone()
	customer = row[0]
	return customer

def openFile(file, modifier="r"):
    try:
      fhandler = open(file, modifier)
      return fhandler
    except IOError:
      print "Error: File " + file + " does not exist."
      exit()

def postgres_connect(yaml_conf):
	with open(yaml_conf, 'r') as stream:
		try:
		    connection = yaml.load(stream)
		except yaml.YAMLError as exc:
		    print exc

	db = connection.get('postgresql').get('database')
	hostname = connection.get('postgresql').get('host')
	username = connection.get('postgresql').get('user')
	passwd = connection.get('postgresql').get('password')
	port_id = connection.get('postgresql').get('port')
	return "host={} dbname={} user={} password={} port={}".format(hostname, db, username, passwd, port_id)

if __name__ == "__main__":

	# checking server log location with user
	print "Server.log path: " + server_log
	answer = raw_input("Type in another path or press Enter: ")

	if len(answer) > 0:
		server_log = answer

	# writing headers into balnk report file
	target = openFile(report, 'w')
	target.write('{0:20} {1:38} {2:25} {3:10} {4:12} {5:5} {6:40} {7}\n'.format('Error_record', 'User', 'Customer', 'Date', 'Time', 'Type', 'Service', 'Status'))

	# getting posgresql connection string from yaml and establishing connection
	cs = postgres_connect("config.yaml")
	conn = psycopg2.connect(cs)
	cursor = conn.cursor()

	# start reading server.log files and catching error records
	with openFile(server_log) as log:
		read_log(log)

	print "Parser execution SUCCESSFUL"
	print "Found " + str(len(error_records)) + " error records"
	print "Report saved to: " + report

	conn.close()
	target.close()

#cursor.execute('SELECT version()')
#version = cursor.fetchone())