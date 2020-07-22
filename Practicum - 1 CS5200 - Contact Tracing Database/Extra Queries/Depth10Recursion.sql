WITH recursive iml AS (
select interactionid, interactinguserid, visitorid, 0 AS depth from 
interactions
where visitorid = 1310
UNION ALL
SELECT i.interactionid, i.interactinguserid, i.VisitorID, iml.depth +1
from interactions i
inner join iml on i.interactinguserid=iml.visitorid
) 
select * from iml;

