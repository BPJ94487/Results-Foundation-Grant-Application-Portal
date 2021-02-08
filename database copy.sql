
-- If you need to restart the database, this drop statement will drop everything in the correct order. 
-- DROP TABLE app_question, question, app, notes, app, grant_window, focus_area, review_status, "user";

--------------------- CREATE TABLES ------------------

CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "username" VARCHAR (80) UNIQUE NOT NULL,
  "password" VARCHAR (1000) NOT NULL,
  "org_name" VARCHAR (100),
  "background" VARCHAR (1000),
  "phone" VARCHAR (25),
  "contact_name" VARCHAR (150),
  "admin" boolean DEFAULT false
);

CREATE TABLE "grant_window" (
  "id" SERIAL PRIMARY KEY,
  "start_date" date,
  "end_date" date,
  "funds_available" int
);

CREATE TABLE "review_status" (
  "id" SERIAL PRIMARY KEY,
  "status" VARCHAR (50)
);

CREATE TABLE "focus_area" (
  "id" SERIAL PRIMARY KEY,
  "focus" VARCHAR (50)
);

CREATE TABLE "app" (
  "id" SERIAL PRIMARY KEY,
  "date_received" date NOT NULL DEFAULT CURRENT_DATE,
  "grant_window_id" int REFERENCES "grant_window",
  "focus_area_id" int REFERENCES "focus_area",
  "user_id" int REFERENCES "user",
  "budget" INT,
  "review_status_id" int REFERENCES "review_status" DEFAULT 2
);

CREATE TABLE "question" (
  "id" SERIAL PRIMARY KEY,
  "question_text" varchar,
  "active" boolean DEFAULT true,
  "created" date DEFAULT CURRENT_DATE
);

CREATE TABLE "app_question" (
  "id" SERIAL PRIMARY KEY,
  "app_id" int REFERENCES "app",
  "question_id" int REFERENCES "question",
  "answer_text" varchar,
  "review_score" int
);

CREATE TABLE "notes" (
  "id" SERIAL PRIMARY KEY,
  "review_note" VARCHAR (750),
  "date_added" date NOT NULL DEFAULT CURRENT_DATE,
  "app_id" int REFERENCES "app"
);

----------- TEST DATA INSERTS -----------------------------------

INSERT INTO "user"("username", "password", "org_name", "background", "phone", "contact_name", "admin") 
VALUES
('admin', '$2a$10$3iBnDAz5DQ.qZjJrzIHUbe3OGJhQY/Zhgh8JSxdX27fOZWF78H17.', 'Results Foundation', 'Grant-giving non-profit.', '651-123-4567', 'Blaire Molitor', TRUE),
('chester@bowl.com', '$2a$10$oYihePWEyOXnwkQ8Me6v0e8DJhs4swzIh3R62TwdrAaaU3d26snbi', 'Chester Bowl', 'Year-round program providing fun outdoor activities for youth of all ages and from all socio-economic backgrounds.', '612-765-4321', 'Chester A. Bowl', FALSE),
('wonderwall@oasis.net', '$2a$10$VzSE4kSvqLqeugiJjLp8mOuanYh5F.8FKGak.cb6K85AyPD5yF2mO', 'The Oasis Foundation', 'Bringing music to underprivileged kids in Liverpool', '4553678923', 'Liam Gallagher', FALSE),
('greenthumb@localgardens.org', '$2a$10$t8msWoIPpRDSEAr6p8VJGuwO5oYfIO51dhQNl7IQji.1Sl3Ytd0sS', 'Local Gardens Initiative', 'Community garden initiative designed to teach kids about healthy eating', '2345678901', 'Sara Greenleaf', FALSE);

INSERT INTO "grant_window"("start_date", "end_date", "funds_available") 
VALUES
('2021-01-29', '2021-06-21', 20000), ('2020-01-29', '2020-06-21', 20000), ('2019-01-29', '2019-06-21', 20000);

INSERT INTO "focus_area"("focus") 
VALUES
('Education'), 
('Health'), 
('Mentorship'), 
('Housing');

INSERT INTO "review_status"("status") 
VALUES
('Accepted'), 
('Pending'), 
('Rejected');

INSERT INTO "app"("grant_window_id", "focus_area_id", "user_id", "budget") 
VALUES
(1, 3, 2, 2500),
(1, 1, 4, 1400),
(1, 2, 5, 2000);

INSERT INTO "question"("question_text") 
VALUES 
('Project Description or Description of Need'), 
('Goals and Objectives'), 
('Target Population'), 
('Timeline of Activities'), 
('How will you measure the use of funds issued by the grant?');

INSERT INTO "app_question"("app_id", "question_id", "answer_text")
VALUES 
(1, 1, 'Chester Bowl seeks to create a safe and fun way for children to experience the outdoors on a regular basis. Located in northern Minnesota, Chester Bowl has long been a staple of the community. Providing Summer Camp programs with scholarship opportunities in the Summer, as well as skiiing and snowboarding lessons on the hill in the winter.'), 
(1, 2, 'Our goal is to give today''s youth a safe place to be young and enjoy the wonderful things that nature in northern Minnesota has to offer.'), 
(1, 3, 'Teens & other youth.'), 
(1, 4, 'The activities these funds will be used for will take place over the winter months, from mid-October to the end of February.'), 
(1, 5, 'Success will be measured by ticket sales. If we can increase the amount of participants at Chester Bowl from last year this will be considered a successful use of funds.'),
(2, 1, 'The Oasis Foundation runs a 4-week rock and roll camp for kids without access to music education.'),
(2, 2, 'To spread education, inclusion and music'),
(2, 3, 'Teens from 13 - 17'),
(2, 4, 'January-March: Recruitment, April - June: Preparation, July: Camp, August: Evaluation, November: Planning for next year'),
(2, 5, 'Students and counselors will evaluate the program upon its completion.'),
(3, 1, 'This project turns abandoned urban spaces into community gardens '), 
(3, 2, 'To teach kids about healthy eating, plant care, and the value of investing in the community.'),
(3, 3, 'Children ages 6 and up'),
(3, 4, 'January: Acquisition of materials, February - March: Greenhouse growing, April: Beginning of community classes, May - August: gardening!, September: Harvest Party!'),
(3, 5, 'By the amount of contact our program is able to make with the community, bringing in gardeners, volunteers, and other organizations to help our garden grow.');