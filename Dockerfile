# First Stage: Build the Angular app
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Run tests (optional)
RUN npm run test -- --watchAll=false

# Build the Angular application
RUN npm run build --prod

# Second Stage: Serve the production build using Nginx
FROM nginx:alpine

# Copy the build from the first stage to the Nginx server
COPY --from=build /app/dist/my-angular-project /usr/share/nginx/html

# Expose port 80 to be used by Nginx
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
