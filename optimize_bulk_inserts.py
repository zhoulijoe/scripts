from optparse import OptionParser
import MySQLdb as mdb

def enable_insert_optimization(db_name):
   con = mdb.connect('localhost', 'finder', 'finder', db_name)
   cur = con.cursor()
   cur.execute('''show tables;''')
   tables = [x[0] for x in cur.fetchall()]


   for table in tables:

     cmd = 'ALTER TABLE ' + table + ' DISABLE KEYS;'
     print cmd
     cur.execute(cmd)



   cur.execute('''
set foreign_key_checks = 0;
set unique_checks = 0;
set autocommit = 0;
''')
   cur.close()

def disable_insert_optimization(db_name):
   con = mdb.connect('localhost', 'finder', 'finder', db_name)
   cur = con.cursor()
   cur.execute('''show tables;''')
   tables = cur.fetchall()
   cur.close()

   for table in tables:
     cur = con.cursor()
     cur.execute('''alter table ''' + table + ''' enable keys;''')
     cur.close()

   cur = con.cursor()
   cur.execute('''
set foreign_key_checks = 1;
set unique_checks = 1;
commit;
''')
   cur.close()


def main():
   parser = OptionParser()
     
   parser.add_option('-e', '--enable ', action='store_true',
                     help = 'enable optimization ; default is "%default"',
                     dest='enable')
   
   (options, args) = parser.parse_args()
   
   dbs = ['finder_sprint', 'finder_sprint_billing']
   for db in dbs:
       if options.enable:
           enable_insert_optimization(db)
       else:
           disable_insert_optimization(db)
       
     
if __name__ == '__main__':
   main()
