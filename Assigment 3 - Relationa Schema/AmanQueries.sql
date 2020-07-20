CREATE TABLE IF NOT  EXISTS "Author" ( 
    "a_id" INTEGER PRIMARY KEY AUTOINCREMENT, 
    "a_name" TEXT NOT NULL,
    "a_bio" TEXT NOT NULL,
	"a_topic_id" INTEGER NOT NULL REFERENCES "Topic" ("t_id")
);

CREATE TABLE IF NOT EXISTS "Author_Certifications" (
	"cert_id" INTEGER PRIMARY KEY AUTOINCREMENT,
	"cert_name" TEXT NOT NULL,
	"cert_auth_id" INTEGER NOT NULL REFERENCES "Author" ("a_id"),
	CHECK (cert_name IN ('CAP','CSM','CSTE','CBAP','PMP'))

);

CREATE TABLE IF NOT EXISTS "Course" (
    "c_number" INTEGER PRIMARY KEY AUTOINCREMENT,
    "c_title" TEXT NOT NULL,
    "c_length" INTEGER
    "course_ct_id" INTEGER NOT NULL REFERENCES "Course_topic" ("ct_id")
    CHECK(c_length>=0)
    
);
CREATE TABLE IF NOT EXISTS "Topic" (
    "t_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "t_name" TEXT NOT NULL,
    "t_length" INTEGER,
    "t_subjectArea" TEXT NOT NULL,
    "t_author" INTEGER REFERENCES "Author" ("a_id") ON DELETE SET NULL
);
 
CREATE INDEX IF NOT EXISTS "idx_topic__author" ON "Topic" ("t_author");
 
CREATE TABLE IF NOT EXISTS "Course_topic" (
    "ct_course" INTEGER NOT NULL REFERENCES "Course" ("c_number"),
    "ct_topic" INTEGER NOT NULL REFERENCES "Topic" ("t_id"),
    "ct_id" INTEGER PRIMARY KEY AUTOINCREMENT
);
 
CREATE INDEX IF NOT EXISTS "idx_course__topic" ON "Course_topic" ("ct_topic");
 
CREATE TABLE IF NOT EXISTS "Video" (
    "v_id" TEXT NOT NULL PRIMARY KEY,
    "v_title" TEXT NOT NULL,
    "v_length" NUMERIC NOT NULL,
    CHECK (v_length>=0)
);
 
CREATE TABLE IF NOT EXISTS "Scenes" (
    "s_id" NUMERIC NOT NULL PRIMARY KEY,
    "s_nickname" TEXT NOT NULL,
    "s_narrator" TEXT NOT NULL
);
    
 
CREATE TABLE IF NOT EXISTS "Video_content" (
    "vc_vid" TEXT NOT NULL REFERENCES "Video" ("v_id"),
    "vc_sid" NUMERIC NOT NULL REFERENCES "Scenes" ("s_id"),
    PRIMARY KEY (vc_vid, vc_sid)
);
 
CREATE TABLE IF NOT EXISTS "Authorship" (
    "au_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "au_author_aid" INTEGER NOT NULL REFERENCES "Author" ("a_id"),
    "au_course_number" TEXT NOT NULL REFERENCES "Course" ("c_number")
);
 
CREATE TABLE IF NOT EXISTS "Topic_content" (
    "tc_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "tc_v_id" TEXT NOT NULL REFERENCES "Video" ("v_id"),
    "tc_topic_id" INTEGER NOT NULL REFERENCES "Topic" ("t_id")
);
   