
from typing import final
import psycopg2

hostname = 'localhost'
database = 'python'
username = 'postgres'
pwd = 'Qwe53215'
port_id = 5432
conn = None
cur = None




try:
       conn = psycopg2.connect(
                host = hostname,
                dbname = database ,
                user = username,
                password = pwd,
                port = port_id)
       cur = conn.cursor()   
 
       create_script = '''  CREATE TABLE IF NOT EXISTS NFT(
                                        id int PRIMARY KEY,
                                        value varchar NOT NULL
                                        
                                         )
            
       '''  
       cur.execute(create_script)
       
       conn.commit()

except Exception as error:
    print(error)

finally :
    if cur is not None:
         cur.close()
    if conn is not None:
         conn.close()

 
       