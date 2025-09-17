# TaskFlow - AI-Powered Task Management Application

## Summary

TaskFlow is a modern, full-stack task management application that combines intuitive task organization with AI-powered productivity insights. Built with React, Node.js, and MongoDB, it features real-time task management, intelligent summaries using Google's Gemini AI, and a responsive design for seamless productivity tracking across all devices.

## Feature Overview

- **Task Management**: Create, edit, delete, and organize tasks with priorities, categories, and due dates
- **Smart Filtering**: Search and filter tasks by category, priority, completion status, and keywords
- **AI-Powered Summaries**: Generate intelligent daily productivity summaries using Google Gemini AI
- **Progress Tracking**: Visual statistics and progress bars to monitor productivity trends
- **User Authentication**: Secure JWT-based authentication system
- **Responsive Design**: Mobile-first design that works seamlessly across all devices
- **Real-time Updates**: Optimistic updates with server synchronization
- **Offline Capability**: Local storage fallback for offline functionality

## Tech Stack

### Frontend
- **React 18** with TypeScript
- **Vite** - Build tool and development server
- **Tailwind CSS** - Utility-first CSS framework
- **React Router** - Client-side routing
- **Lucide React** - Modern icon library
- **Axios** - HTTP client for API calls

### Backend
- **Node.js** with Express.js
- **MongoDB** with Mongoose ODM
- **JWT** - JSON Web Tokens for authentication
- **bcryptjs** - Password hashing
- **CORS** - Cross-origin resource sharing

### AI Integration
- **Google Generative AI (Gemini)** - AI-powered task summaries
- **@google/generative-ai** - Official Google AI SDK

### Development Tools
- **TypeScript** - Type safety
- **ESLint** - Code linting
- **Prettier** - Code formatting
- **Vite Dev Server** - Hot module replacement

## Key Features Implementation Status

### ✅ Fully Implemented
- [x] User registration and authentication
- [x] Complete CRUD operations for tasks
- [x] Task filtering and search functionality
- [x] Priority and category management
- [x] Due date tracking with overdue detection
- [x] AI-powered daily summaries
- [x] Progress statistics and visualization
- [x] Responsive mobile design
- [x] Local storage fallback
- [x] Server-client synchronization
- [x] Docker containerization for both frontend and backend
- [x] Production-ready container setup

### 🚧 Partially Implemented
- [ ] Weekly/Monthly summary reports (AI integration ready)
- [ ] Task collaboration features (backend ready)
- [ ] Email notifications for due dates

### 📋 Planned Features
- [ ] Docker Compose orchestration for multi-container deployment
- [ ] Task attachments and file uploads
- [ ] Calendar integration
- [ ] Team workspaces
- [ ] Advanced analytics dashboard
- [ ] Mobile app (React Native)

## Quick Start Guide

### Prerequisites
- **Node.js** (v16 or higher)
- **MongoDB** (local installation or MongoDB Atlas account)
- **Google Gemini API Key** (for AI summaries)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/sylvesterboris/taskflow.git
   cd taskflow
   ```

2. **Install dependencies**
   ```bash
   # Install server dependencies
   cd server
   npm install
   
   # Install client dependencies
   cd ../
   npm install
   ```

3. **Set up environment variables** (see Configuration section below)

4. **Start MongoDB**
   ```bash
   # If using local MongoDB
   mongod
   
   # Or use MongoDB Atlas connection string in .env
   ```

5. **Run the application**

   **Option A: Local Development**
   ```bash
   # Start the server (from project root)
   cd server
   npm run dev
   
   # In another terminal, start the client
   cd ..
   npm run dev
   ```

   **Option B: Docker Development**
   ```bash
   # Build and run backend
   cd server
   docker build -t taskflow-server .
   docker run -p 4000:4000 --env-file .env taskflow-server
   
   # In another terminal, build and run frontend
   cd ..
   docker build -t taskflow-client .
   docker run -p 5173:5173 --env-file .env taskflow-client
   ```

6. **Access the application**
   - Frontend: `http://localhost:5173`
   - Backend API: `http://localhost:4000`

## Configuration (.env)

### Server Environment Variables (`server/.env`)
```env
# Database Configuration
MONGO_URI=mongodb+srv://username:password@cluster0.mongodb.net/taskflow?retryWrites=true&w=majority

# JWT Secret (generate a secure random string)
JWT_SECRET=your_super_secure_jwt_secret_key_here

# Server Configuration
PORT=4000
NODE_ENV=development

# CORS Configuration
CLIENT_ORIGIN=http://localhost:5173
```

### Client Environment Variables (`.env`)
```env
# API Configuration
VITE_API_BASE_URL=http://localhost:4000

# Google Gemini AI Configuration
VITE_GEMINI_API_KEY=your_gemini_api_key_here
```

### Getting API Keys

1. **MongoDB Atlas**: 
   - Sign up at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
   - Create a cluster and get connection string

2. **Google Gemini API**:
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Generate an API key for Gemini

## Database Schema

### Collections Structure

```
taskflow/
├── users/
│   ├── _id: ObjectId
│   ├── name: String
│   ├── email: String (unique)
│   ├── passwordHash: String
│   ├── createdAt: Date
│   └── updatedAt: Date
│
├── tasks/
│   ├── _id: ObjectId
│   ├── userId: String (indexed)
│   ├── title: String
│   ├── description: String (optional)
│   ├── completed: Boolean
│   ├── priority: String (high|medium|low)
│   ├── category: String
│   ├── dueDate: Date (optional)
│   ├── createdAt: Date
│   └── updatedAt: Date
│
└── tasksummaries/
    ├── _id: ObjectId
    ├── userId: String (indexed)
    ├── date: String (YYYY-MM-DD)
    ├── summary: String
    ├── taskCount: Number
    ├── categories: Array[String]
    ├── completedTasks: Array[Object]
    ├── createdAt: Date
    └── updatedAt: Date
```

### Database Indexes
- `users.email`: Unique index for fast email lookups
- `tasks.userId`: Index for user-specific task queries
- `tasksummaries.userId + date`: Compound unique index for daily summaries

## API Endpoints

### Authentication Routes (`/api/auth`)
```http
POST /api/auth/register
Content-Type: application/json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securepassword"
}

POST /api/auth/login
Content-Type: application/json
{
  "email": "john@example.com",
  "password": "securepassword"
}
```

### Task Management Routes (`/api/tasks`)
```http
# Get all user tasks
GET /api/tasks
Authorization: Bearer <jwt_token>

# Create new task
POST /api/tasks
Authorization: Bearer <jwt_token>
Content-Type: application/json
{
  "title": "Complete project",
  "description": "Finish the TaskFlow application",
  "priority": "high",
  "category": "Work",
  "dueDate": "2024-12-31"
}

# Update task
PUT /api/tasks/:id
Authorization: Bearer <jwt_token>
Content-Type: application/json
{
  "completed": true
}

# Delete task
DELETE /api/tasks/:id
Authorization: Bearer <jwt_token>
```

### Summary Routes (`/api/summaries`)
```http
# Get all summaries
GET /api/summaries?limit=30
Authorization: Bearer <jwt_token>

# Get summary by date
GET /api/summaries/2024-01-15
Authorization: Bearer <jwt_token>

# Create/Update summary
POST /api/summaries
Authorization: Bearer <jwt_token>
Content-Type: application/json
{
  "date": "2024-01-15",
  "summary": "Productive day with 5 tasks completed...",
  "taskCount": 5,
  "categories": ["Work", "Personal"],
  "completedTasks": [...]
}

# Get date range summaries
GET /api/summaries/range/2024-01-01/2024-01-07
Authorization: Bearer <jwt_token>
```

### Health Check
```http
GET /health
Response: { "status": "ok" }
```

## Docker Architecture

The application is containerized using Docker with separate containers for the frontend and backend services.

### Docker Services

#### Frontend Container (`client/Dockerfile`)
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .
RUN npm run build

# Expose Vite development server port
EXPOSE 5173

# Start development server with host binding
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
```

#### Backend Container (`server/Dockerfile`)
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files  
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Expose backend API port
EXPOSE 4000

# Start the server
CMD ["npm", "start"]
```

### Container Configuration
- **Frontend**: Runs on port 5173 with Vite dev server
- **Backend**: Runs on port 4000 with Express server
- **Database**: Uses external MongoDB Atlas or local MongoDB
- **Base Image**: `node:18-alpine` for lightweight containers
- **Network**: Services communicate via Docker network or external URLs

### Running with Docker
```bash
# Build and run backend
cd server
docker build -t taskflow-server .
docker run -p 4000:4000 --env-file .env taskflow-server

# Build and run frontend  
docker build -t taskflow-client .
docker run -p 5173:5173 --env-file .env taskflow-client
```

## Project Structure

```
taskflow/
├── client/                     # Frontend React application (Dockerized)
│   ├── Dockerfile             # Frontend container configuration
│   └── src/                   # Source code moved to client directory
├── server/                     # Backend Node.js application (Dockerized)
│   ├── Dockerfile             # Backend container configuration  
│   ├── src/
│   │   ├── models/            # Mongoose schemas
│   │   │   ├── User.js
│   │   │   ├── Task.js
│   │   │   └── TaskSummary.js
│   │   ├── routes/            # Express route handlers
│   │   │   ├── auth.js        # Authentication routes
│   │   │   ├── tasks.js       # Task CRUD operations
│   │   │   └── summaries.js   # Summary management
│   │   ├── db.js             # Database connection
│   │   └── index.js          # Express server setup
│   ├── package.json
│   └── .env
│
├── src/                        # Frontend React application source
│   ├── components/            # Reusable UI components
│   │   ├── Header.tsx
│   │   ├── TaskCard.tsx
│   │   ├── TaskForm.tsx
│   │   ├── TaskSummaryModal.tsx
│   │   ├── SummaryDashboard.tsx
│   │   └── ...
│   ├── pages/                # Route-level components
│   │   ├── Dashboard.tsx
│   │   ├── Login.tsx
│   │   └── Register.tsx
│   ├── hooks/                # Custom React hooks
│   │   ├── useTasks.ts
│   │   └── useSummaries.ts
│   ├── context/              # React Context providers
│   │   └── AuthContext.tsx
│   ├── lib/                  # External service integrations
│   │   ├── axios.ts          # API client configuration
│   │   └── gemini.ts         # Google Gemini AI integration
│   ├── utils/                # Utility functions
│   │   └── helpers.ts
│   ├── types/                # TypeScript type definitions
│   │   └── index.ts
│   └── routes/               # Routing configuration
│       └── AppRouter.tsx
│
├── public/                     # Static assets
├── package.json               # Project dependencies
├── tailwind.config.js        # Tailwind CSS configuration
├── tsconfig.json             # TypeScript configuration
├── vite.config.ts            # Vite build configuration
└── .env                      # Environment variables
```

## Development Commands

### Essential Commands

```bash
# Development (Local)
npm run dev              # Start development server (Vite)
cd server && npm run dev # Start backend server with nodemon

# Building
npm run build           # Build production frontend
npm run preview         # Preview production build

# Code Quality
npm run lint           # Run ESLint
npm run lint:fix       # Fix ESLint issues
npm run type-check     # Run TypeScript compiler check

# Server Commands (from server directory)
cd server
npm run dev           # Start server with nodemon
npm start            # Start server in production mode
```

### Docker Commands

```bash
# Build Docker images
docker build -t taskflow-server ./server
docker build -t taskflow-client .

# Run containers individually
docker run -p 4000:4000 --env-file server/.env taskflow-server
docker run -p 5173:5173 --env-file .env taskflow-client

# Development with Docker
# Backend
cd server
docker build -t taskflow-server .
docker run -p 4000:4000 -v $(pwd):/app --env-file .env taskflow-server

# Frontend  
docker build -t taskflow-client .
docker run -p 5173:5173 -v $(pwd)/src:/app/src --env-file .env taskflow-client
```

### Database Commands
```bash
# MongoDB (if running locally)
mongod                # Start MongoDB daemon
mongo                 # Connect to MongoDB shell
mongodump             # Backup database
mongorestore          # Restore database
```

### Useful Development Scripts
```bash
# Clear all node_modules (from root)
rm -rf node_modules server/node_modules
npm install && cd server && npm install

# Reset local database (if using local MongoDB)
mongo taskflow --eval "db.dropDatabase()"

# Generate new JWT secret
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

### Environment Management
```bash
# Copy example environment files
cp .env.example .env
cp server/.env.example server/.env

# Validate environment variables
npm run env-check     # (if implemented)
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@taskflow.com or create an issue in this repository.

---

**TaskFlow** - Empowering productivity through intelligent task management. 🚀
