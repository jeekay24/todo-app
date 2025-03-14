# *Dockerize your React Web App*

1. Create the react app using "npx create-react-app my-todo-app"
 
2. Update all your code in your created folder

3. Create a Dockerfile and update it with the following code

#Use Node.js as the base image

FROM node:20

#Set the working directory inside the container

WORKDIR /app

#Copy package.json and package-lock.json

COPY package*.json ./

#Install dependencies

RUN npm install

#Copy all files from the project directory into the container

COPY . .

#Build the React app

RUN npm run build

#Use Nginx to serve the app

FROM nginx:alpine

#Copy the built React files to Nginx

COPY --from=0 /app/build /usr/share/nginx/html

#Expose port 80

EXPOSE 80

#Start Nginx server

CMD ["nginx", "-g", "daemon off;"]

4. Create a .dockerignore file to remove all the unwanted files to get loaded into the container
 
5. Build the docker image inside your CRA directory using the command "docker build -t my-todo-app ."
   
6. Run the docker container with the command "docker run -p 3000:80 my-todo-app
" and then go to http://localhost:3000 to see your app running inside Docker

7. If necessary use a docker compose file to build and run your app

8. If you want to run your app on any system, then build the docker image using "docker build -t my-todo-app .", save the image to a file using "docker save -o my-todo-app.tar my-todo-app", transfer it to another system via USB, Cloud etc and load it in another system using "docker load -i my-todo-app.tar" and run it using "docker run -p 3000:80 my-todo-app"

9. If you want to push it to docker hub and share it globally then use the commands
"docker tag my-todo-app your-dockerhub-username/my-todo-app",
"docker login",
"docker push your-dockerhub-username/my-todo-app"
and then on any system run
"docker pull your-dockerhub-username/my-todo-app",
"docker run -p 3000:80 your-dockerhub-username/my-todo-app"

Stay Tuned ! Happy Learning !!
