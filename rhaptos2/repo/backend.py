


"""
backend - we have not come to sensible conlcusions about the backend
so here are three backend stores, in parallel - we should only end up wiht 
one - txt (obviously not) pgsql, redis

pgsql we have in house esxpertise in .

redis offers full single records JSON support


"""


from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()
from sqlalchemy.orm import sessionmaker

def connect_now(confd):
    ##pooling etc needed
    connstr = "postgresql+psycopg2://%(pgusername)s:%(pgpasswd)s@%(pghost)s/%(pgusername)s" % confd
    engine = create_engine(connstr)
    return engine


class Module(Base):
    __tablename__ = 'module'
    uid = Column(String, primary_key=True)
    title = Column(String)
    content = Column(String)
    

    #not really needed ... will use above definitoon
    def __init__(self, uid=None, title=None, content=None):
        self.uid = uid
        self.title = title
        self.content = content

    def __repr__(self):
        return "Module:(%s)-%s" % (self.uid, self.title)
        


def bind(engine):

    Session = sessionmaker(bind=engine)
    session = Session()
    return session


d = {"pgusername": "repouser2",
      "pgpasswd": "pass2",
      "pghost"    : "localhost",}
engine = connect_now(d)

s = bind(engine)
m = Module(uid='12345',title='swag',content='XXX')
s.add(m)
s.commit()
print m



