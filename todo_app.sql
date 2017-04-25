
--Create user michael
DROP USER IF EXISTS michael;
CREATE USER michael WITH ENCRYPTED PASSWORD 'stonebreaker';

--Create database todo_app
DROP DATABASE IF EXISTS todo_app;
CREATE DATABASE todo_app;

--Create table tasks
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NULL,
  completed BOOLEAN NOT NULL);

--Delete completed column from tasks
ALTER TABLE tasks
DROP completed;

--Add completed_at column to tasks
ALTER TABLE tasks
ADD completed_at TIMESTAMP NULL DEFAULT NULL;

--Set any existing tasks updated_at which are null to 0
UPDATE tasks
SET updated_at = NOW()
WHERE updated_at IS NULL;

--Disable saving as null in updated_at
ALTER TABLE tasks
ALTER COLUMN updated_at SET NOT NULL;

--Drop default for tasks
ALTER TABLE tasks
ALTER COLUMN updated_at DROP DEFAULT;

--Change default for updated_at
ALTER TABLE tasks
ALTER COLUMN updated_at SET DEFAULT NOW();

--Insert new row without value selectors
INSERT INTO tasks
VALUES (DEFAULT, 'Study SQL', 'Complete this exercise', DEFAULT, DEFAULT, DEFAULT);

--Insert new row with value selectors
INSERT INTO tasks (title, description)
VALUES ('Study PostgreSQL', 'Read all the documentation');

--Get uncompleted tasks' titles
SELECT title
FROM tasks
WHERE completed_at IS NULL;

--Complete 'Study SQL'
UPDATE tasks
SET completed_at = NOW()
WHERE title = 'Study SQL';

--Get all tasks by descending creation date
SELECT *
FROM tasks
ORDER BY created_at DESC;

--Create a new task
INSERT INTO tasks(title, description)
VALUES ('mistake 1', 'a test entry');

--Create a new task
INSERT INTO tasks(title, description)
VALUES ('mistake 2', 'another test entry');

--Create a new task
INSERT INTO tasks(title, description)
VALUES ('third mistake', 'another test entry');

--LIKE searches with regex ('%' instead  of '/' to find a text match)
SELECT title
FROM tasks
WHERE title LIKE '%mistake%';

--Delete mistake 1
DELETE
FROM tasks
WHERE title = 'mistake 1';

--Show remaining mistakes
SELECT title, description
FROM tasks
WHERE title LIKE '%mistake%';

--Delete remaining mistakes
DELETE
FROM tasks
WHERE title LIKE '%mistake%';

--Show remaining entries by title in ascending order
SELECT *
FROM tasks
ORDER BY title ASC;