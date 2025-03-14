cd [your local directory]
docker build -t php-card-distribution .
docker run -d -p 8080:80 php-card-distribution
Access the app at http://localhost:8080
