delimiter //
DROP TRIGGER IF EXISTS InteractionsDelete_UpdateAudit;
//
CREATE TRIGGER InteractionsDelete_UpdateAudit AFTER
DELETE ON Interactions
FOR EACH ROW 
BEGIN
DECLARE aschar varchar(50);
SET aschar=OLD.interactionid;
IF aschar in 
(SELECT usereventid FROM ChkUserEventUniqueness
  WHERE usereventid = aschar
  AND usage_flag>0) 
  THEN
  UPDATE ChkUserEventUniqueness
  SET usereventid = CONCAT('interaction_',usereventid,'_deleted')
  WHERE usereventid=aschar;
END IF; 
END;
//

delimiter //
DROP TRIGGER IF EXISTS VisitDelete_UpdateAudit;
//
CREATE TRIGGER VisitDelete_UpdateAudit AFTER
DELETE ON Visit
FOR EACH ROW 
BEGIN
DECLARE aschar varchar(50);
SET aschar=OLD.visitid;
IF aschar in 
(SELECT usereventid FROM ChkUserEventUniqueness
  WHERE usereventid = aschar
  AND usage_flag>0) 
  THEN
  UPDATE ChkUserEventUniqueness
  SET usereventid = CONCAT('visit_',usereventid,'_deleted')
  WHERE usereventid=aschar;
END IF; 
END;
//