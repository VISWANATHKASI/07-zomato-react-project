# Use Node.js 16 slim as the base image
FROM node:19-alpine as stage1
# Set the working directory
WORKDIR /app
# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
# Install dependencies
RUN npm install --production
# Copy the rest of the application code
COPY . .
# Expose port 3000 (or the port your app is configured to listen on)
EXPOSE 3000


#using stage1 as image for final stage
FROM stage1 as final
# Copy the rest of the application code
COPY . .
# Build the React app
RUN npm run build
# Start your Node.js server (assuming it serves the React app)
CMD ["npm", "start"]
