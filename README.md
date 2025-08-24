## Requirements

### Must Have
- Store code snippets with syntax highlighting.  
- Categorize snippets using tags.  
- Full-text search across snippets (title, tags, content).  
- CRUD operations (create, read, update, delete).  
- User authentication (to protect access).  

### Should Have
- Organize snippets into folders or collections.  
- Support for multiple programming languages.  
- Responsive design for desktop and mobile.  
- Markdown support for notes/documentation.  

### Could Have
- Snippet version history.  
- Import/export snippets (JSON, Markdown, etc.).  

### Won’t Have (initially)
- Real-time collaboration between multiple users.  
- Public snippet sharing.  


## Database Schema

### users
| Field         | Type         | Notes                    |
|---------------|-------------|--------------------------|
| id            | BIGINT (PK) | Primary key              |
| name          | VARCHAR     |                          |
| email         | VARCHAR     | Unique                   |
| password_hash | VARCHAR     | Encrypted password       |
| created_at    | TIMESTAMP   |                          |
| updated_at    | TIMESTAMP   |                          |

### snippets
| Field       | Type         | Notes                              |
|-------------|-------------|------------------------------------|
| id          | BIGINT (PK) | Primary key                        |
| user_id     | BIGINT (FK) | References users.id                |
| title       | VARCHAR     | Snippet title                      |
| content     | TEXT        | Code snippet / markdown content    |
| language    | VARCHAR     | Programming language identifier    |
| created_at  | TIMESTAMP   |                                    |
| updated_at  | TIMESTAMP   |                                    |

### tags
| Field    | Type         | Notes           |
|----------|-------------|-----------------|
| id       | BIGINT (PK) | Primary key     |
| name     | VARCHAR     | Unique tag name |

### snippet_tag (pivot table)
| Field      | Type         | Notes                       |
|------------|-------------|-----------------------------|
| snippet_id | BIGINT (FK) | References snippets.id       |
| tag_id     | BIGINT (FK) | References tags.id           |
