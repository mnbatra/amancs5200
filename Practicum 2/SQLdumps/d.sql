DROP table ChkUserEventUniqueness;

CREATE TABLE IF NOT EXISTS ChkUserEventUniqueness (
  id INTEGER AUTO_INCREMENT,
  usereventid INTEGER UNIQUE, 
  textlog varchar(50),
  ins_timestamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;