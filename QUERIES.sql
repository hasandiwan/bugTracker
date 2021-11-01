SELECT 
  first_name, 
  last_name, 
  role_id, 
  email 
FROM users;

SELECT name FROM roles;

SELECT 
  title, 
  description, 
  project_manager_id 
FROM projects;

SELECT 
  title, 
  description, 
  project_id, 
  lead_developer_id,
  priority,
  category
FROM tickets;

SELECT 
  ticket_id, 
  developer_id
FROM ticket_assignments;

SELECT
  ticket_id,
  user_id,
  message
FROM comments;