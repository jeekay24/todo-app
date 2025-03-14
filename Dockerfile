# Use Node.js as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files from the project directory into the container
COPY . .

# Build the React app
RUN npm run build

# Use Nginx to serve the app
FROM nginx:alpine

# Copy the built React files to Nginx
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
