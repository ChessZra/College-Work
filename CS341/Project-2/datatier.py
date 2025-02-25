#
# datatier.py
# Executes SQL queries against the given database.
#
# Original author: Ellen Kidane and Prof. Joe Hummel
#
import sqlite3


##################################################################
#
# select_one_row:
#
# Given a database connection and a SQL SELECT query,
# executes this query against the database and returns
# the first row retrieved by the query. If no data was 
# retrieved, the empty tuple () is returned.
# The query can be parameterized, in which case pass 
# the values as a list via parameters; this parameter 
# is optional.
#
# Returns: - first row retrieved by the given query, or
#          - () if no data was retrieved, or
#          - None if an error occurs (with a message printed).
#
def select_one_row(dbConn, sql, parameters = None):
   pass


##################################################################
#
# select_n_rows:
#
# Given a database connection and a SQL SELECT query,
# executes this query against the database and returns
# a list of rows retrieved by the query. If the query
# retrieves no data, the empty list [] is returned.
# The query can be parameterized, in which case pass 
# the values as a list via parameters; this parameter 
# is optional.
#
# Returns: - a list of 0 or more rows, or
#          - None if an error occurs (with a message printed).
#
def select_n_rows(dbConn, sql, parameters = None):
   pass


##################################################################
#
# perform_action: 
# 
# Given a database connection and a SQL action query,
# executes this query and returns the number of rows
# modified. A return value of 0 means no rows were
# updated.
# Action queries are typically "insert", "update", 
# and "delete".
# The query can be parameterized, in which case pass 
# the values as a list via parameters; this parameter 
# is optional.
#
# Returns: - the number of rows modified by the query, or
#          - -1 if an error occurs (with a message printed).
#          A return value of 0 is not considered an error.
#          It simply means that the query did not change
#          the database.
#
def perform_action(dbConn, sql, parameters = None):
   pass