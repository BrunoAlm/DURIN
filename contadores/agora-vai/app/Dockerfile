# Use a imagem oficial do Flutter como base
FROM cirrusci/flutter:latest AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock files to the working directory
COPY pubspec.yaml pubspec.lock /app/

# Get dependencies
RUN flutter pub get

# Copy the rest of the application code to the working directory
COPY . /app/

# Build the Flutter web app
RUN flutter build web --release

# Use a smaller image for the final app
FROM nginx:alpine

# Copy the built app from the builder image to the NGINX web root
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose the default NGINX port
EXPOSE 80

# CMD to start NGINX
CMD ["nginx", "-g", "daemon off;"]
