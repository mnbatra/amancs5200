-- CREATING SIX BASE TABLES Author, Certification, AuthorCertification, Topic, Course, CourseTopic
   --overall assumption : Primary key can be null in sqlite

	--comment: certifications is multivalued attribute with a categorical domain so without enum data type its best to make a separate table,
	---An Author can have many certifications
CREATE TABLE IF NOT EXISTS "Author" (
	"aid" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name" VARCHAR(255) NOT NULL,
	"bio" TEXT NOT NULL

);
  	-- certification name can be inputted in both uppercase and lowercase, so to avoid ambiguity we will use COLLATE NOCASE,which makes column case-insensitive
    -- The names can be converted to LOWERCASE/UPPERCASE if/when needed using application logic
    -- But for assignment 3, I am trying to implement it using DDL logic
CREATE TABLE IF NOT EXISTS "Certification" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" COLLATE NOCASE UNIQUE NOT NULL,
    CHECK (name IN ('cap','csm','cste','cbap','pmp'))

);

 
	-- A linking table is needed becasue Author shares a many to many relationship wth certifications
	-- In an alternative approach we could avoid this table since certifications attribute are just values and not instances
	-- but in case more certifications are added in future, a linking table makes most sense
CREATE TABLE IF NOT EXISTS "AuthorCertification" (
    "cert_id" INTEGER,
    "author_id" INTEGER,
    FOREIGN KEY("author_id") REFERENCES "Author"("aid"),
    FOREIGN KEY("cert_id") REFERENCES "Certification"("id")
);

	--Topic and Course create a circular dependency due to total participation on both sides, we will resolve that using application logic
	--DEFERRABLE INITITALLY DEFERRED clause can be used along with foreign keys, to enforce total participation on DDL level but
	--It involves the usage of transactions, which has not been covered yet.

CREATE TABLE IF NOT EXISTS "Topic" (
    "tid" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" VARCHAR(255) NOT NULL,
    "topic_length" INTEGER NOT NULL,
    "subjectArea" TEXT NOT NULL,
	"taid" INTEGER,
	FOREIGN KEY ("taid") REFERENCES "Author" ("aid"),
    CHECK (topic_length>0)	
);

 	-- The datatype COLLATE NOCASE goes well with number because a textual primary key can lead to duplicate values due to case-sentivity
 CREATE TABLE IF NOT EXISTS "Course" (
    "number" COLLATE NOCASE NOT NULL PRIMARY KEY,
    "title" VARCHAR(255) NOT NULL,
    "course_length" INTEGER,
    CHECK (course_length>0)
);

 

CREATE TABLE IF NOT EXISTS "CourseTopic" (
     "course_id" TEXT,
     "topic_id" INTEGER,
     FOREIGN KEY("course_id") REFERENCES "Course"("number"),
     FOREIGN KEY("topic_id") REFERENCES "Topic"("tid")
);


--Demo data to test each column
--This segment can be ignored.

INSERT INTO Author(name,bio) VALUES('Aman','my bio');
INSERT INTO Course(number,title,course_length) VALUES('cs5200','DBMS','55');
INSERT INTO Topic(name,topic_length,subjectArea,taid) VALUES('SQL','10','Computer Science','1');
INSERT INTO Certification(name) VALUES('pmp');
INSERT INTO Certification(name) VALUES('csm');
INSERT INTO AuthorCertification(cert_id,author_id) VALUES('1','1');
INSERT INTO AuthorCertification(cert_id,author_id) VALUES('2','1');
INSERT INTO CourseTopic(course_id,topic_id) VALUES('cs5200','1');