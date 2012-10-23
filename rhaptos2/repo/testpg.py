import psycopg2

"""
CREATE USER repo3 PASSWORD 'pass3';
CREATE SCHEMA repo3;
GRANT ALL ON SCHEMA repo3 TO repo3;
ALTER USER repo3 SET search_path TO REPO3,PUBLIC;
GRANT USAGE ON SCHEMA APP TO REPO3;
"""


conn = psycopg2.connect("dbname='repouser2' user='repouser2' host='localhost' password='pass2'");
c = conn.cursor()
c.execute("Select 1;")
rs = c.fetchall()
print rs

c.execute("SELECT * FROM public.module;")
rs = c.fetchall()
print rs


