
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
ADD completed_at TIMESTAMP NULL
DEFAULT NULL;

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