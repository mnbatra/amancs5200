/*Creating the table AuditCourseTopic to store results from Triggers*/


CREATE TABLE IF NOT EXISTS AuditCourseTopic (
  auditID INTEGER PRIMARY KEY AUTOINCREMENT, 
  course_id TEXT NOT NULL, title TEXT NOT NULL, 
  topic_id TEXT NOT NULL, name TEXT NOT NULL, 
  status Text NOT NULL, Timestamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*Triggers to audit adding and deletion of topics in a Courses and store the values in the AuditCourseTopic Table*/

/*The purpose of these triggers is to keep track of all topics that were added or removed from the courses

/* Trigger to store details when a new topic is added to a course*/


/* TRIGGER 1 has 3 Parts Insert, Delete and Update */

CREATE TRIGGER if not EXISTS after_add_topic_to_course 
AFTER 
  INSERT ON CourseTopic FOR EACH ROW
  BEGIN 
  INSERT INTO AuditCourseTopic (
    course_id, title, topic_id, name, status, 
    Timestamp
  ) 
select 
  NEW.course_id as course_id, 
  c.title as title, 
  NEW.topic_id as topic_id, 
  t.name as name, 
  "New topic added to course" as status, 
  CURRENT_TIMESTAMP as Timestamp 
from 
  CourseTopic ct, 
  Course c, 
  topic t 
where 
  ct.course_id = NEW.course_id 
  AND ct.course_id = c.number 
  AND ct.topic_id = t.tid;
END;


CREATE TRIGGER if not EXISTS after_delete_topic_from_course 
AFTER 
  DELETE ON CourseTopic FOR EACH ROW 
  BEGIN 
  INSERT INTO AuditCourseTopic (
    course_id, title, topic_id, name, status, 
    Timestamp
  ) 
select 
  OLD.course_id as course_id, 
  c.title as title, 
  OLD.topic_id as topic_id, 
  t.name as name, 
  "Topic was deleted from Course" as status, 
  CURRENT_TIMESTAMP as Timestamp 
from 
  CourseTopic ct, 
  Course c, 
  topic t 
where 
  ct.course_id = OLD.course_id 
  AND ct.course_id = c.number 
  AND ct.topic_id = t.tid;
END;

CREATE TRIGGER if not EXISTS after_update_topic_in_course 
AFTER 
  UPDATE ON CourseTopic 
  FOR EACH ROW 
  BEGIN 
  INSERT INTO AuditCourseTopic (
    course_id, title, topic_id, name, status, 
    Timestamp
  ) 
select 
  NEW.course_id as course_id, 
  c.title as title, 
  NEW.topic_id as topic_id, 
  t.name as name, 
  "Topic was changed in the course" as status, 
  CURRENT_TIMESTAMP as Timestamp 
from 
  CourseTopic ct, 
  Course c, 
  topic t 
where 
  ct.course_id = NEW.course_id 
  AND ct.course_id = c.number 
  AND ct.topic_id = t.tid;
END;

/* Test cases to check the 3 operations : Insert, Delete and Update*/

/*INSERT*/
INSERT INTO CourseTopic VALUES('CS1014',101);


/*DELETE*/
DELETE FROM CourseTopic WHERE topic_id=97;


/*UPDATE*/
UPDATE CourseTopic SET topic_id=55 WHERE course_id='CS1015';


SELECT * From AuditCourseTopic;





/* TRIGGER 2 */

/* The Purpose of this very basic trigger is to make every course number uppercase */






CREATE TRIGGER if not EXISTS update_course_title_to_uppercase 
AFTER INSERT ON Course
FOR EACH ROW
BEGIN

UPDATE Course

  SET 
  
  number = UPPER(number);
    
END;


INSERT into Course(number,title,course_length) VALUES ('Cs1016','Packet Sniffing',12),('cs1017','Direct Denial of Service',30);

SELECT * FROM Course;

